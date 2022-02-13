"""
Spyder Editor

This is a temporary script file.
"""

#import numpy as np
#import sklearn
#import math
import pandas as pd

dataset = pd.read_csv('nuvi_models.csv')
print(dataset);

#Plot the variables  and show

plt.bar(dataset['model'], dataset['count_of_models'])
plt.title("Micro SD distributions")
# Setting the X and Y labels
plt.xlabel('model')
plt.ylabel('count_of_models')
# Adding the legends
plt.show()


#Plot the line graph
import pandas as pd
import matplotlib.pyplot as plt

dataset = pd.read_csv('nuvi_card_slots.csv')
#dataset = dataset.count_of_models.astype(int)
print(dataset);

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
  
