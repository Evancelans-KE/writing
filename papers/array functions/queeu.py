from collections import deque
cargoStack = deque()
cargoStack.append('a')
cargoStack.append('b')
cargoStack.append('c')

cargoStack
deque(['a', 'b', 'c'])

cargoStack.pop()
'c'
cargoStack.pop()
'b'
cargoStack.pop()
'a'

cargoStack.pop()
