import json

newMemberPlot: dict = {
    "owner": 0,
    "name": "N/A",
    "dateClaimed": "N/A",
    "dimension": "N/A",
    "coordinates": [(0, 0), (0, 0)]
}

newGroupPlot: dict = {
    "owner": 0,

}

plots: list[dict] = json.loads(
    open(file="v1.0\Database\Plots\Plots.json").read())


def claim_check(newPlot: dict, config: dict) -> bool:

    plots: list[dict]
    with open("v1.0\Database\Plots\Plots.json") as file:
        plots = file.read()

    for plot in plots:
        if plot["dimension"] == newPlot["dimension"] and plot["owner"] != newPlot["owner"]:
            extendedBounds: list[tuple] = [(), ()]
    return True


def claim(newPlot: dict, config: dict):
    if claim_check(newPlot=newPlot, config=config):
        pass


def default():
    pass


def delete(executor: str, plot: dict):
    if executor == plot["owner"]:
        pass


def search(owner='', coords=(0, 0, 150), dimension='') -> list[dict]:
    filteredPlots: list = []
    pass
