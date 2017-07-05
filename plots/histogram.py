import argparse
import os

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.pyplot import cm

os.environ["QT_QPA_PLATFORM_PLUGIN_PATH"] = "/usr/lib/x86_64-linux-gnu/qt5/plugins"


def parse_args():
    parser = argparse.ArgumentParser("Makes a histogram with the provided data.")
    parser.add_argument("-v", "--verbosity", action="store_true", dest="verbosity", help="Verbose?")
    parser.add_argument("-d", "--data", required=True, nargs='+', help="Data to plot.")
    parser.add_argument("-b", "--bins", required=False, default=50,
                        help="Number of bins of histogram. Default: 50")
    parser.add_argument("-x", "--x-label", required=False, default='x_axis',
                        help="X-axis label")
    parser.add_argument("-y", "--y-label", required=False, default='y_axis',
                    help="y-axis label")
    parser.add_argument("-t", "--title", required=False, default='data',
                    help="Title label")
    return parser.parse_args()


args = parse_args()

# Open new data

n_systems = len(args.data)

color = iter(cm.rainbow(np.linspace(0, 1, n_systems)))

for n_system, data_filename in enumerate(args.data):
    c = next(color)
    hypotheses = open(data_filename, 'r')
    system_name = data_filename
    hypotheses_lines = hypotheses.read().split('\n')
    hypotheses.close()
    print hypotheses_lines
    scores = hypotheses_lines[:-1] if hypotheses_lines[-1] == '' else hypotheses_lines
    scores_to_plot = np.asarray([float(score) for score in scores])
    print "%s:" % system_name
    print "\t Arithmetic mean:", np.mean(scores_to_plot)
    print "\t Var:", np.var(scores_to_plot)
    print "\t Stdev:", np.std(scores_to_plot)
    n, bins, patches = plt.hist(scores_to_plot,
                                bins=args.bins,
                                rwidth=0.9,
                                alpha=1 / float(n_systems + 1),
                                label=str(system_name) + ' (Mean %s: %.2f)' % (args.title, np.mean(scores_to_plot)),
                                color=c)

plt.legend(loc='upper right')
plt.xlabel(args.y_label)

plt.ylabel(args.y_label)
plt.title(r'$\mathrm{Histogram\ of\ %s}$' % str(args.title))
plt.grid(True)


plt.show()
