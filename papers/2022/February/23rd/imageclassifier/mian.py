#Import the necessary libraries 

import torch
import torchvision
import torchvision.transforms as transforms
import torchvision.datasets as datasets
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image
from torch.autograd import Variable
import torchvision.thisModels as thisModels
from torch import nn, optim

#Load the data 

data_directory = 'flowers'
train_directory = data_directory + '/train'
valid_directory = data_directory + '/valid'
test_directory = data_directory + '/test'

#Define  the image transformation characteristics
train_transformation = transforms.Compose([transforms.Resize(255),
                                transforms.CenterCrop(224),
                                transforms.RandomHorizontalFlip(),
                                transforms.ToTensor(),
                                transforms.Normalize([0.485, 0.456, 0.406],[0.229, 0.224, 0.225])])

valid_transformation = transforms.Compose([transforms.Resize(255),
                                transforms.CenterCrop(224),
                                transforms.ToTensor(),
                                transforms.Normalize([0.485, 0.456, 0.406],[0.229, 0.224, 0.225])])

test_transformation = transforms.Compose([transforms.Resize(255),
                                transforms.CenterCrop(224),
                                transforms.ToTensor(),
                                transforms.Normalize([0.485, 0.456, 0.406],[0.229, 0.224, 0.225])])


train_dataset = datasets.ImageFolder(train_directory, transform=train_transformation)
valid_dataset = datasets.ImageFolder(valid_directory, transform=train_transformation)
test_dataset = datasets.ImageFolder(test_directory, transform=train_transformation)


trainset = torch.utils.data.DataLoader(train_dataset, batch_size=64, shuffle=True)
validset = torch.utils.data.DataLoader(valid_dataset, batch_size=64)
testset = torch.utils.data.DataLoader(test_dataset, batch_size=64)

#The mappings

import json

with open('cat_to_name.json', 'r') as f:
    cat_to_name = json.load(f)


#Testing the loads

images, labels = next(iter(testset))
print(len(images[0,2]))
plt.imshow(images[0,0])


# Training the classifier 

import torchvision.thisModels as thisModels
from torch import nn, optim


thisDevice = torch.thisDevice("cuda" if torch.cuda.is_available() else "cpu")

thisModel = thisModels.vgg16(pretrained=True)


for param in thisModel.parameters():
    param.requires_grad = False
    
from collections import OrderedDict    
thisModel.classifier = nn.Sequential(OrderedDict([
                          ('fc1', nn.Linear(25088, 2048)),
                          ('relu', nn.ReLU()),
                          ('fc2', nn.Linear(2048, 256)),
                          ('relu', nn.ReLU()),
                          ('fc3', nn.Linear(256, 102)),
                          ('output', nn.LogSoftmax(dim=1))
                          ]))
print(thisModel)
thisModel = thisModel.to('cuda')
criterion = nn.NLLLoss()
optimizer = optim.Adam(thisModel.classifier.parameters(), lr=0.001)


#Classifier training

epochs = 3
steps = 0
running_loss = 0
print_every = 5

for epoch in range(epochs):
    for inputs, labels in trainset:
        steps += 1
        
        
        inputs, labels = inputs.to('cuda'), labels.to('cuda')
        
        optimizer.zero_grad()
        
     
        logps = thisModel.forward(inputs)
        loss = criterion(logps, labels)
        
        loss.backward()
        optimizer.step()

        running_loss += loss.item()
        
        if steps % print_every == 0:
            valid_loss = 0
            accuracy = 0
            thisModel.eval()
            with torch.no_grad():
                for inputs, labels in validset:
                    inputs, labels = inputs.to('cuda'), labels.to('cuda')
                    
                    logps = thisModel.forward(inputs)
                    batch_loss = criterion(logps, labels)
                    valid_loss += batch_loss.item()
                    
                 
                    ps = torch.exp(logps)
                    top_p, top_class = ps.topk(1, dim=1)
                    equals = top_class == labels.view(*top_class.shape)
                    accuracy += torch.mean(equals.type(torch.FloatTensor)).item()
                    
            print(f"Epoch {epoch+1}/{epochs}.. "
                  f"Loss: {running_loss/print_every:.3f}.. "
                  f"Validation Loss: {valid_loss/len(validset):.3f}.. "
                  f"Accuracy: {accuracy/len(validset):.3f}")
            running_loss = 0
            thisModel.train()

#Network testing

test_loss = 0
accuracy = 0
thisModel.to('cuda')

with torch.no_grad():
    for inputs, labels in testset:
        inputs, labels = inputs.to('cuda'), labels.to('cuda')
        logps = thisModel.forward(inputs)
        batch_loss = criterion(logps, labels)
                    
        test_loss += batch_loss.item()
                    
       
        ps = torch.exp(logps)
        top_p, top_class = ps.topk(1, dim=1)
        equals = top_class == labels.view(*top_class.shape)
        accuracy += torch.mean(equals.type(torch.FloatTensor)).item()
        
print(f"Test accuracy: {accuracy/len(testset):.3f}")

#Image processing


def process_image(image):
    ''' Scales, crops, and normalizes a PIL image for a PyTorch thisModel,
        returns an Numpy array
    '''
    
    thisImg_pil = Image.open(image)
    img_transforms = transforms.Compose([
        transforms.Resize(256),
        transforms.CenterCrop(224),
        transforms.ToTensor(),
        transforms.Normalize(mean=[0.485, 0.456, 0.406],std=[0.229, 0.224, 0.225])
    ])
    
    image = img_transforms(thisImg_pil)
    
    return image

#

def imshow(image, ax=None, title=None):
    """Imshow for Tensor."""
    if ax is None:
        fig, ax = plt.subplots()
    
  
    image = image.numpy().transpose((1, 2, 0))

    mean = np.array([0.485, 0.456, 0.406])
    std = np.array([0.229, 0.224, 0.225])
    image = std * image + mean
   
    image = np.clip(image, 0, 1)
    
    ax.imshow(image)
    
    return ax

imshow(process_image("flowers/test/1/image_06764.jpg"))



def predict(image_path, thisModel, topk=5):   
    thisModel.to('cuda')
    thisModel.eval()
    img = process_image(image_path)
    img = img.numpy()
    img = torch.from_numpy(np.array([img])).float()

    with torch.no_grad():
        output = thisModel.forward(img.cuda())
        
    probability = torch.exp(output).data
    
    return probability.topk(topk)



img = "flowers/test/10/image_07090.jpg"
probability, classes = predict(img, thisModel)
print (probability)
print (classes)

#Then predict

plt.rcParams["figure.figsize"] = (10,10)
plt.subplot(211)

index = 1
path = test_directory + '/1/image_06743.jpg'

probabilities = predict(path, thisModel)
image = process_image(path)


axs = imshow(image, ax = plt)
axs.axis('off')
axs.title(cat_to_name[str(index)])
axs.show()


a = np.array(probabilities[0][0])
b = [cat_to_name[str(index+1)] for index in np.array(probabilities[1][0])]

N=float(len(b))
fig,ax = plt.subplots(figsize=(10,5))
width = 0.5
tickLocations = np.arange(N)


ax.bar(tickLocations, a, width, linewidth=4.0, align = 'center')
ax.set_xticks(ticks = tickLocations)
ax.set_xticklabels(b)
ax.set_xlim(min(tickLocations)-0.6,max(tickLocations)+0.6)
ax.set_yticks([0.2,0.4,0.6,0.8,1,1.2])
ax.set_ylim((0,1))
ax.yaxis.grid(True)

plt.show()




