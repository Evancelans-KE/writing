
import queue
q1 = queue.LifoQueue()
q1.put(10)

item1 = q1.get()

print('The item removed from the LIFO queue is ', item1)