#!/bin/bash

export LD_LIBRARY_PATH=/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/home/lvapeab/lib64:/home/lvapeab/bin:/home/apps/ompi/1.6.4/gnu/lib:/home/apps/oge/lib/linux-x64:/opt/intel/mkl/lib/intel64:/opt/intel/composer_xe_2013/lib/intel64/:/home/lvapeab/smt/software/boost_1_56_0/lib:/usr/lib64:/home/lvapeab/libexec/gcc/x86_64-unknown-linux-gnu/4.9.1/:${LD_LIBRARY_PATH}

CSLMDIR=/home/lvapeab/smt/software/cslm/cslm_v2.0/src
SCRIPTDIR=/home/lvapeab/smt/software/scripts/rescoring/moses
utildir=/home/lvapeab/smt/software/thot_github/utils
AWK=/usr/bin/awk
SORT=/usr/bin/sort
sortpars="-S 131072"
sortT="yes"
sortm="yes"
SPLIT=/usr/bin/split
SED=/bin/sed
GREP=/bin/grep
SED=/bin/sed
UNIQ=/usr/bin/uniq
BASENAME=/usr/bin/basename
SSH=/usr/bin/ssh
HEAD=/usr/bin/head
TAIL=/usr/bin/tail
MKTEMP=/bin/mktemp
QSUB=/home/apps/oge/bin/linux-x64/qsub
QSUB_WORKS="yes"
QSUB_TERSE_OPT=""
QSTAT=/home/apps/oge/bin/linux-x64/qstat
QRLS=/home/apps/oge/bin/l/qrls



usage(){
    echo "Usage: weightAdj -tdir <sdir> -u <string> -va <float> ... <float> [-bdir <string>][-iv <float> ... <float>] [-pr <int>] [-qs <string>] [-sdir <string>] -wgdir <string> -o <string> [-v] [-debug] [-name <string>]"
   
    echo " -tdir <string>       : Absolute path of a directory for storing temporary"
    echo " -weights <string>    : Absolute path of a file where the log-linear model weights are"
    echo " -nbdir <string>      : Absolute path where n-best lists from wordgraphs are."
    echo " -pr <int>            : Number of processors used to compute the target function (Default 1)"
    echo "-qs <string>                    Specific options to be given to the qsub"
    echo "                                command (example: -qs \"-l pmem=1gb\")."
    echo ""
    echo "-name <string>        : Set suffixes for the task."

    echo "-sdir <string>                  Absolute path of a directory common to all"
    echo "                                processors. If not given, the directory for"
    echo "                                temporaries will be used (/tmp or the "
    echo "                                directory given by means of the -T option)."
    echo ""
    echo " -v                   : Verbose mode."
    echo " -debug               : After ending, do not delete temporary files"
    echo " --help               : Display this help and exit."
    echo " -o <string>          : Set output files prefix name."
}

str_is_option()
{
    echo "" | ${AWK} -v s=$1 '{if(!match(s,"-[a-zA-Z]")) print "0"; else print "1"}' 
}


exclude_readonly_vars()
{
    ${AWK} -F "=" 'BEGIN{                                                                                                                                    
                         readonlyvars["BASHOPTS"]=1                                                                                                          
                         readonlyvars["BASH_VERSINFO"]=1                                                                                                     
                         readonlyvars["EUID"]=1                                                                                                              
                         readonlyvars["PPID"]=1                                                                                                              
                         readonlyvars["SHELLOPTS"]=1                                                                                                         
                         readonlyvars["UID"]=1                                                                                                               
                        }                                                                                                                                    
                        {                                                                                                                                    
                         if(!($1 in readonlyvars)) printf"%s\n",$0                                                                                           
                        }'
}


exclude_bashisms()
{
    $AWK '{if(index($1,"=(")==0) printf"%s\n",$0}'
}

write_functions()
{
 for f in `${AWK} '{if(index($1,"()")!=0) printf"%s\n",$1}' $0`; do
        $SED -n /^$f/,/^}/p $0                                                                                                                                       
done
    
}

create_script()
{
    # Init variables                                                                                                                                         
    local name=$1
    local command=$2

    # Write environment variables                                                                                                                            
    set | exclude_readonly_vars | exclude_bashisms > ${name}

    # Write functions if necessary                                                                                                                           
    $GREP "()" ${name} -A1 | $GREP "{" > /dev/null || write_functions >> ${name}

    # Write PBS directives                                                                                                                                   
    echo "#PBS -o ${name}.o\${PBS_JOBID}" >> ${name}
    echo "#PBS -e ${name}.e\${PBS_JOBID}" >> ${name}
    echo "#$ -cwd" >> ${name}

    # Write command to be executed                                                                                                                           
    echo "${command}" >> ${name}

    # Give execution permission                                                                                                                              
    chmod u+x ${name}
}






rerank_nbest()
{
    echo "** Processing of chunk $SDIR/${fragm} (started at "`date`")..." >> ${output}.log


    dest=$SDIR/${fragm}
    # Empty previous eventually not empty corpus                                                                                                             
    while read -r nbl; do
        # Extract sentences from nbl
	${SCRIPTDIR}/deformat.sh $nbl ${nbl}.form
	${CSLMDIR}/nbest -i $nbl.form -o $nbl.rescored --sort --recalc --weights $WEIGHTS
	${SCRIPTDIR}/format.sh $nbl.rescored $nbl.reranked
    done <${dest}

    # Write date to log file                                                                                                                                 
    echo "Processing of chunk ${fragm} finished ("`date`")" >> ${output}.log
              
    echo "" > ${SDIR}/rerank_nbest_${fragm}_end
}




merge()
{
    # merge nbest file
    cat `ls -l  ${NBDIR}/*.reranked  |awk '{print $9}'|sort -V`>  ${OUT}.reranked.nbl
    #gzip  ${OUT}.reranked.nbl
    echo ""-n > ${OUT}.corpus
    for nbl in  `ls -l  ${NBDIR}/*.reranked  |awk '{print $9}'|sort -V`; do
	head -n 1  ${nbl} | awk  'BEGIN{ FS ="\\|\\|\\|"} ; { print$2;} '|tr -s " "  | sed -e 's/^[ \t]*//'>> ${OUT}.corpus
    done
    echo " Merged files from ${NBDIR} \/*.reranked into ${OUT}.reranked.nbl  ("`date`")" >> ${output}.log
    echo " Corpus stored in  ${OUT}.corpus  ("`date`")" >> ${output}.log

    echo "" > $SDIR/merge_end

}


launch()
{
    local file=$1
    ### qsub invocation                                                                                                                                      
    if [ "${QSUB_WORKS}" = "no" ]; then
        $file &
    else
        local jid=$($QSUB ${QSUB_TERSE_OPT} ${QS_OPTS} $file | ${TAIL} -1)
    fi
    ###################                                                                                                                                      


}

sync()
{
    local files="$1"
    end=0
    while [ $end -ne 1 ]; do
        sleep 3
        end=1
        for f in ${files}; do
            if [ ! -f ${f}_end ]; then
                end=0
                break
            fi
        done
    done
}


 


tdir=""
sdir=""
init_vals=""
task=""
va_given=0
o_given=0
u_given=0
pr_given=0
wg_given=0
qs_given=0
bdir_given=0
iv_opt=""
verbose_opt=""
ftol_opt=""
r_opt=""
debug=""
b_dir=""
tmpdir=""
weights=""
w_given=0








while [ $# -ne 0 ]; do
 case $1 in
        "--help") usage
            exit 0
            ;;
        "-tdir") shift
            if [ $# -ne 0 ]; then
                tmpdir=$1                
            else
                tmpdir=""
            fi
            ;;
        "-name") shift
            if [ $# -ne 0 ]; then
                task=$1
            else
                task=""
            fi
            ;;


     "-o") shift
            if [ $# -ne 0 ]; then
                outpref=$1
                o_given=1
            else
		o_given=0
		    fi
            ;;




     "-weights") shift
            if [ $# -ne 0 ]; then
                weights=$1
                w_given=1
		    else
                w_given=0
                    fi
            ;;

     "-nbdir") shift
            if [ $# -ne 0 ]; then
                NBDIR=$1
                nb_given=1
            else
		nb_given=0
		    fi
            ;;

        "-pr") shift
            if [ $# -ne 0 ]; then
		num_hosts=$1
                pr_given=1
            else
		num_hosts="1"
                pr_given=0
            fi
            ;;
        "-qs") shift
            if [ $# -ne 0 ]; then
                qs_opts=$1
                qs_given=1
            else
                qs_given=0
            fi
            ;;

           
        "-debug") debug="-debug"
            ;;
        "-v") verbose_opt="-v"
            ;;
    esac
    shift
done

#### Verify parameters



if [ ${o_given} -eq 0 ]; then
    # invalid parameters 
    echo "Error: -o option not given"
    exit 1
fi
if [ ${nb_given} -eq 0 ]; then
    # invalid parameters                                                                                                                                     
    echo "Error: -nbdir option not given"
    exit 1
fi

if [ ${w_given} -eq 0 ]; then
    # invalid parameters                                                                                                                                                                                             
    echo "Error: -weights option not given"
    exit 1
fi


echo "Parameters are OK"

# create TMP directory
TMP="${tmpdir}/${task}_reranking_$$"
mkdir -p  $TMP || { echo "Error: temporary directory cannot be created" ; exit 1; }

# create shared directory
if [ -z "$sdir" ]; then
    # if not given, SDIR will be the same as $TMP
    SDIR=$TMP

    # remove temp directories on exit
    if [ "$debug" != "-debug" ]; then
        trap "rm -rf $TMP 2>/dev/null" EXIT
    fi
else
    SDIR="${sdir}/${task}_sdir_reranking_$$"
    mkdir -p $SDIR || { echo "Error: shared directory cannot be created" ; exit 1; }
    
    # remove temp directories on exit
    if [ "$debug" != "-debug" ]; then
        trap "rm -rf $TMP $SDIR 2>/dev/null" EXIT
    fi
fi

export NHOSTS=${num_hosts}
export QS_OPTS=${qs_opts}
export NBDIR=${NBDIR}
export SDIR=${SDIR}
export TMP=${TMP}
export WEIGHTS=${weights}
export TASK=${task}
export OUT=${outpref}
# create log file
output=${TMP}/${TASK}
mkdir -p `dirname ${OUT}`
echo "Log file: ${output}.log"
echo "*** Parallel process of file $a3_file started at: " `date` >> ${output}.log
echo "">> ${output}.log

# process the input           
# fragment the input                                                                                                          
echo "Spliting directory..." >> ${output}.log

input_size=`ls -l ${NBDIR}/*.nbl | wc -l`
if [ ${input_size} -lt ${NHOSTS} ]; then
    echo "Error: problem too small"
    exit 1
fi
frag_size=`expr ${input_size} / ${NHOSTS}`
frag_size=`expr ${frag_size} + 1`
nlines=${frag_size}

ls -l ${NBDIR}/*.nbl |awk '{print $9}'|sort -V|split -l $nlines - ${SDIR}/${TASK}frag\_ ||exit 1

# parallel estimation for each fragment                                                                                                                     \
                                                                                                                                                           
i=1
for f in `ls $SDIR/${TASK}frag\_*`; do
    fragm=`basename $f`   
    create_script ${SDIR}/rerank_nbest_${fragm} rerank_nbest
    launch ${SDIR}/rerank_nbest_${fragm}
    
    i=`expr $i + 1`
    qs_change_lm_nbl="${qs_change_lm_nbl} ${SDIR}/rerank_nbest_${fragm}"
done

### Check that all queued jobs are finished                                                                                                                 \
sync "${qs_change_lm_nbl}"

# finish log file                                                                                                                                           \
                                                                                                                                                             
echo "">> ${output}.log
echo "*** Parallel process finished at: " `date` >> ${output}.log

# Merge nbest lists

                                                                                                                                                                                 
create_script $SDIR/merge merge
launch $SDIR/merge


echo "Process finished at:" `date`>>${output}.log