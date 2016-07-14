import sys

main_tm_filename = sys.argv[1]
backoff_tm_filename = sys.argv[2]
main_ppls_filename = sys.argv[3]
backoff_ppls_filename = sys.argv[4]
unk_counts_filename = sys.argv[5]
max_unks = int(sys.argv[6])


if len(sys.argv) > 6 :
	verbose = True
	print >> sys.stderr, "I'm being verbose"
else :
	verbose = False


main_tm = file(main_tm_filename).readlines()
backoff_tm = file(backoff_tm_filename).readlines()
main_ppls = file(main_ppls_filename).readlines()
backoff_ppls = file(backoff_ppls_filename).readlines()
unk_counts = file(unk_counts_filename).readlines()




#Harcoded
debug = open('debug', 'w')
nmt=0

for i in range(0, len(main_tm)) :
	if float(backoff_ppls[i]) < float(main_ppls[i]) or (int(unk_counts[i]) > max_unks):  #or len(main_tm[i])>20: #Use phrase-based MT
		print backoff_tm[i][:-1]
		if verbose :
			debug.write("pb\n")
	
	else : #Use neural MT
		print main_tm[i][:-1]
		if verbose :
			debug.write("nmt\n")
			nmt+=1

if verbose :
	print >> sys.stderr,"NMT translations:",nmt,"/",len(main_tm), "(",nmt*100./len(main_tm),"%)"
	print >> sys.stderr,"Phrase-based translations:",len(main_tm)-nmt,"/",len(main_tm), "(",(len(main_tm)-nmt)*100./len(main_tm),"%)"
