import csv
from Classes import plot as PlotClass


def claim(plot):
    pass


def default():
    pass


def delete(executor: str, plot: PlotClass.Plot):
    if executor == plot.owner:
        pass


def search(owner='', coords=(0, 0, 150), dimension='') -> list[PlotClass.Plot]:
    filteredPlots: list = []
    with open(file='../../Database/Plots/plots.csv') as plots:
        reader = csv.reader(plots, delimiter=' ')
        for row in reader:
            pass
