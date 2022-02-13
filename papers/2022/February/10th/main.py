"""
Spyder Editor

This is a temporary script file.
"""


import pandas as pd
import matplotlib.pyplot as plt
import pandas as pd

nuvi_data = pd.read_csv('nuvi_models.csv')
print(nuvi_data);

#Plot the variables  and show

plt.bar(nuvi_data['model'], nuvi_data['count_of_models'])
plt.title("Micro SD distributions")

plt.xlabel('model')
plt.ylabel('count_of_models')

plt.show()


#Plot the line graph


dataset = pd.read_csv('nuvi_card_slots.csv')

print(nuvi_data);

x = ['microSD', 'SD','Not_assigned']
y = [2,9,1]
y2 =[2.1,1,0.1]
y3 = [2,4,0]



fig, ax = plt.subplots()

ax.plot(x, y)
ax.plot(x, y2)
ax.plot(x, y3)
plt.title("Card Slot vs Fm transmitter distributions")
plt.show()
  
