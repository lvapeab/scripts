import argparse
import os

import matplotlib.pyplot as plt
import numpy as np
from matplotlib.pyplot import cm

os.environ["QT_QPA_PLATFORM_PLUGIN_PATH"] = "/usr/lib/x86_64-linux-gnu/qt5/plugins"

# Initialize the figure
plt.style.use('seaborn-darkgrid')

# create a color palette
palette = plt.get_cmap('Set1')

def parse_args():
    parser = argparse.ArgumentParser("Makes a lines with the provided data.")
    parser.add_argument("-v", "--verbosity", action="store_true", dest="verbosity", help="Verbose?")
    parser.add_argument("-d", "--data", required=True, nargs='+', help="Data to plot.")
    parser.add_argument("-x", "--x-label", required=False,default=None,
                        help="X-axis label")
    parser.add_argument("-y", "--y-label", required=False, default=None,
                    help="y-axis label")
    parser.add_argument("-t", "--title", required=False, default=None,
                    help="Title label")
    return parser.parse_args()


args = parse_args()

# Open new data

n_systems = len(args.data)
color = iter(cm.rainbow(np.linspace(0, 1, n_systems)))
fig, ax = plt.subplots()

for n_system, data_filename in enumerate(args.data):
    c = next(color)
    system_name = data_filename
    coords = open(data_filename, 'r').read().split('\n')
    coords = coords[:-1] if coords[-1] == '' else coords
    x = np.asarray(map(lambda x_: x_.split()[0], coords), np.float32)
    y = np.asarray(map(lambda y_: y_.split()[1], coords), np.float32)
    if len(coords[0].split()) > 2:
        ci = np.asarray(map(lambda z_: z_.split()[2], coords), np.float32)
    else:
        ci = None
    print "%s:" % system_name
    print "\t Arithmetic mean: x = ", np.mean(x), "y = ", np.mean(y)
    print "\t Var: x = ", np.var(x), "y = ", np.var(y)
    print "\t Stdev x = ", np.std(x), "y = ", np.std(y)

    if ci is not None:
        # plot the shaded range of the confidence intervals
        ax.fill_between(x, y-ci, y+ci, color=c, alpha=.3)
        # plot the mean on top
        ax.plot(x, y, label=str(system_name))
    else:
        ax.plot(x, y, color=c, label=str(system_name))

# plt.legend(loc='upper right')
if args.x_label is not None:
    ax.set_xlabel(args.x_label)
if args.y_label is not None:
    ax.set_ylabel(args.y_label)


# Add title
if args.title is not None:
    ax.set_title(str(args.title), loc='left', fontsize=12, fontweight=0, color=palette(1))
ax.set_facecolor('white')
fig.tight_layout()
# plt.grid()

plt.show()
