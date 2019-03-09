import numpy as np
import matplotlib
import matplotlib.pyplot as plt
# sphinx_gallery_thumbnail_number = 2
from __builtin__ import enumerate

colormaps = ["BrBG_r","BuGn","BuGn_r","BuPu","BuPu_r","CMRmap","CMRmap_r","Dark2","Dark2_r","GnBu","GnBu_r","Greens","Greens_r","Greys","Greys_r","OrRd","OrRd_r","Oranges","Oranges_r","PRGn","PRGn_r","Paired","Paired_r","Pastel1","Pastel1_r","Pastel2","Pastel2_r","PiYG","PiYG_r","PuBu","PuBuGn","PuBuGn_r","PuBu_r","PuOr","PuOr_r","PuRd","PuRd_r","Purples","Purples_r","RdBu","RdBu_r","RdGy","RdGy_r","RdPu","RdPu_r","RdYlBu","RdYlBu_r","RdYlGn","RdYlGn_r","Reds","Reds_r","Set1","Set1_r","Set2","Set2_r","Set3","Set3_r","Spectral","Spectral_r","Vega10","Vega10_r","Vega20","Vega20_r","Vega20b","Vega20b_r","Vega20c","Vega20c_r","Wistia","Wistia_r","YlGn","YlGnBu","YlGnBu_r","YlGn_r","YlOrBr","YlOrBr_r","YlOrRd","YlOrRd_r","afmhot","afmhot_r","autumn","autumn_r","binary","binary_r","bone","bone_r","brg","brg_r","bwr","bwr_r","cool","cool_r","coolwarm","coolwarm_r","copper","copper_r","cubehelix","cubehelix_r","flag","flag_r","gist_earth","gist_earth_r","gist_gray","gist_gray_r","gist_heat","gist_heat_r","gist_ncar","gist_ncar_r","gist_rainbow","gist_rainbow_r","gist_stern","gist_stern_r","gist_yarg","gist_yarg_r","gnuplot","gnuplot2","gnuplot2_r","gnuplot_r","gray","gray_r","hot","hot_r","hsv","hsv_r","inferno","inferno_r","jet","jet_r","magma","magma_r","nipy_spectral","nipy_spectral_r","ocean","ocean_r","pink","pink_r","plasma","plasma_r","prism","prism_r","rainbow","rainbow_r","seismic","seismic_r","spectral","spectral_r","spring","spring_r","summer","summer_r","tab10","tab10_r","tab20","tab20_r","tab20b","tab20b_r","tab20c","tab20c_r","terrain","terrain_r","viridis","viridis_r","winter","winter_r"]

def heatmap(data, row_labels, col_labels, ax=None, size=40,
            cbar_kw={}, cbarlabel="", **kwargs):
    """
    Create a heatmap from a numpy array and two lists of labels.

    Arguments:
        data       : A 2D numpy array of shape (N,M)
        row_labels : A list or array of length N with the labels
                     for the rows
        col_labels : A list or array of length M with the labels
                     for the columns
    Optional arguments:
        ax         : A matplotlib.axes.Axes instance to which the heatmap
                     is plotted. If not provided, use current axes or
                     create a new one.
        cbar_kw    : A dictionary with arguments to
                     :meth:`matplotlib.Figure.colorbar`.
        cbarlabel  : The label for the colorbar
    All other arguments are directly passed on to the imshow call.
    """

    if not ax:
        ax = plt.gca()

    # Plot the heatmap
    im = ax.imshow(data, **kwargs)

    # Create colorbar
    cbar = ax.figure.colorbar(im, ax=ax, **cbar_kw)
    cbar.ax.set_ylabel(cbarlabel, rotation=-90,va="bottom", size=size)

    # We want to show all ticks...
    ax.set_xticks(np.arange(data.shape[1]))
    ax.set_yticks(np.arange(data.shape[0]))
    # ... and label them with the respective list entries.
    ax.set_xticklabels(col_labels)
    ax.set_yticklabels(row_labels, size=size)

    # Let the horizontal axes labeling appear on top.
    ax.tick_params(top=True, bottom=False, labeltop=True, labelbottom=False, size=size)

    # Rotate the tick labels and set their alignment.
    plt.setp(ax.get_xticklabels(), rotation=-45,
             ha="right", rotation_mode="anchor", size=size
             )

    # Turn spines off and create white grid.
    for edge, spine in ax.spines.items():
        spine.set_visible(False)

    ax.set_xticks(np.arange(data.shape[1]+1)-.5, minor=True)
    ax.set_yticks(np.arange(data.shape[0]+1)-.5, minor=True)
    ax.grid(which="minor", color="w", linestyle='-', linewidth=3)
    ax.tick_params(which="minor", bottom=False, left=False, size=size)

    return im, cbar


def annotate_heatmap(im, data=None, valfmt="{x:.2f}",
                     textcolors=["black", "white"],
                     threshold=None, **textkw):
    """
    A function to annotate a heatmap.

    Arguments:
        im         : The AxesImage to be labeled.
    Optional arguments:
        data       : Data used to annotate. If None, the image's data is used.
        valfmt     : The format of the annotations inside the heatmap.
                     This should either use the string format method, e.g.
                     "$ {x:.2f}", or be a :class:`matplotlib.ticker.Formatter`.
        textcolors : A list or array of two color specifications. The first is
                     used for values below a threshold, the second for those
                     above.
        threshold  : Value in data units according to which the colors from
                     textcolors are applied. If None (the default) uses the
                     middle of the colormap as separation.

    Further arguments are passed on to the created text labels.
    """

    if not isinstance(data, (list, np.ndarray)):
        data = im.get_array()

    # Normalize the threshold to the images color range.
    if threshold is not None:
        threshold = im.norm(threshold)
    else:
        threshold = im.norm(data.max())/2.

    # Set default alignment to center, but allow it to be
    # overwritten by textkw.
    kw = dict(horizontalalignment="center",
              verticalalignment="center")
    kw.update(textkw)

    # Get the formatter in case a string is supplied
    if isinstance(valfmt, str):
        valfmt = matplotlib.ticker.StrMethodFormatter(valfmt)

    # Loop over the data and create a `Text` for each "pixel".
    # Change the text's color depending on the data.
    texts = []
    for i in range(data.shape[0]):
        for j in range(data.shape[1]):
            kw.update(color=textcolors[im.norm(data[i, j]) > threshold])
            text = im.axes.text(j, i, valfmt(data[i, j], None), **kw)
            texts.append(text)

    return texts

optimizers = ["SGD", "SGD-momentum", "SGD-HD", "Adadelta", "Adadelta-HD", "Adam", "Adam-HD"]
learning_rates = ["1",  "0.5", "0.05", "0.01", "0.005", "0.001", "0.00005", "0.00001"]

xerox_enfr = np.array([
    # 1,   0.5,    0.05   0.01  0.005 0.001 0.00005 0.00001
    [0.,     0.,   46.7, 44.9,  44.6, 44.6, 44.6, 44.6], # SGD
    [0.,     0.,   46.6, 44.9, 45.5,  44.6, 44.6, 44.6], # SGD-momentum
    [0,      0.,   22.2, 46.8, 47.0,  44.6, 44.6, 44.6], # SGDHD
    [45.8, 45.1,   44.7, 44.6, 44.6, 44.6, 44.6, 44.6], # Adadelta
    [46.4,  45.2,   44.8, 44.6, 44.2,  44.6, 44.6, 44.6], # Adadelta-HD
    [0,      0.,     0., 0, 1.6,  11.4, 45.2, 44.5], # Adam
    [0,      0.,   0., 27.6, 42.7,  45.4, 45.8, 44.7], # Adam-HD
    ])


ted_enfr = np.array([
    # 1,   0.5,    0.05   0.01  0.005 0.001 0.00005 0.00001
    [0.0,  00.0,   00.0,  00.0, 00.0,  00.0, 00.0, 00.0], # SGD
    [0.0,  00.0,   00.0,  00.0, 00.0,  00.0, 00.0, 00.0], # SGD-momentum
    [0.0,  00.0,   00.0,  00.0, 00.0,  00.0, 00.0, 00.0], # SGDHD
    [0.0,  00.0,   00.0,  00.0, 00.0,  00.0, 00.0, 00.0], # Adadelta
    [0.0,  00.0,   00.0,  00.0, 00.0,  00.0, 00.0, 00.0], # Adadelta-HD
    [0.0,  00.0,   00.0,  00.0, 00.0,  00.0, 00.0, 00.0], # Adam
    [0.0,  00.0,   00.0,  00.0, 00.0,  00.0, 00.0, 00.0], # Adam-HD
    ])

europarl_enfr = np.array([
    # 1,   0.5,    0.05   0.01  0.005 0.001 0.00005 0.00001
    [0.0,  0.3,    9.3,  11.4,  26.6, 25.8, 25.2, 24.0], # SGD
    [0.0,  0.0,    0.,   1.0,   8.5,  24.8, 25.9, 25.7], # SGD-momentum
    [0.0,  5.9,   10.2, 25.4,  26.7, 25.9, 25.5, 25.2], # SGDHD
    [23.4, 24.6,  24.2, 23.9, 23.8, 23.7, 23.7, 23.7], # Adadelta
    [0.0, 0.0,  0.0, 0.0, 0.0, 0.0, 0.0, 0.0], # Adadelta-HD TODO
    [0.0,   0.0,   0.,  5.1,  12.4,  21.8, 23.6, 24.2], # Adam
    [0.0,   0.0,   0.0,  0.0,  0.0,  0.0, 0.0, 0.0], # Adam-HD TODO
    ])

ufal_enfr = np.array([
    # 1,   0.5,    0.05   0.01  0.005 0.001 0.00005 0.00001
    [0.,     8.1,   20.0, 41.8, 42.7, 41.7, 40.1, 40.0], # SGD
    [0.,     0.,    0.,   42.1, 45.5, 42.1, 41.2, 40.4], # SGD-momentum
    [0,      12.5,   17.5, 41.8, 42.7, 41.7, 41.4, 40.3], # SGDHD
    [43.3, 43.0,   41.2, 40.9, 40.1, 39.9, 39.9, 39.9], # Adadelta
    [43.3, 43.0,   41.2, 40.9, 40.1, 39.9, 39.9, 39.9], # Adadelta-HD 
    [0,      0.,   0.0, 14.4, 27.4, 42.4, 42.9, 42.4], # Adam
    [0,      0.,   0.00, 0, 15.3, 42.5, 42.8, 42.1], # Adam-HD
    ])


# fig, (ax, ax2) = plt.subplots(1, 2)
fig, ax = plt.subplots()
# for f, ax2plot in zip([xerox_ende, europarl_enfr], [ax, ax2]) :
im, cbar = heatmap(xerox_enfr, optimizers, learning_rates,
                   ax=ax, cmap="coolwarm_r", size=25,
                   cbarlabel="%BLEU", cbar_kw={'aspect': 15, 'fraction': 0.05})
annotate_heatmap(im, size=25, valfmt="{x:.1f}")
fig.tight_layout()
# plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1)
plt.show()
