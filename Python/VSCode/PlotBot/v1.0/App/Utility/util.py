def return_contents(filepath: str = "") -> str:
    with open(file=filepath) as file:
        return file.read()
