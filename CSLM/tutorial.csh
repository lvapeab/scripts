#!/bin/csh
#
# Short tutorial on how to run the CSLM
# Holger Schwenk
#
# $Id: tutorial.csh,v 1.6 2014/03/24 16:42:52 coetmeur Exp schwenk $
#
# This script is not intended to be a perfect training script which checks all
# possible reasons of failure or achieves the best possible results with the given data
# It's just a little example to get you running. 
# Feel free to adapt and improve ...

# we will build an LM for English
set l=en	# target language

#
# all the tools that we need
#
# from SRILM
set ngram=ngram
set ngram_count=ngram-count
# from the CSLM toolkit
set V=SET_TO_YOUR_INSTALL_DIRECTORY
set text2bin=$V/text2bin
set cslm_train=$V/cslm_train
set cslm_eval=$V/cslm_eval
set multibleu=multi-bleu.perl
set nbest=$V/nbest

foreach p ($ngram $ngram_count $text2bin $cslm_train $cslm_eval)
  which $p >& /dev/null
  if ($status) then
    echo "ERROR: the following program is missing, please verify the installation:"
    echo $p; exit(1)
  endif
end

# create some directories
set ddir=data
set cddir=data.cslm
set lmdir=lm
set ndir=nbest
foreach d ($ddir $cddir $lmdir $ndir)
  if (! -d $d) then
    echo " - creating directory $d"
    mkdir -p $d
  endif
end

#
# in our exemple we use nc7 and eparl7 to train the models
# newstest2010 as development data and newstest2011 as test data
# 
# For convenience these corpora are provided in the package
# tokenized with the standard Moses tools
# You can get these corpora here:
#   http://www.statmt.org/wmt12/dev.tgz
#   http://www.statmt.org/wmt12/training-monolingual-news-commentary.tgz .
#   http://www.statmt.org/wmt12/training-monolingual-europarl.tgz

set train=(nc7 eparl7 )
set dev=(newstest2010)
set test=(newstest2011)

#
# create the vocabulary of all the words in the training data
# You may want to use a different technique if you have large amounts of data ...
#
set vocab=all
if (! -f $lmdir/$vocab.vocab) then
  echo "Creating word list:"
  cat < /dev/null > $lmdir/$vocab.$l
  foreach c ($train)
    echo " - adding $c.$l.gz"
    zcat $ddir/$c.$l.gz >> $lmdir/$vocab.$l
  end
  foreach c ($dev $test)
    echo " - adding $c.$l"
    cat $ddir/$c.$l >> $lmdir/$vocab.$l
  end
  gzip $lmdir/$vocab.$l
  $ngram_count -order 1 -text $lmdir/$vocab.$l.gz -write-vocab $lmdir/$vocab.vocab
  echo " -> `wc -l < $lmdir/$vocab.vocab` words"
endif

#
# build an interpolated 4-gram back-off LM 
# this is our baseline
#
set lmipol=all_ipol.4g.kn-int.arpa.gz
if (! -f $lmdir/$lmipol) then
  echo "Creating back-off LM"
  foreach c ($train)
    set lm=$c.4g.kn-int.sblm
    if (! -f $lmdir/$lm) then
      echo " - $lm"
      $ngram_count -order 4 -unk -vocab $lmdir/$vocab.vocab -text $ddir/$c.$l.gz -interpolate -kndiscount -gt1min 1 -gt2min 1 -gt3min 1 -gt4min 2 -lm $lmdir/$lm -write-binary-lm
      if ($status) then
        echo "ERROR: failed"; exit(1)
      endif
    endif
    #if (! -f $lmdir/$lm:r.ppl) then 
    #  $ngram -order 4 -unk -debug 2 -lm $lmdir/$lm -ppl $ddir/$dev.$l > $lmdir/$lm:r.ppl
    #endif
    #echo " - baseline perplexities of ${lm}:"
    #foreach c ($dev $test)
    #  echo -n " - ${c}: "
    #  $ngram -order 4 -unk -lm $lmdir/$lm -ppl $ddir/$c.$l | tail -1 | awk '{print $6}'
    #end
  end

  echo "Interpolating the LMs on $dev"
  # The coefficients must be obviously recalculated using compute-best-mix
  # if you change the LMs or the dev data
  #    compute-best-mix $lmdir/eparl7.4g.kn-int.ppl $lmdir/nc7.4g.kn-int.ppl 
  $ngram -unk -order 4 -lm $lmdir/eparl7.4g.kn-int.sblm -lambda 0.491907 -mix-lm $lmdir/nc7.4g.kn-int.sblm \
	-write-lm $lmdir/$lmipol
endif

#
# evaluate our baseline LM, normally you should get:
#   - newstest2010: 343.986
#   - newstest2011: 376.565
#
echo "\n*** baseline perplexities of ${lmipol}: ***\n"
foreach c ($dev $test)
  echo -n " - ${c}: "
  #$ngram -order 4 -unk -lm $lmdir/$lmipol -ppl $ddir/$c.$l | tail -1 | awk '{print $6}'
end

#
# binarize the LM data for the CSLM
#

echo "\n*** Binarizing data with wordlist $vocab ***\n"
foreach f ($train)
  set fv=$f.wl$vocab
  if (! -f $cddir/$fv.btxt) then
    zcat $ddir/$f.$l.gz | $text2bin $lmdir/$vocab.vocab $cddir/$fv.btxt $cddir/$fv.wlist $cddir/$fv.oov
  endif
end
foreach f ($dev $test)
  set fv=$f.wl$vocab
  if (! -f $cddir/$fv.btxt) then
    cat $ddir/$f.$l | $text2bin $lmdir/$vocab.vocab $cddir/$fv.btxt $cddir/$fv.wlist $cddir/$fv.oov
  endif
end

#
# train the CSLM
#

# you have the choice of a couple of models
# approximate training times are given for one epoch
#  - on 2x Intel E5-2680 (total of 16 cores @ 2.7Ghz)
#    with Intel MKL 11.1 Update 2
#  - and on GPU Nvidia Tesla K20x
#
# The learning rate, network initialization and the data mode was changed in comparison
#  to the previous tutorial V2. With data mode 0, the CSLM also processes short n-grams.

# 1) simple_model, cpu=117s, gpu=84s, dev px=327.97
#     small model for fast training
#     this network is too small to fully benefit from GPUs
# 3) larger_model, cpu=465s, gpu=194s, dev px=331.78
#     larger short list gives better coverage
#     the perplexity is worse since we don't have enough data to train the large model
# 4) deep_model, cpu=550s, gpu=263s, dev px=334.37
#     an example of a deep architecture
#

foreach m (simple_model larger_model deep_model)
  if (! -f $m.best.mach) then
    echo "\nTraining the CSLM $m"
    $cslm_train --conf $m.conf --mach $m.mach >& $m.log
    if ($status) then
      echo "ERROR: $cslm_train failed"; exit(1)
    endif
  endif

  # calculate perplexity of the CSLM on the test data
  #
  echo "\n*** Evaluate CSLM $m on the test data $test ***\n"
  # add -B 4096 to go faster with big networks on GPUs
  $cslm_eval -m $m.best.mach -l $lmdir/$lmipol -t test.df
  if ($status) then
    echo "ERROR: $cslm_eval failed"; exit(1)
  endif
end

# you should get with simple_model.best.mach (trained on CPU)
# - 77836 4-gram requests, 0=0.00% short n-grams, 27736=35.63% by back-off LM, 50100=64.37% predicted by CSLM
#      cslm px=18.08, ln_sum=-457361.00, overall px=356.37
#
# and with larger_model.best.mach
# - 77836 4-gram requests, 0=0.00% short n-grams, 13165=16.91% by back-off LM, 64671=83.09% predicted by CSLM
#      cslm px=86.01, ln_sum=-458049.16, overall px=359.53
#
# deep_model.best.mach
# - 77836 4-gram requests, 0=0.00% short n-grams, 13165=16.91% by back-off LM, 64671=83.09% predicted by CSLM
#      cslm px=87.19, ln_sum=-458632.91, overall px=362.24


#
# rescore some dummy n-best list
#

set m=simple_model

set nbf=$dev
set lmpos=8	# 8: replace current LM score, 0: add a new score (so both can ne log-linearly interplated)
echo "\n*** Rescore an n-best list ***\n"
$nbest --input-file $ndir/$nbf.nbest.gz --output-file $ndir/$nbf.cslm.nbest.gz \
       --lm $lmdir/$lmipol -p $lmpos --cslm $m.best.mach -v $cddir/nc7.wl$vocab.wlist
if ($status) then
  echo "ERROR: $nbest failed"; exit(1)
endif

#
# Examples how to extract the solution from an n-best list
#

echo "\n*** Extract default 1-best solution ***\n"
$nbest --input-file $ndir/$nbf.nbest.gz --output-file nbest1 --outn 1
cut -d'|' -f 4 nbest1 > $ndir/solution.1best
$multibleu $ddir/$dev.$l < $ndir/solution.1best
# you should get BLEU=23.00

# the difference  in the lines is that we recalculate the global score using the provided weights
# after sorting this may give a different first hypothesis
# In a real application you may want to retune the coefficient using MERT, etc

echo "\n*** Extract best solution after rescoring ***\n"
$nbest --input-file $ndir/$nbf.cslm.nbest.gz --output-file nbest1 --outn 1 \
	--recalc --sort --weights $ndir/weights.txt
cut -d'|' -f 4 nbest1 > $ndir/solution.cslm
$multibleu $ddir/$dev.$l < $ndir/solution.cslm
# you should get BLEU=23.41 with the CSLM "simple_model"
#            and BLEU=23.42 with the CSLM "larger_model"
#            and BLEU=23.33 with the CSLM "deep_model"

# With an CSLM carefully trained on the same data than the back-off LM, you can usually expect a gain
# of 1-2 points BLEU, in particular with deep architectures

/bin/rm nbest1

