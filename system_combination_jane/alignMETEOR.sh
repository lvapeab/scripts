#!/bin/bash


METEORPATH=/home/lvapeab/smt/software/meteor-1.4
JANEBIN=/home/lvapeab/smt/software/jane/bin
SRILM=/home/lvapeab/smt/software/srilm/bin/i686-m64
BASEDIR=/home/lvapeab/smt/tasks/xerox/enes/COMB/jane
DEV=${BASEDIR}/data/dev
TEST=${BASEDIR}/data/test
BIG_LM=${BASEDIR}/data/4gram


rm -rf ${BASEDIR}/meteor_dev4_bigLM;
mkdir ${BASEDIR}/meteor_dev4_bigLM;
cd ${BASEDIR}/meteor_dev4_bigLM


$JANEBIN/scripts/prepareMETEOR.sh --lan es --prep 0 \
--ngramcount /usr/local/bin/ngramcount \
--ngramread /usr/local/bin/ngramread \
--ngrammerge /usr/local/bin/ngrammerge \
--ngram $SRILM/ngram \
--ngramcount $SRILM/ngram-count \
--ngramOrder 4 \
--fstprint /usr/local/bin/fstprint \
--meteor $METEORPATH/meteor-1.4.jar \
--bigLM $BIG_LM \
${DEV}/moses ${DEV}/thot ${DEV}/nmt 


cd ..
rm -rf  ${BASEDIR}/meteor_test4_bigLM;
mkdir  ${BASEDIR}/meteor_test4_bigLM;
cd  ${BASEDIR}/meteor_test4_bigLM

$JANEBIN/scripts/prepareMETEOR.sh --lan es --prep 0 \
--ngramcount /usr/local/bin/ngramcount \
--ngramread /usr/local/bin/ngramread \
--ngrammerge /usr/local/bin/ngrammerge \
--ngram $SRILM/ngram \
--ngramcount $SRILM/ngram-count \
--ngramOrder 4 \
--fstprint /usr/local/bin/fstprint \
--meteor $METEORPATH/meteor-1.4.jar \
--bigLM $BIG_LM \
${TEST}/moses ${TEST}/thot ${TEST}/nmt