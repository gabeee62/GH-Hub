import json

newBlankPlot: dict = {
    "owner": 0,
    "name": "N/A",
    "dateClaimed": "N/A",
    "dimension": "N/A",
    "coordinates": [(0, 0), (0, 0)]
}

plots: list[dict] = json.loads(
    open(file="v1.0\Database\Plots\Plots.json").read())


def claim_check(newPlot: dict, config: dict) -> bool:

    plots: list[dict] = json.loads(
        open("v1.0\Database\Plots\Plots.json").read())
    for plot in plots:
        if plots["dimension"] == newPlot["dimension"]:
            extendedBounds: list[tuple] = [(), ()]


def claim(plot: dict, config: dict):
    if claim_check(plot):
        pass


def default():
    pass


def delete(executor: str, plot: dict):
    if executor == plot.owner:
        pass


def search(owner='', coords=(0, 0, 150), dimension='') -> list[dict]:
    filteredPlots: list = []
    pass
