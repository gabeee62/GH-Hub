def match(var: any, control: any) -> bool:
    if var == control:
        print('The variable was a match!')
        return True
    elif type(var) != type(control):
        print('The provided variable is a different class than the control.')
        print(f'Variable type: {type(var)}')
        print(f'Control type: {type(control)}')
        return False
    else:
        print('The variable was not a match.')
        return False
