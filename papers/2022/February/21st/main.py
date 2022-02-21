#importing the necessary libraries required to run the program
import matplotlib.pyplot as plt #data visualisation tool
import seaborn as sns

import keras
from keras.modelDatas import Sequential
from keras.layers import Dense, Conv2D , MaxPool2D , Flatten , Dropout 
from keras.preprocessing.image import ImageDataGenerator
from keras.optimizers import Adam
from sklearn.metrics import classification_report,confusion_matrix

import tensorflow as tf
import torch
import torchvision

import cv2 #image recognition tool
import os
import numpy as np

##  Load the dataset 

gamelabels = ['isRugby', 'isSoccer']
img_size = 224
def get_data(data_dir):
    data = [] 
    for gamelabel in gamelabels: 
        path = os.path.join(data_dir, gamelabel)
        class_num = gamelabels.index(gamelabel)
        for img in os.listdir(path):
            try:
                img_arr = cv2.imread(os.path.join(path, img))[...,::-1] 
                resized_arr = cv2.resize(img_arr, (img_size, img_size))
                data.append([resized_arr, class_num])
            except Exception as e:
                print(e)
    return np.array(data)

##Fetching the data;

trainData = get_data('../input/traintestsports/Main/train')
valData = get_data('../input/traintestsports/Main/test')

#Plot the graph 

l = []
for i in trainData:
    if(i[1] == 0):
        l.append("Rugby")
    else:
        l.append("Soccer")
sns.set_style('darkgrid')
sns.countplot(l)

#Randomly grab one rugby  image 

plt.figure(figsize = (5,5))
plt.imshow(trainData[1][0])
plt.title(gamelabels[trainData[0][1]])

#Randomly grab a socccer image 

plt.figure(figsize = (5,5))
plt.imshow(trainData[-1][0])
plt.title(gamelabels[trainData[-1][1]])

#Then data augemnetaion

x_train = []
y_train = []
x_val = []
y_val = []

for feature, label in trainData:
  x_train.append(feature)
  y_train.append(label)

for feature, label in valData:
  x_val.append(feature)
  y_val.append(label)

# Normalize the data
x_train = np.array(x_train) / 255
x_val = np.array(x_val) / 255

x_train.reshape(-1, img_size, img_size, 1)
y_train = np.array(y_train)

x_val.reshape(-1, img_size, img_size, 1)
y_val = np.array(y_val)

#Proceed with augmenation 

datagenerated = ImageDataGenerator(
        featurewise_center=False,   
        samplewise_center=False,   
        featurewise_std_normalization=False,  
        samplewise_std_normalization=False,  
        zca_whitening=False,   
        rotation_range = 30,   
        zoom_range = 0.2,  
        width_shift_range=0.1,  
        height_shift_range=0.1, 
        horizontal_flip = True,  
        vertical_flip=False) 


datagenerated.fit(x_train)


#Defining the modelData

modelData = Sequential()
modelData.add(Conv2D(32,3,padding="same", activation="relu", input_shape=(224,224,3)))
modelData.add(MaxPool2D())

modelData.add(Conv2D(32, 3, padding="same", activation="relu"))
modelData.add(MaxPool2D())

modelData.add(Conv2D(64, 3, padding="same", activation="relu"))
modelData.add(MaxPool2D())
modelData.add(Dropout(0.4))

modelData.add(Flatten())
modelData.add(Dense(128,activation="relu"))
modelData.add(Dense(2, activation="softmax"))

modelData.summary()

#Compiling the model
opt = Adam(lr=0.000001)
modelData.compile(optimizer = opt , loss = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True) , metrics = ['accuracy'])

historyData = modelData.fit(x_train,y_train,epochs = 400 , validation_data = (x_val, y_val))

#Results evaluations

acc = historyData.historyData['accuracy']
val_acc = historyData.historyData['val_accuracy']
loss = historyData.historyData['loss']
val_loss = historyData.historyData['val_loss']

epochs_range = range(500)

plt.figure(figsize=(15, 15))
plt.subplot(2, 2, 1)
plt.plot(epochs_range, acc, label='Training Accuracy')
plt.plot(epochs_range, val_acc, label='Validation Accuracy')
plt.legend(loc='lower right')
plt.title('Training and Validation Accuracy')

plt.subplot(2, 2, 2)
plt.plot(epochs_range, loss, label='Training Loss')
plt.plot(epochs_range, val_loss, label='Validation Loss')
plt.legend(loc='upper right')
plt.title('Training and Validation Loss')
plt.show()

#show the resulting predcitions of data

modelPredictions = modelData.predict_classes(x_val)
modelPredictions = modelPredictions.reshape(1,-1)[0]
print(classification_report(y_val, modelPredictions, target_names = ['Rugby (Class 0)','Soccer (Class 1)']))
