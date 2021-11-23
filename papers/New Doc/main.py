import numpy as np
from sklearn.model_selection import train_test_split
import math


actual = [0.0489,0.0489,0.049,0.049,0.049,0.049,0.049,0.049,0.049,0.0491,0.0491]
predicted = [0.0005,0.0006,0.001,0.0033,0.0054,0.0097,0.0179,0.0203,0.0238,0.0292,0.0346,0.0489,0.0489,0.0489,0.0489]

mse = sklearn.model_selection.metrics.mean_squared_error(actual, predicted)
print(actual)

rmse = math.sqrt(mse)

print(rmse)

