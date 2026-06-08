import datetime


class Shape:
    def __init__(self, x1: int, y1: int, x2: int, y2: int):
        self.p1: tuple = (x1, y1)
        self.p2: tuple = (x1, y2)
        self.p3: tuple = (x2, y1)
        self.p4: tuple = (x2, y2)


class Plot:
    def __init__(self, owner: str, name: str, dimension: str, x1: int, y1: int, x2: int, y2: int):
        self.owner = owner
        self.name = name
        self.dimension = dimension
        self.dateClaimed = datetime.date.today()
        self.corners = Shape(x1, y1, x2, y2)
