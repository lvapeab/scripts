import argparse
import os

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.pyplot import cm
from pycocoevalcap.sentence_bleu.sentence_bleu import SentenceBleuScorer

os.environ["QT_QPA_PLATFORM_PLUGIN_PATH"] = "/usr/lib/x86_64-linux-gnu/qt5/plugins"


def parse_args():
    parser = argparse.ArgumentParser("Computes the BLEU sentence-by-sentence from two given files.")
    parser.add_argument("-v", "--verbosity", action="store_true", dest="verbosity", help="Verbose?")
    parser.add_argument("-t", "--hypotheses", required=True, nargs='+', help="Hypotheses file.")
    parser.add_argument("-r", "--references", required=True, help="References file.")

    parser.add_argument("-a", "--analyze", required=False, default=True, help="Analyze the results.")

    return parser.parse_args()


args = parse_args()

# Open new data
references = open(args.references, 'r')
references_lines = references.read().split('\n')
references.close()
references_lines = references_lines[:-1] if references_lines[-1] == '' else references_lines
n_lines = len(references_lines)

n_systems = len(args.hypotheses)

color = iter(cm.rainbow(np.linspace(0, 1, n_systems)))

for hypothesis_filename in args.hypotheses:
    c = next(color)

    hypotheses = open(hypothesis_filename, 'r')
    system_name = hypothesis_filename
    hypotheses_lines = hypotheses.read().split('\n')
    hypotheses.close()

    hypotheses_lines = hypotheses_lines[:-1] if hypotheses_lines[-1] == '' else hypotheses_lines
    assert len(hypotheses_lines) == len(references_lines), 'Number of hypotheses and references must match'

    sentence_scorer = SentenceBleuScorer('')

    scoring_list = [{}] * n_lines

    for i, (hypothesis, reference) in enumerate(zip(hypotheses_lines, references_lines)):
        sentence_scorer.set_reference(str(reference).split())
        bleu_score = sentence_scorer.score(hypothesis.split())

        scoring_list[i] = {
            'hypothesis': hypothesis,
            'reference': reference,
            'len_hypothesis': len(hypothesis.split()),
            'len_reference': len(reference.split()),
            'bleu': bleu_score
        }

    if args.analyze:
        bleu_scores = np.asarray([sample['bleu'] for sample in scoring_list])
        len_ratios = np.asarray([sample['len_hypothesis'] / float(sample['len_reference']) for sample in scoring_list])
        print "BLEU %s:" % system_name
        print "\t Arithmetic mean:", np.mean(bleu_scores)
        print "\t Var:", np.var(bleu_scores)
        print "\t Stdev:", np.std(bleu_scores)

        n, bins, patches = plt.hist(bleu_scores,
                                    bins=50,
                                    rwidth=0.9,
                                    alpha=1 / float(n_systems + 1),
                                    label=str(system_name) + '(Mean BLEU: %.2f)' % np.mean(bleu_scores),
                                    color=c)

        d = np.digitize(bleu_scores, bins) # Get the bin of each sentence
        print list(d)
        print list(bins)

plt.legend(loc='upper right')
plt.xlabel('%Bleu')
plt.ylabel('#Sentences')
plt.title(r'$\mathrm{Histogram\ of\ BLEUS}$')
plt.grid(True)


plt.show()
