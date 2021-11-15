import pandas as pd
df = pd.read_csv (r'dataset.csv')



# block 1 - simple stats
mean1 = df['salary in dollars'].mean()
sum1 = df['salary in dollars'].sum()
max1 = df['salary in dollars'].max()
min1 = df['salary in dollars'].min()
count1 = df['salary in dollars'].count()
median1 = df['salary in dollars'].median() 
std1 = df['salary in dollars'].std() 
var1 = df['salary in dollars'].var()  

# block 2 - group by
groupby_sum1 = df.groupby(['gender']).sum() 
groupby_count1 = df.groupby(['gender']).count()

# print block 1
print ('Mean salary: ' + str(mean1))
print ('Sum of salaries: ' + str(sum1))
print ('Max salary: ' + str(max1))
print ('Min salary: ' + str(min1))
print ('Count of salaries: ' + str(count1))
print ('Median salary: ' + str(median1))
print ('Std of salaries: ' + str(std1))
print ('Var of salaries: ' + str(var1))

# print block 2
print ('Sum of values, grouped by the Gender: ' + str(groupby_sum1))
print ('Count of values, grouped by the Gender: ' + str(groupby_count1))

#
import pandas as pd
df = pd.read_csv (r'education.csv')
df.plot(x = 'salary in dollars', y='education', kind = 'scatter')

import pandas as pd
df = pd.read_csv (r'gender.csv')
print(df)
df.plot(x = 'salary in dollars', y='gender', kind = 'bar')

import pandas as pd
import matplotlib.pyplot as plt

df = pd.read_csv (r'Roi.csv')
print(df)


plt.scatter(df['ROI'], df['salary in dollars'])
plt.xlabel('ROI')
plt.ylabel('salary in dollars')
