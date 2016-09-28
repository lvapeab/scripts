#!/bin/bash

METEORPATH=/home/lvapeab/smt/software/meteor-1.4
JANEBIN=/home/lvapeab/smt/software/jane/bin
SRILM=/home/lvapeab/smt/software/srilm/bin/i686-m64

BASEDIR=/home/lvapeab/smt/tasks/xerox/enes/COMB/jane
DATADEV=${BASEDIR}/data/dev
DATATEST=${BASEDIR}/data/test
DEV=${BASEDIR}/meteor_dev4_bigLM
TEST=${BASEDIR}/meteor_test4_bigLM
IBM=${BASEDIR}/data/ibm1

ORI_DIR=/home/lvapeab/smt/tasks/xerox/enes/DATA

cd $DEV
rm -rf mert
mkdir mert
cd mert

$JANEBIN/startMERToptSystemCombination.sh     \
--lambda                   ${DEV}/lambda.init \
--alignmentInput      ${DEV}/meteor.alignment \
--segInput                         ${DEV}/seg \
--lm                  ${DEV}/openFST.3gram.lm \
--symTable                      ${DEV}/lm.sym \
--amountSingleSystems                       3 \
--alignmentInputTest ${TEST}/meteor.alignment \
--segInputTest                    ${TEST}/seg \
--lmTest             ${TEST}/openFST.3gram.lm \
--symTableTest                 ${TEST}/lm.sym \
--reference                 ${ORI_DIR}/dev.es \
--reorderingLevel                          1  \
--biglm             ${DEV}/openFST.bigLM.4.lm \
--biglmTest        ${TEST}/openFST.bigLM.4.lm 
# --originalSource            ${ORI_DIR}/dev.en \
#--ibmT2S                  ${IBM}/inverse.ibm1 \
#--ibmS2T                   ${IBM}/direct.ibm1 

# --clean 0 