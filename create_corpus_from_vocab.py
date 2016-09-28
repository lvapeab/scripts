import numpy as np
import pickle
import sys


if len(sys.argv) != 4 :
    print 'usage create_corpus_from_vocab corpus_fille output_file vocabulary_pickle'
    sys.exit (1)
f = open(sys.argv[1]).readlines()
out = open(sys.argv[2], 'w')
vocab = pickle.load( open( sys.argv[3], "rb" ) )
i = 0
for line in f :
    i+=1
    if i % 1000 == 0 :
        print 'Line',i, '...'
    
    line=line.split()
    for word in line :
        if word not in vocab.keys() :
            out.write('UNK' + ' ')
        else :
            out.write(word + ' ')
    out.write('\n')
    

out.close()
