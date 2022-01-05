import pandas as pd
df = pd.read_csv (r'newds.csv')
print(df)

mean1 = df['salary'].mean()
sum1 = df['salary'].sum()
max1 = df['salary'].max()
min1 = df['salary'].min()
count1 = df['salary'].count()
median1 = df['salary'].median() 
std1 = df['salary'].std() 
var1 = df['salary'].var()  

# Second group 
groupby_sum1 = df.groupby(['finance']).sum() 
groupby_count1 = df.groupby(['finance']).count()

# Second group 
groupby_sum1 = df.groupby(['indus']).sum() 
groupby_count1 = df.groupby(['indus']).count()


# Output group one
print ('Mean salary: ' + str(mean1))
print ('Sum of salary ' + str(sum1))
print ('Max salary: ' + str(max1))
print ('Min salary: ' + str(min1))
print ('Count of salary: ' + str(count1))
print ('Median salary: ' + str(median1))
print ('Std of salary: ' + str(std1))
print ('Var of salary: ' + str(var1))

# Output group two 
print ('Sum of values, grouped by the finance: ' + str(groupby_sum1))
print ('Count of values, grouped by the finance: ' + str(groupby_count1))


# Output group three
print ('Sum of values, grouped by the indus: ' + str(groupby_sum1))
print ('Count of values, grouped by the indus: ' + str(groupby_count1))


#Regression analysis
import pandas as pd
#import numpy as np
import matplotlib.pyplot as plt
#import statsmodel.api as sm

df = pd.read_csv (r'salroe.csv')
print(df)

y = df['salary']
x = df['roe']

plt.scatter(x,y)

plt.xlabel('salary',fontsize = '20')
plt.ylabel('roe', fontsize = '20')
 
 
plt.show()



 