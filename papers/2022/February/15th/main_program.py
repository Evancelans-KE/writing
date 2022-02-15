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

