import json

newGroup: dict = {
    "name": "N/A",
    "owner": 0,
    "members": []
}

groups: list[dict] = json.loads(
    open(file="v1.0\Database\Plots\Groups.json").read())


def create(name: str, *members):
    pass


def disband(name: str = ""):
    pass


def assign(member: str, group: str):
    pass


def promote(member: str, executorRole: str):
    pass


def remove(member: str, group: str):
    pass
