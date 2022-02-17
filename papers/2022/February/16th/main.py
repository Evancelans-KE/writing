#Dataset description;

 parents        usual, pretentious, great_pret
 has_nurs       proper, less_proper, improper, critical, very_crit
   form           complete, completed, incomplete, foster
   children       1, 2, 3, more
   housing        convenient, less_conv, critical
   finance        convenient, inconv
   social         non-prob, slightly_prob, problematic
   health         recommended, priority, not_recom

   #Load the housing dataset;
import pandas as pd;
import numpy as np;

dataset = pd.read_csv("housing.csv")
print(dataset)

#Decsribe the data;

dataset = pd.read_csv("housing.csv")
#print(dataset)
print(dataset.describe())

###
# Creating some arrays relevant for the plot
housing_status = [critical, not_critical, ]
x_pos = np.arange(len(the_hour))
CTEs = [shop_walkin,total_visits]

# Get the plot 

def x_pos(y_pos):
    return x_pos.astype(int)

housing = ['convenient','critical','less_conv']
x_pos = np.arange(len(housing))
CTEs = [housing,frequency]


fig, ax = plt.subplots()


ax.bar(x_pos, CTEs, align='center', alpha=0.5)
ax.set_ylabel('Frequency')
ax.set_xticks(x_pos)
ax.set_xticklabels(the_hour)
ax.set_title('housing')
ax.yaxis.grid(True)

# Save the figure and show
plt.tight_layout()
plt.savefig('bar_chart.png')
plt.show()

# Modelling the data with Naive bayes algoritm

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import sklearn
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.naive_bayes import GaussianNB
from sklearn.metrics import confusion_matrix,accuracy_score

dataset = pd.read_csv('nsr.csv')
X = dataset.iloc[:, [1, 2, 3]].values
y = dataset.iloc[:, -1].values


le = LabelEncoder()
X[:,0] = le.fit_transform(X[:,0])


X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.20, random_state = 0)

sc = StandardScaler()
X_train = sc.fit_transform(X_train)
X_test = sc.transform(X_test)


classifier = GaussianNB()
classifier.fit(X_train, y_train)

y_pred  =  classifier.predict(X_test)
y_pred  
y_test


cm = confusion_matrix(y_test, y_pred)
ac = accuracy_score(y_test,y_pred)