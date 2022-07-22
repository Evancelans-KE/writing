# Get the necessary files 
from datetime import datetime, timedelta
import pandas as pd
%matplotlib inline
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from __future__ import division

import plotly.plotly as py
import plotly.offline as pyoff
import plotly.graph_objs as go

# visualize the dataset 
pyoff.init_notebook_mode()
input_data = pd.read_csv('input.csv')
input_data.head(10)


##Revenue calculation


input_data['InvoiceDate'] = pd.to_datetime(input_data['InvoiceDate'])
input_data['InvoiceYearMonth'] = input_data['InvoiceDate'].map(lambda date: 100*date.year + date.month)
input_data['Revenue'] = input_data['UnitPrice'] * input_data['Quantity']
tx_revenue = tx_data.groupby(['InvoiceYearMonth'])['Revenue'].sum().reset_index()
tx_revenue

#visualise and draw the graph:

#plot the graph with X and Y variables

graphly = [
    go.Scatter(
        x=tx_revenue['MonthYear'],
        y=tx_revenue['Total Revenue'],
    )
]

graph_layout = go.Layout(
        xaxis={"type": "category"},
        title='Montly Revenue'
    )
figure = go.Figure(data=graphly, layout=plot_layout)
pyoff.iplot(figure)

###Supervised learning:

import pandas as pd					  
import csv							  
import numpy as np				 
import matplotlib.pyplot as plt		  
import tensorflow as tf				 
from tensorflow import keras		  

 #Read the document containing the datasets 
list_row,date,traffic = get_data('/home/dataset')

##
print(dataset.groupby('class').size())

##


from pandas import read_csv

url = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv"
names = ['sepal-length', 'sepal-width', 'petal-length', 'petal-width', 'class']
dataset = read_csv(url, names=names)
print(dataset.shape)

print(dataset.head(20))

print(dataset.describe())

print(dataset.groupby('class').size())


##


dataset.plot(kind='box', subplots=True, layout=(2,2), sharex=False, sharey=False)
pyplot.show()

##

# 
from pandas import read_csv
from matplotlib import pyplot
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import StratifiedKFold
from sklearn.linear_model import LogisticRegression
from sklearn.tree import DecisionTreeClassifier
from sklearn.neighbors import KNeighborsClassifier
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
# 
url = "https://raw.githubusercontent.com/jbrownlee/Datasets/master/iris.csv"
names = ['sepal-length', 'sepal-width', 'petal-length', 'petal-width', 'class']
dataset = read_csv(url, names=names)
# 
array = dataset.values
X = array[:,0:4]
y = array[:,4]
X_train, X_validation, Y_train, Y_validation = train_test_split(X, y, test_size=0.20, random_state=1, shuffle=True)
# 
models = []
models.append(('LR', LogisticRegression(solver='liblinear', multi_class='ovr')))
models.append(('LDA', LinearDiscriminantAnalysis()))
models.append(('KNN', KNeighborsClassifier()))
models.append(('CART', DecisionTreeClassifier()))
models.append(('NB', GaussianNB()))
models.append(('SVM', SVC(gamma='auto')))
# 
results = []
names = []
for name, model in models:
	kfold = StratifiedKFold(n_splits=10, random_state=1, shuffle=True)
	cv_results = cross_val_score(model, X_train, Y_train, cv=kfold, scoring='accuracy')
	results.append(cv_results)
	names.append(name)
	print('%s: %f (%f)' % (name, cv_results.mean(), cv_results.std()))
# Compare Algorithms
pyplot.boxplot(results, labels=names)
pyplot.title('Algorithm Comparison')
pyplot.show()
