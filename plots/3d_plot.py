from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
import numpy as np
import sys
import os
from scipy.interpolate import griddata
import argparse
os.environ["QT_QPA_PLATFORM_PLUGIN_PATH"] = "/usr/lib/x86_64-linux-gnu/qt5/plugins"


def parse_args():
    parser = argparse.ArgumentParser("Plot 3D data")
    parser.add_argument("-v", "--verbosity", action="store_true", dest="verbosity", help="Verbose?")
    parser.add_argument("-logx", "--log-scale-x", action="store_true", help="Apply logartigthmic scale to axis x")
    parser.add_argument("-logy", "--log-scale-y", action="store_true", help="Apply logartigthmic scale to axis y")
    parser.add_argument("-logz", "--log-scale-z", action="store_true", help="Apply logartigthmic scale to axis z")
    parser.add_argument("-f", "--data-file", required=True, type=str, help="File with data to plot")
    return parser.parse_args()


args = parse_args()

fig = plt.figure()
ax = fig.gca(projection='3d')

input_file = args.data_file

with open(input_file) as f:
    content = f.readlines()

content = [x.strip().split() for x in content]

X = np.asarray([c[0] for c in content], dtype='float32')
Y = np.asarray([c[1] for c in content], dtype='float32')
Z = np.asarray([c[2] for c in content], dtype='float32')


X = np.log(X) if args.log_scale_x else X
Y = np.log(Y) if args.log_scale_x else Y
Z = np.log(Z) if args.log_scale_x else Z

xi = np.linspace(X.min(),X.max(),100)
yi = np.linspace(Y.min(),Y.max(),100)
# VERY IMPORTANT, to tell matplotlib how is your data organized
zi = griddata((X, Y), Z, (xi[None,:], yi[:,None]))#, method='cubic')

xig, yig = np.meshgrid(xi, yi)
surf = ax.plot_surface(xig, yig, zi, cmap=cm.coolwarm, alpha=0.5)

plt.xlabel('lr')
plt.ylabel('C')
#plt.zlabel('Bleu')

plt.show()
