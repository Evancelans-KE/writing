#Load the dataset and read it on Jupyter
from pandas.io.json import json_normalize
import json
import pandas as pd
dataset = pd.read_csv("shop_visits.csv")
dataset

#Get the summary of the data 
df = pd.DataFrame(dataset)
print(df)
print(df.describe())

#
shop_walkin =np.array([5,13,15,5,15,14,7,2,14,8,1,15,10,5,8,7,8,5,11,2,11,11,14]) 
total_visits=np.array([55,29,8,66,63,93,5,30,18,45,85,71,3,45,65,21,28,99,48,46,43,40,19])

###
# Creating some arrays relevant for the plot
the_hour = ['1', '2', '3','4','5','6', '7', '8','9','10',
            '11', '12', '13','14','15','16', '17', '18','19','20','21', '22', '23']
x_pos = np.arange(len(the_hour))
CTEs = [shop_walkin,total_visits]

#Building the plot 
fig, ax = plt.subplots()


ax.bar(x_pos, CTEs, align='center', alpha=0.5)
ax.set_ylabel('Hourly')
ax.set_xticks(x_pos)
ax.set_xticklabels(the_hour)
ax.set_title('Shop walkin')
ax.yaxis.grid(True)

# Save the figure and show
plt.tight_layout()
plt.savefig('bar_plot.png')
plt.show()

#Building the predictive analytics
#Load the relaventa libararies
import pandas as pd
import numpy as np
from sklearn.preprocessing import LabelEncoder
import random
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import GradientBoostingClassifier

train=pd.read_csv('shop_visits.csv')
test=pd.read_csv('shop_visits.csv') 
test['Type']='Test'
fullData = pd.concat([train,test],axis=0) 

fullData.columns 
fullData.head(10) 
fullData.describe() 

#Probabilistic predictions here:
from sklearn.linear_model import LinearRegression
from sklearn.datasets import make_regression
# Next step is to generate regression dataset 
X, y = make_regression(n_samples=400, n_features=2, noise=0.1)
# then fit the model as required 
model = LinearRegression()
model.fit(X, y)
# create a new data instance
Xnew = [[2,4]]
# then predict the outcome
ynew = model.predict(Xnew)
# show prediction
print("X=%s, Predicted=%s" % (Xnew[0], ynew[0]))