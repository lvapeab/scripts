import numpy as np
import sys


if len(sys.argv) != 3 :
    print 'usage create_corpus_from_vocab vocabulary_npz output_file'
    sys.exit (1)
vocab = np.load(sys.argv[1])['unique_words']
out = open(sys.argv[2], 'w')

i = 0
for i in range(0, len(vocab)) :
	
    out.write(vocab[i])
    out.write('\n')
    if i % 100 == 0 :
        sys.stdout.write ('.')
    if i % 1000 == 0:
        sys.stdout.write (str(i))
sys.stdout.write ('\n')
out.close()
