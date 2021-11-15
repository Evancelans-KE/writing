import pandas as pd
df = pd.read_csv (r'vpd_one.csv')
print(df)


# block 1 - simple stats
mean1 = df['speed'].mean()
sum1 = df['speed'].sum()
max1 = df['speed'].max()
min1 = df['speed'].min()
count1 = df['speed'].count()
median1 = df['speed'].median() 
std1 = df['speed'].std() 
var1 = df['speed'].var()  

# block 2 - group by
groupby_sum1 = df.groupby(['city']).sum() 
groupby_count1 = df.groupby(['city']).count()

# Group by tax affiliation
groupby_sum1 = df.groupby(['vehicle']).sum() 
groupby_count1 = df.groupby(['vehicle']).count()


# print block 1
print ('Mean speed: ' + str(mean1))
print ('Sum of speed ' + str(sum1))
print ('Max speed: ' + str(max1))
print ('Min speed: ' + str(min1))
print ('Count of speed: ' + str(count1))
print ('Median speed: ' + str(median1))
print ('Std of speed: ' + str(std1))
print ('Var of speed: ' + str(var1))

# print block 2
print ('Sum of values, grouped by the city: ' + str(groupby_sum1))
print ('Count of values, grouped by the city: ' + str(groupby_count1))


# print block 2
print ('Sum of values, grouped by the vehicle: ' + str(groupby_sum1))
print ('Count of values, grouped by the vehicle: ' + str(groupby_count1))
