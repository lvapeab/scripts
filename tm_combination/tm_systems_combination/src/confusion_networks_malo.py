import copy
import math
import logging
import codecs
import numpy as np


logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)


out_dir = 'sentences'

infinity = float("inf")
zero = float(1e-999)

def replace_at_index(tup, ix, val):
    return tup[:ix] + (val,) + tup[ix+1:]
def readSentences(sntFile):

	sentences = open(sntFile).readlines()
	Em = []
	En = []
	i = 0

	for line in sentences :
		line = line.split()
		if line[0] != '1' :
			Em_snt = []
			En_snt = []
			if i % 3 == 1 :
				for word in line :
					En_snt += [int(word)]
				En.append(En_snt)
			elif i % 3 == 2 :
				for word in line :
					Em_snt += [int(word)]
				Em.append(Em_snt)
		i+=1
	return (Em, En)
def readAlignments(alignmentFileName) :
	# Returns a list of dictionaries:
	#	The list is indexed by the french word.
	#	Dictionaries' keys are the english words. Values are the probabilities.
	# E.g: list[21] == {32:0.01}
	# This means that french word 21 is aligned with english word 32 with probability 0.01
	f_aligns = {}
	alignments = open(alignmentFileName).readlines()
	n_french_words = int(alignments[len(alignments)-1].split()[0]) +1
	align = [{}]*n_french_words
	prev_word = 1
	for line in alignments:
		line=line.split()
		french = int(line[0])
		english= int(line[1])
		prob  = float(line[2])

		if french == prev_word :
			f_aligns[english] =  prob
		else :
			align[prev_word] = f_aligns
			prev_word = french
			f_aligns = {english: prob}
    align[prev_word] = f_aligns
	return align

def index2words(index_sentence, vcbFile):

    """
    Reads a sentence and a vcbFile and returns the words in the sentence
    :param index_sentence:
    :param vcbFile:
    :return:sentence
    """
    sentence = ''
    indx_dict = {}
    vcb = open(vcbFile).readlines()
    for line in vcb :
        line=line.split()
        indx_dict[int(line[0])] = line[1]

    for word in index_sentence :

        if word == -1 :
            sentence += '_eps_' + ' '
        else :
            sentence += indx_dict[word] + ' '
    return sentence


def createIndexDict(vcbFile) :
    indx_dict = {}
    vcb = open(vcbFile).readlines()
    for line in vcb :
        line=line.split()
        indx_dict[int(line[0])] = line[1]
    return indx_dict
def index2word(index_word, indx_dict):

    """
    Reads a word and a vcbFile and returns the words in the sentence
    :param index_sentence:
    :param vcbFile:
    :return:sentence
    """
    if index_word == -1 or index_word not in indx_dict.keys():
        return  '_eps_'
    else :
          return indx_dict[index_word]

def levenshtein(source, target):
    if len(source) < len(target):
        return levenshtein(target, source)

    # So now we have len(source) >= len(target).
    if len(target) == 0:
        return len(source)

    # We call tuple() to force strings to be used as sequences
    # ('c', 'a', 't', 's') - numpy uses them as values by default.
    source = np.array(tuple(source))
    target = np.array(tuple(target))

    # We use a dynamic programming algorithm, but with the
    # added optimization that we only need the last two rows
    # of the matrix.
    previous_row = np.arange(target.size + 1)
    for s in source:
        # Insertion (target grows longer than source):
        current_row = previous_row + 1

        # Substitution or matching:
        # Target and source items are aligned, and either
        # are different (cost of 1), or are the same (cost of 0).
        current_row[1:] = np.minimum(
                current_row[1:],
                np.add(previous_row[:-1], target != s))

        # Deletion (target grows shorter than source):
        current_row[1:] = np.minimum(
                current_row[1:],
                current_row[0:-1] + 1)

        previous_row = current_row

    return previous_row[-1]

def reorder(alignmentFileName,  sntFile,  vcbFile_em, vcbFile_en):
    """
    :param alignmentFileName: Giza alignments file
    :param cooc: Giza coocurrences file
    :param EmFile: Primary hypotheses file
    :param EnFile: Secondary hypotheses file
    :param sntFile: Sentences file in Giza format
    :return: List of reordered sentences
    1. Find, for each word \in E_n (en) which is the most probable alignment with the words \in E_m (em)
        1.1 If it is aligned with no one, --> -1
    2. If the word em has been already aligned with en, forbid it
    3. Sort En according the order of Em
        If two words \in En are aligned with the same word in Em, we keep the order of En
"""
    Em, En = readSentences((str(sntFile) + '.snt'))
    alignments = readAlignments(alignmentFileName)
    reorderedFile = []
    logger.info(' Reordering alignments')
    logger.debug('Direction: ' + str(sntFile))
    logger.debug('Em file: ' + str(vcbFile_em))
    logger.debug('En file: ' + str(vcbFile_en))
    indx_dict_em = createIndexDict(vcbFile_em)
    indx_dict_en = createIndexDict(vcbFile_en)
    #For all sentences in the corpus...
    for n_sentence in range(0,len(En)):
        logger.log(2,'===========================')
        en_sentence = En[n_sentence]
        em_sentence = Em[n_sentence]
        alignment = [-1]*(len(en_sentence)) #List where we store a tuple (pos_word_in_Em)
        index = 0
        # 1. Find, for each word \in E_n (en) which is the most probable alignment with the words \in E_m (em)
        already_aligned = [[]]*len(em_sentence)
        for en in en_sentence:
            #logger.debug(str(en) + ' / ' + str(len(alignments)))
            aligns = copy.copy(alignments[en]) #aligns: Dictionary of alignments for current En word
            max_prob= -1
            min_indx = -1
            min_e_word = -1
            n_aligns = 0
            current_alignment_index = 0
            while n_aligns < len(en_sentence) :
                for em_w_index in range(0, len(em_sentence)):
                    can_align = True
                    em = em_sentence[em_w_index]
                    if em in aligns.keys() :
                        #2. If the word em has been already aligned with en, forbid it
                        logger.log(1, str(en) + ' is in ' + str(already_aligned) + ' ?')
                        if en in already_aligned[em_w_index] :
                            #do not align and prevent it:
                            can_align = False
                            logger.log(1,'CANT ALIGN because of ' + str(en) + ' at position ' +
                            str(em_w_index) + ' (word ' + str(em) + ')')
                        else :
                            if aligns[em] > max_prob :
                                if em_w_index >= current_alignment_index :
                                    #Monotone alignments
                                    max_prob = aligns[em]
                                    min_indx = em_w_index
                                    current_alignment_index = min_indx
                                    can_align = True
                                else :
                                    can_align = False

                if em_w_index == len(em_sentence)-1 and can_align == False : #If we are not able to align with anyone,
                    alignment[index] = (-1, en, 1.)
                    n_aligns+=1
                    can_align = True
                    break
                if max_prob == -1 :
                    if index > 0 :  # Two words in En which are aligned to the same word
                                    # in Em are kept in the original order.

                        alignment[index] = (-alignment[index-1][0],en,0.)
                    else :
                        alignment[index] = (0, en, 0.)
                    n_aligns+=1
                    break
                elif can_align : #Assign the alignment
                    alignment[index] = (min_indx, en, max_prob)
                    #And update the aligned words
                    already_aligned[min_indx] =already_aligned[min_indx] + [en]
                    n_aligns+=1
                    logger.log(1,' already aligned: ' + str(already_aligned))
                    break

            index+=1

        #3. Sort En according the order of Em
        # If two words \in En are aligned with the same word in Em, we keep the order of En
        sorted_align = sorted(alignment, key=lambda tup: math.fabs(tup[0]))
        sorted_align_words = copy.copy(sorted_align)

        for index in range(0, len(sorted_align_words)) :
            em_word = em_sentence[sorted_align[index][0]]
            sorted_align_words[index] = replace_at_index(sorted_align_words[index], 0, index2word(em_word, indx_dict_en))
            sorted_align_words[index] = replace_at_index(sorted_align_words[index], 1, index2word(sorted_align[index][1], indx_dict_em))
        for index in range (0, len(sorted_align_words)-1) :
            if sorted_align_words[index][0] == sorted_align_words[index+1][0] :
            # In case of many-to-one connections in a of words in Em
            # in to a single word from En, we only keep the connection with the lowest alignment costs.
                if sorted_align_words[index][2] > sorted_align_words[index+1][2] :
                    sorted_align_words[index+1] = replace_at_index(sorted_align_words[index+1], 0,'_eps_')
                else :
                    sorted_align_words[index] = replace_at_index(sorted_align_words[index], 0,'_eps_')

        logger.log(2,' Sentence ' + str(n_sentence+1) +  ': ' + str(em_sentence))
        logger.log(2,' Sentence ' + str(n_sentence+1) +  ': ' + str(sorted_align))
        logger.log(2,' Sorted ' + str(n_sentence+1) +  ': ' + unicode.encode(unicode(sorted_align_words), 'utf-8'))
        reorderedFile.append(sorted_align_words)
    logger.info(' Alignments reordered')

    return reorderedFile


def buildConfusionNetworks(reorderings_full,n_system):
    """
    A Confusion Network (CN) G is a weighted directed graph
    with a start node, an end node, and word labels over its edges.
    The CN has the peculiarity that each path from the start node
    to the end node goes through all the other nodes. As shown in
    Figure 1, a CN can be represented as a matrix of words whose
    columns have different depths

    :param reorderings:
    :return: confusion_network
    """



    #Our confusion network will be a list of lists of lists, where:
    # CF[list]: list is a list of confusion networks, one for each test sentence
    # CF[list][list2]; List 2 is the confusion network of each test sentence. It is composed
    #                 by M lists (rows in the confusion matrix)
    # CF[list][list2][list3]; List 3 is a particular column of a CN (confusion_column at the code)


    """
    Starting from an initial state s_0, the primary hypothesis is the primary hypothesis is
    processed from left to right and a new state is produced for each word e_{n,i}.
    Then, an arc is created from the previous state to this state, for e_{n,i} and for all words
    (or the null word) aligned to e_{n,i}. If there are insertions following e_{n,i} (for example,
    "have some" in Fig. 3), the states and arcs for the inserted words are also created.
    """




    n_systems = len(reorderings_full)
    n_sentences = len(reorderings_full[0])
    logger.info(' Building confusion networks. Counting ' + str(n_systems+1) + ' systems')

    confusion_networks = [[]]*n_sentences
    for sentence_index in range(0, n_sentences) :
        logger.log(2,'Sentence: ' + str(sentence_index))
        #For each sentence in the test set
        for system_index in range(0, n_systems) :

            reorderings = copy.copy(reorderings_full[system_index])
            reordering = reorderings[sentence_index]
            try:
                f = codecs.open (out_dir + '/sentence_'+ str(sentence_index) + '_system_' + str(n_system) + '.CN', mode='r', encoding='utf-8')
                cn = f.readlines()
                f.close()
            except :
                cn = ['']*len(reordering)
            out = codecs.open (out_dir + '/sentence_'+ str(sentence_index) + '_system_' + str(n_system) + '.CN', mode='w', encoding='utf-8')

            state = -1
            len_reordering = len(reordering)
            while state < len_reordering -1:
                state+=1
                if len(cn) > state :
                    line = cn[state][:-1]
                else :
                    line = ''

                if reordering[state][0] == '_eps_' : #If it is an insertion...
                    """
                    However, a better correspondence can be achieved when we ensure that
                    identical words are aligned with each other. To this end, we com-
                    pute the edit distance alignment between all the insertions of the
                    secondary translations.
                    """
                    min_dist = infinity
                    min_word = reordering[state][1]
                    min_state = -1
                    min_prob = 0.0

                    for system_index2 in range(0, n_systems): #We look in all secondary systems
                        #Extract the reordered alignments of the system
                        reorderings2 = reorderings_full[system_index2]
                        reordering2 = reorderings2[sentence_index]

                        for state2 in range(0,len(reordering2)) :
                            if reordering[state2][0] == '_eps_' :  # We look in all insertions
                                #We compute the edit distance between all insertions
                                edit_dist = levenshtein(reordering[state2][1], min_word)
                                if  edit_dist < min_dist :
                                    min_dist = edit_dist #Minimum edit distance
                                    min_word = reordering[state2][1] # Word of the secondary hypothesis which provide the minium edit distance
                                    min_prob = reordering[state2][2]
                                    min_state = state2   # Index of the pair (hypothesis, word)
                    # Up to here, we've got the word that should be aligned
                    # We replace it now in the reordered alignments
                    reordering[state] = replace_at_index(reordering[state],1, min_word)
                    reordering[min_state] = ('_eps_',min_word, min_prob)#replace_at_index(reordering[state],0, min_word)
                    len_reordering = len(reordering)
                if reordering[state][0] != '' :
                    if reordering[state][0] == reordering[state][1] :
                        line = line.encode('utf-8') + ' ' + reordering[state][0] + ' ' + str(reordering[state][2]) + '\n'
                    else :
                        line = line.encode('utf-8') + ' ' + reordering[state][0] + ' ' + str(reordering[state][2]) + ' ' + reordering[state][1] + ' ' + str(reordering[state][2]) + '\n'
                    out.write(line.decode('utf-8'))
            out.close()
            lines = codecs.open (out_dir + '/sentence_'+ str(sentence_index) + '_system_' + str(n_system) + '.CN', mode='r', encoding='utf-8').readlines()
            out = codecs.open (out_dir + '/sentence_'+ str(sentence_index) + '_system_' + str(n_system) + '.CN', mode='w', encoding='utf-8')
            for line in lines :
                line = line.split()
                line_dict = {}
                for i in range(0, len(line)-1, 2) :
                    if line[i] in line_dict.keys() :
                        line_dict[line[i]] += float(line[i+1])
                    else :
                        line_dict[line[i]] = float(0.0)
                new_line = ''
                maxim = sum(float(item) for item in line_dict.values())
                if maxim == 0.0 :
                    maxim = 1.0
                for word in line_dict.keys():
                        new_line += word + ' ' + str(line_dict[word]/maxim) + ' '
                out.write(new_line + '\n')

            out.close()
    return

def decodeNetworks(n_systems, n_sentences, out_dir, output_file_prefix) :

    logger.info('Decoding confusion networks')
    for sentence_index in range(0, n_sentences) :
        logger.log(2,'Sentence: ' + str(sentence_index))
        #For each sentence in the test set
        for system_index in range(0, n_systems) :
            confusion_network = codecs.open (out_dir + '/sentence_'+ str(sentence_index) + '_system_' + str(system_index+1) + '.CN', mode='r', encoding='utf-8')
            outputFile= codecs.open(output_file_prefix + task_names[system_index][0][1] + '.hyp', mode = 'a', encoding= 'utf-8')
            logger.log(2,'Storing results in file ' + output_file_prefix + task_names[system_index][0][1] + '.hyp')
            sentence = ''
            sentence_prob = -infinity
            for line in confusion_network.readlines() :
                line = line.split()
                max_word = ''
                max_prob = -infinity
                for i in range(0, len(line), 2) :
                    word = line[i]
                    prob = float(line[i+1])
                    if prob > max_prob :
                        max_word = word
                        max_prob = prob
                if max_word != '' or max_word != '_eps_':
                    sentence += max_word + ' '
                #print max_prob
                sentence_prob += max_prob
            outputFile.write(sentence + '\n')
    outputFile.close()
    return



def viterbiScore(confusion_networks):

    """
    1-best score obtained from the CN
    :param confusion_network:
    :return: best path, value for this path
    """
    for confusion_network in confusion_networks:
        prev, score = [-infinity] * len(confusion_network), [-infinity] + [0.0] * len(confusion_network)
        for t in range(0,len(confusion_network)): #t: words in the sentence ("bfs")
            prev, score = score, prev
            for j in range(0, len(confusion_network[t])): #Iterates deep-first in a CN position ("dfs")
                score[j] = max([prev[i] +
                                confusion_network[i][j][2]
                               for i in range(0,len(confusion_network[t]))])
    return max( [score[i] for i in range(1,len(confusion_network[t]))] )
def viterbiPath(confusion_networks):

    scores = []
    paths = []
    for confusion_network in confusion_networks:
        prev, score = [0.0] * len(confusion_network), [0.0] * len(confusion_network)
        backpointer = [[None]*(len(confusion_network[0]))
                       for i in range(len(confusion_network)+1) ]

        for t in range(0, len(confusion_network)): #t: words in the sentence ("bfs")
            prev, score = score, prev
            for j in range(0, len(confusion_network[t])): #Iterates deep-first in a CN position ("dfs")
                score[j], backpointer[t][j] = max([(prev[t] +
                                confusion_network[t][i][2],i)
                               for i in range(0,len(confusion_network[t]))])
        score[len(confusion_network)-1], backpointer[len(confusion_network)][len(confusion_network[-1])-1] =\
            max([(score[i], i) for i in range(1,len(confusion_network[-1]))])

        path = [len(confusion_network[0])-1] #End node


        for t in range(len(confusion_network), -1,-1) :
            path.append(backpointer[t][path[-1]])
        path.reverse()
        paths.append(path)
        score = 0.0
        for node in range(0,len(path[1:-1])) :
            score += confusion_network[node][path[node]][2]
        scores.append(score)
    return (scores, paths)

def viterbiGreedyPath(confusion_network):
    scores = []
    paths = []
    sentences = ''
    n_systems = len(confusion_network)
    len_row = len(confusion_network[0][0])
    sentence = ''
    global_prob = 0.0
    for word_index in range(0, len_row) :
        max_prob = 0
        word = ''
        for system in range(0, n_systems) :
            print 'len row:', len_row, 'real:', len(confusion_network[system][2]),':',confusion_network[system][2]
            em = confusion_network[system][0]
            en = confusion_network[system][1]
            prob = confusion_network[system][2]
            if prob[word_index] > max_prob :
                max_prob = prob[word_index]
                word = en[word_index] #(Esto no lo tengo nada claro xD)
        sentence += str(word) + ' '
        global_prob += max_prob
    print sentence
    """
                          --------------------------------------- Em = sys 1 ---------------------   --------------------------------------- Em = sys 2 ---------------------
                             --------- Em system ---------  ------- En system(s) ---------  --probs--   --------- Em system ---------  ------- En system(s) ---------  --probs--
        confusion_network: [['Introducci\xc3\xb3n', 'vii'], ['Introducci\xc3\xb3n', 'vii'], [1.0, 1.0], ['Introducci\xc3\xb3n', 'vii'], ['Introducci\xc3\xb3n', 'vii'], [1.0, 1.0]]

    """
    return (scores, paths, sentences)

def voteConfusionNetwork(confusion_networks):
    """
    We sum up the probabilities of the arcs which are labeled with the same word
    and have the same start and the same end state.
    These probabilities are the global probabilities assigned to the different MT systems.
    They are manually adjusted based on the performance of the involved MT systems on a held-out development set.
    In general, a better consensus translation can be produced if the words hypothesized by a better-performing
    system get a higher probability. Additional scores like word confidence measures can
    be used to score the arcs in the lattice.

    :param confusion_network:
    :return:
    """

    i=0
    #print confusion_networks
    for confusion_network in confusion_networks :
        #score, path, sentence = viterbiGreedyPath(confusion_network)
        i+=1
        #sentence = extractSequenceOfWords(sentence_CN, path[0][1:-1])
        #print sentence

if __name__ == '__main__':




    testFile = 'nmt'
    f  = open(testFile)
    #task_names format: [(em_en, em, en)]

    task_names = [
                  [('alignments/xerox_nmt_thot', 'alignments/xerox_nmt', 'alignments/xerox_thot'),
                  ('alignments/xerox_nmt_moses', 'alignments/xerox_nmt', 'alignments/xerox_moses')],

                  [('alignments/xerox_moses_thot','alignments/xerox_moses', 'alignments/xerox_thot'),
                  ('alignments/xerox_moses_nmt' , 'alignments/xerox_moses', 'alignments/xerox_nmt')],

                  [('alignments/xerox_thot_nmt',  'alignments/xerox_thot', 'alignments/xerox_nmt'),
                   ('alignments/xerox_thot_moses','alignments/xerox_thot', 'alignments/xerox_moses')]
                ]

    """



    task_names = [[('alignments/xerox_moses_thot','alignments/xerox_moses', 'alignments/xerox_thot')
                  ],

                  [('alignments/xerox_thot_moses','alignments/xerox_thot', 'alignments/xerox_moses')]
                ]

    """
    sntFile = []
    confusion_network = [[]] *len(task_names)

    a = 0
    i = 0
    M = len(task_names)
    for em in range(0,M) :
        reorders = []
        for en in range(0,len(task_names[em])):
            #sntFile.append(str(task_names[em][en][0]))
            sntFile = str(task_names[em][en][0])
            coocFile= str(task_names[em][en][0]) + '.cooc'
            alignments = task_names[em][en][0] + '.t3.final'
            vcbFile_em = task_names[em][en][1] + '.vcb'
            vcbFile_en = task_names[em][en][2] + '.vcb'


            #print task_names[em][en][0], '---> ', vcbFile_em, vcbFile_en

            reorders.append(reorder(alignments, sntFile, vcbFile_em, vcbFile_en))
        a += 1
        buildConfusionNetworks(reorders, a)

    decodeNetworks(M, len(f.readlines()), 'sentences','hyp/' )