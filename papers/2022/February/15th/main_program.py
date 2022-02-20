#Load the dataset and read it on Jupyter
from logging import critical
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
region =np.array(['a','b','c','d','e','f','g','h','i']) 
mineral =np.array([1,3,4,2,1.5,3.6,2.5,2,6])

###
# Creating some arrays relevant for the plot
 housing_status = [critical, not_critical, ]
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