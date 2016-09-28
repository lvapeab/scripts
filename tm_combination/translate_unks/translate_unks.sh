#!/bin/bash

SRILM_DIR=/home/alvaro/smt/software/srilm/bin/i686-m64
THOT_DIR=/home/alvaro/smt/software/thot/bin/

AWK=/usr/bin/awk
SORT=/usr/bin/sort
PYTHON=/usr/bin/python
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


usage(){
    echo "Usage: change_unks -i <trans1> [-o <output>] [-v] [-tmp <string>]  "
    echo " -i    <string>       : File with sentences generated by the main TM."
    echo " -o <string>        : Output file (default, standard output)."
    echo " -v                   : Verbose mode."
    echo "-tmp <string>         : Temporary directory where data is stored"
}


str_is_option()
{
    echo "" | ${AWK} -v s=$1 '{if(!match(s,"-[a-zA-Z]")) print "0"; else print "1"}'
}


input=""
input_given=0
output=""
verbose_opt=0
tmp="."

while [ $# -ne 0 ]; do
 case $1 in
     "--help") usage
         exit 0
         ;;
  

     "-i") shift
         if [ $# -ne 0 ]; then
             input=$1
	     input_given=1
         else
             input_given=0
         fi
         ;;

     "-o") shift
         if [ $# -ne 0 ]; then
             output=$1
         else
             output=""
         fi
         ;;
     
     "-tmp") shift
         if [ $# -ne 0 ]; then
             tmp=$1
         else
             tmp="."
         fi
         ;;


     "-v") verbose_opt=1
         ;;

    esac
    shift
done

#### Verify parameters                                                                                                                        


if [ ${input_given} -eq 0 ]; then
    # invalid parameters                                                                                                                      
    echo "Error: -i option not given"
    exit 1
fi
#Parameters are OK         

IFS=''
echo -n "" > $output
while read  sentence; do
    echo "${sentence}" | grep  "UNK_\w*" -o |cut -d _ -f 2 > ${tmp}/unk_words
    edited_sentence=`echo ${sentence}`
    while read  unk_word; do
	translation=`${THOT_DIR}/thot_client -i 127.0.0.1 -t "${unk_word}"`
	edited_sentence=`echo "${edited_sentence}" | sed "0,/UNK_\w*/s/UNK_\w*/${translation}/"`
	if [ $verbose_opt -eq 1 ]; then
	    echo "Unkown word \"$unk_word\" translated to \"$translation\""
	    echo "Old sentence:"
	    echo "$sentence"
	    echo "Edited sentence:"
	    echo "${edited_sentence}"
	    echo ""
	fi
    done <${tmp}/unk_words
    echo "${edited_sentence}" >> $output
done<${input}