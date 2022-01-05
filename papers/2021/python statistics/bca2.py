import pandas as pd
df = pd.read_csv (r'bca2.csv')
print(df)


# block 1 - simple stats
mean1 = df['acc'].mean()
sum1 = df['acc'].sum()
max1 = df['acc'].max()
min1 = df['acc'].min()
count1 = df['acc'].count()
median1 = df['acc'].median() 
std1 = df['acc'].std() 
var1 = df['acc'].var()  

# block 2 - group by
groupby_sum1 = df.groupby(['city']).sum() 
groupby_count1 = df.groupby(['city']).count()

# Group by tax affiliation
groupby_sum1 = df.groupby(['licence']).sum() 
groupby_count1 = df.groupby(['licence']).count()


# print block 1
print ('Mean acc: ' + str(mean1))
print ('Sum of acc ' + str(sum1))
print ('Max acc: ' + str(max1))
print ('Min acc: ' + str(min1))
print ('Count of acc: ' + str(count1))
print ('Median acc: ' + str(median1))
print ('Std of acc: ' + str(std1))
print ('Var of acc: ' + str(var1))

# print block 2
print ('Sum of values, grouped by the city: ' + str(groupby_sum1))
print ('Count of values, grouped by the city: ' + str(groupby_count1))


# print block 2
print ('Sum of values, grouped by the licence: ' + str(groupby_sum1))
print ('Count of values, grouped by the licence: ' + str(groupby_count1))
