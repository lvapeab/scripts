#!/usr/bin/python
#  -*- coding: latin-1 -*-
import copy
import math
import logging
import codecs
import numpy as np
import sys

logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

infinity = float("inf")
zero = float(1e-999)


def replace_at_index(tup, ix, val):
    return tup[:ix] + (val,) + tup[ix + 1:]


def readSentences(sntFile):
    sentences = open(sntFile).readlines()
    Em = []
    En = []
    i = 0

    for line in sentences:
        line = line.split()
        if line[0] != '1':
            Em_snt = []
            En_snt = []
            if i % 3 == 1:
                for word in line:
                    En_snt += [int(word)]
                En.append(En_snt)
            elif i % 3 == 2:
                for word in line:
                    Em_snt += [int(word)]
                Em.append(Em_snt)
        i += 1
    return (Em, En)


def readAlignmentsFr2En(alignmentFileName):
    # Returns a list of dictionaries:
    # The list is indexed by the french word.
    #	Dictionaries' keys are the english words. Values are the probabilities.
    # E.g: list[21] == {32:0.01}
    # This means that french word 21 is aligned with english word 32 with probability 0.01
    f_aligns = {}
    alignments = open(alignmentFileName).readlines()
    n_french_words = int(alignments[len(alignments) - 1].split()[0]) + 1
    align = [{}] * n_french_words
    prev_word = 1
    for line in alignments:
        line = line.split()
        french = int(line[0])
        english = int(line[1])
        prob = float(line[2])

        if french == prev_word:
            f_aligns[english] = prob
        else:
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
    for line in vcb:
        line = line.split()
        indx_dict[int(line[0])] = line[1]

    for word in index_sentence:

        if word == -1:
            sentence += '_eps_' + ' '
        else:
            sentence += indx_dict[word] + ' '
    return sentence


def createIndexDict(vcbFile):
    """
    Creates a dictionary {index: word}
    :param vcbFile:
    :return: Dictionary index -> words
    """

    indx_dict = {}
    vcb = open(vcbFile).readlines()
    for line in vcb:
        line = line.split()
        indx_dict[int(line[0])] = line[1]
    return indx_dict



def createWordDict(vcbFile):
    """
    Creates a dictionary {word: index}
    :param vcbFile: Mapping words to indices
    :return: Dictionary index -> words
    """

    indx_dict = {}
    vcb = open(vcbFile).readlines()
    for line in vcb:
        line = line.split()
        indx_dict[line[1]] = int(line[0])
    return indx_dict

def index2word(index_word, indx_dict):
    """
    Reads a word and a index to word dictionary and returns the words in the sentence
    :param index_sentence:
    :param vcbFile:
    :return:sentence
    """

    if index_word == -1 or index_word not in indx_dict.keys():
        return '_eps_'
    else:
        return indx_dict[index_word]




def get_list_alignments(alignmentFileName, src_word, src_vcb_file, trg_vcb_file):
    """
    Returns all the alignments that the trg_word has and its probabilities

    :param alignmentFileName: Alignment file from GIZA
    :param trg_word: Word of the query
    :param src_vcb_file: Mapping of indices -> src_words
    :param trg_vcb_file: Mapping of trg_words -> indices
    :return: list [(src_word, prob)]
    """


    # Dictionaries index -> word
    indx_dict_src = createIndexDict(src_vcb_file)
    indx_dict_trg = createIndexDict(trg_vcb_file)

    # Dictionaries word -> index
    word_dict_src = createWordDict(src_vcb_file)
    word_dict_trg = createWordDict(src_vcb_file)
    if use_giza_align != 1 :
        word_dict_src['UNK'] = -1
        word_dict_trg['UNK'] = -1

    src_word_indx = word_dict_src[src_word]

    alignments = readAlignmentsFr2En(alignmentFileName)
    #print alignments

    for key in alignments[src_word_indx].keys() :
        print indx_dict_trg[key], ' ', math.log(alignments[src_word_indx][key])

    return alignments [src_word_indx]


def get_list_alignments_from_file(alignmentFileName, src_file, src_vcb_file, trg_vcb_file):
    """
    Returns all the alignments that the trg_word has and its probabilities

    :param alignmentFileName: Alignment file from GIZA
    :param trg_word: Word of the query
    :param src_vcb_file: Mapping of indices -> src_words
    :param trg_vcb_file: Mapping of trg_words -> indices
    :return: list [(src_word, prob)]
    """
    f = open(src_file, 'r').readlines()


    words = f[0].split()
    # Dictionaries index -> word
    indx_dict_src = createIndexDict(src_vcb_file)
    indx_dict_trg = createIndexDict(trg_vcb_file)

    # Dictionaries word -> index
    word_dict_src = createWordDict(src_vcb_file)
    word_dict_trg = createWordDict(src_vcb_file)
    #if use_giza_align != 1 :
    #    word_dict_src['UNK'] = -1
    #    word_dict_trg['UNK'] = -1

    for src_word in words :
        if src_word in word_dict_src.keys() :
            #Word to index
            src_word_indx = word_dict_src[src_word]

        alignments = readAlignmentsFr2En(alignmentFileName)    #readAlignmentsFr2En(alignmentFileName) returns a list of dictionaries:
        # The list is indexed by the french word.
        #	Dictionaries' keys are the english words. Values are the probabilities.
        # E.g: list[21] == {32:0.01}
        # This means that french word 21 is aligned with english word 32 with probability 0.01


        for target_key in alignments[src_word_indx].keys() :

            print indx_dict_trg[target_key], ' ', math.log(alignments[src_word_indx][target_key])
            #logger.debug(str(indx_dict_trg[key]) + ' ' + str(math.log(alignments[src_word_indx][key])))


    return alignments [src_word_indx]

if __name__ == '__main__':

    if len(sys.argv) <= 2 :
        print 'UNK -99999999'
        exit (1)
    use_giza_align = int(sys.argv[1]) # Poner esto más elegante

    if use_giza_align == 1 :
        src_file = sys.argv[2]


    """
    if use_giza_align == 0 :
        if sys.argv[1] == 'UNK' :
            print 'UNK -99999999'
            exit (2)

    """
    task_names = (sys.argv[3],
                  sys.argv[4],
                  sys.argv[5])

    logger.info('Task names: \n\t' +
                task_names[0] + '\n \t' +
                task_names[1] + '\n \t' +
                task_names[2] + '\n' +
                'Using giza alignment:' + str(use_giza_align) + '\n'
                + 'Searching for word: ' + sys.argv[1] )
        # task_names = ('/home/alvaro/smt/tasks/xerox/enes/NMT/combined/giza/alignments_languages/en_es',
        #              '/home/alvaro/smt/tasks/xerox/enes/NMT/combined/giza/alignments_languages/en',
        #              '/home/alvaro/smt/tasks/xerox/enes/NMT/combined/giza/alignments_languages/es')


    sntFile = str(task_names[0])
    coocFile= str(task_names[0]) + '.cooc'
    alignments = task_names[0] + '.t3.final'
    vcbFile_fr = task_names[1] + '.vcb'
    vcbFile_en = task_names[2] + '.vcb'


    if use_giza_align == 1 :
        get_list_alignments_from_file(alignments, src_file, vcbFile_fr, vcbFile_en)

