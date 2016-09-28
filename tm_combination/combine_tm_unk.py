import sys

main_tm_filename = sys.argv[1]
backoff_tm_filename = sys.argv[2]
unk_counts_filename = sys.argv[3]
max_unks = int(sys.argv[4])

if len(sys.argv) > 4 :
	verbose = True
	print >> sys.stderr, "I'm being verbose"
else :
	verbose = False


main_tm = file(main_tm_filename).readlines()
backoff_tm = file(backoff_tm_filename).readlines()
unk_counts = file(unk_counts_filename).readlines()


#Harcoded
debug = open('debug', 'w')
nmt=0

for i in range(0, len(unk_counts)) :
	if int(unk_counts[i]) > max_unks :  #or len(main_tm[i])>20: #Use phrase-based MT
		print backoff_tm[i][:-1]
		if verbose :
			debug.write("pb\n")
	
	else : #Use neural MT
		print main_tm[i][:-1]
		if verbose :
			debug.write("nmt\n")
			nmt+=1

if verbose :
	print >> sys.stderr,"NMT translations:",nmt,"/",len(unk_counts), "(",nmt*100./len(unk_counts),"%)"
	print >> sys.stderr,"Phrase-based translations:",len(unk_counts)-nmt,"/",len(unk_counts), "(",(len(unk_counts)-nmt)*100./len(unk_counts),"%)"
	





