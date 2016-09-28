#$ -l h_rt=144:00:00
export BASEDIR=${HOME}/smt/tasks/ue/esen
export TM=${BASEDIR}/THOT/tuned/tm/main/src_trg
export LM=${BASEDIR}/THOT/tuned/lm/main/trg.lm
export TEST=/home/lvapeab/smt/tasks/ue/esen/DATA/test.es
export REF=/home/lvapeab/smt/tasks/ue/esen/DATA/test.en
export E=2
export S=8
export W=0.4
export A=7
export U=10
# export NOMON=0
# export BE="-be"
# export SP=3
export USE_NBEST_OPT=1
export OPT_NVALUE=200
export NON_NEG_CONST="0 1 0 1 1 1 1 1"
export MINIMIZE=${HOME}/smt/software/thot_github/bin/thot_dhs_min
export CURRDIR=${BASEDIR}/EXPER/5gram/test
export TEMPDIR=$CURRDIR/
export OUTPREF=$CURRDIR/adjw                                                                      
export TRGFUNC_SMT=$HOME/smt/software/thot_github/bin/thot_dhs_smt_trgfunc  
export PHRDECODER=$HOME/smt/software/thot_github/bin/thot_pbs_dec  
export ADD_DEC_OPTIONS="-pr 120"
export QS="-l h_vmem=2g,h_rt=2:00:00"
export CFGFILE=/home/lvapeab/smt/tasks/ue/esen/THOT/tuned/tuned_for_dev.cfg

$MINIMIZE -tdir $TEMPDIR -va 0 -0 -0 0 -0 -0 -0 -0 -ftol 0.0001 -o ${OUTPREF} -u ${TRGFUNC_SMT} -debug -v
