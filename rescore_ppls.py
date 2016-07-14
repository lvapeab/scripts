#!/usr/bin/env python                                                                                                                                      

import sys

ppls_file = sys.argv[1]
rescored_file = sys.argv[2]
output_file = sys.argv[3]

print "PPLs filename (from SRILM):", ppls_file
print "Rescored log_probabilities:", rescored_file

print "reading PPL file"
ppls = file(ppls_file).readlines()

print "reading rescored file"
rescored = file(rescored_file).readlines()
scores = []
i=0
for score in rescored :
    scores.append(score[:-1])
    i+=1


print "Opening output file: ", output_file
out_f = open(output_file, 'w')

i = 0


for line in ppls:
    splitted = line.split()
    #print len(splitted)," --- ", splitted
    if len(splitted) >3 :
        if splitted[2]=="logprob=" :
            splitted[3] = scores[i]            
            i+=1          
            out_f.write(reduce(lambda x, y: x + " " +y, splitted))
        else :
            out_f.write(line)

print "Closing file ", output_file
out_f.close()
