 train=read.csv("train.csv")
str(train)
train=train[train$sales!=0,]
str(train)
train$store_nbr=as.factor(train$store_nbr)
train$family=as.factor(train$family)
train$date=as.Date(train$date,format = "%Y-%m-%d")
str(train)
hist(train$sales)
hist(train$onpromotion)
summary(train$sales)
summary(train$onpromotion)
train$sales=log(train$sales+3)# log() function
train$onpromotion=log(train$onpromotion+3)
hist(train$onpromotion)
hist(train$sales)


set.seed(3000)
spl = sample(nrow(train), 0.8*nrow(train))
salesTrain = train[spl,]
salesTest = train[-spl,]
nrow(salesTrain)
nrow(salesTest)
any(is.na(salesTrain))
str(salesTrain)


LR1= lm(sales~., data = salesTrain)
summary(LR1) # Multiple R-squared:  0.9075,	Adjusted R-squared:  0.9075 

LR2=lm(sales~.-id,data = salesTrain)
summary(LR2) # Multiple R-squared:  0.9074,	Adjusted R-squared:  0.9074  

  LR3=lm(sales~.-date,data = salesTrain)
summary(LR3) # Multiple R-squared:  0.9027,	Adjusted R-squared:  0.9027 

LR4=lm(sales~store_nbr+family+onpromotion,data = salesTrain)
summary(LR4) # Multiple R-squared:  0.9024,	Adjusted R-squared:  0.9024 

LR5=lm(sales~date+family+onpromotion,data = salesTrain)
summary(LR5) # Multiple R-squared:  0.8564,	Adjusted R-squared:  0.8564

LR6=lm(sales~id+date+store_nbr+onpromotion,data = salesTrain)
summary(LR6) # Multiple R-squared:  0.5869,	Adjusted R-squared:  0.5869 

LR7=lm(sales~id+date+family+onpromotion,data = salesTrain)
summary(LR7) # Multiple R-squared:  0.8611,	Adjusted R-squared:  0.8611 

prediction1=exp(predict(exp(LR1),newdata=salesTest))
prediction1
predictiontest=(prediction1-3)
predictiontest
salesTest$sales
SSE=sum((predictiontest-exp(salesTest$sales))^2)
SSE # 695567050815 239959900535
SST=sum((exp(salesTest$sales)-exp(mean(salesTrain$sales)))^2)
SST # 791261170663
R2=1-(SSE/SST)
R2 # 0.6967374

prediction2=predict(LR1,newdata=salesTest)
prediction2
salesTest$sales
SSE=sum((prediction2-salesTest$sales)^2)
SSE # 162569.8
SST=sum((salesTest$sales-mean(salesTrain$sales))^2)
SST # 1750270
R2=1-(SSE/SST)
R2 # 0.9071173

test=read.csv("test.csv")
test$store_nbr=as.factor(test$store_nbr)
test$family=as.factor(test$family)
test$date=as.Date(test$date,format = "%Y-%m-%d")
str(test)
summary(test$onpromotion)
hist(test$onpromotion)
test$onpromotion=log(test$onpromotion+3)
hist(test$onpromotion)


actualpred=exp(predict(LR1,newdata=test))
actualpred2=abs(actualpred-3)
actualpred2
sub1=data.frame(id=test$id,sales=actualpred2)
str(sub1)
write.csv(sub1,"Team3Week22.csv", row.names = F)

table(is.na(actualpred2))



                                                  ## CORRELATION ANALYSIS 
train=read.csv("train.csv")
str(train)
train=train[train$sales!=0,]
str(train)
train=train[train$sales<4000,]
str(train)
summary(train$sales)    # 2006345 obs
train$store_nbr=as.factor(train$store_nbr)
train$family=as.factor(train$family)
train$date=as.Date(train$date,format = "%Y-%m-%d")
str(train)
cor(train$id,train$sales) ## -0.002305276
hist(train$date,train$sales, breaks = 50)
plot(train$date,train$sales)
plot(train$store_nbr,train$sales,type="l")

install.packages("gmodels")
library(gmodels)
category=CrossTable(train$store_nbr,train$family)
freqstore=table(train$store_nbr)
freqstore
relfreqstore=freqstore/nrow(train)
relfreqstore


oil=read.csv("oil.csv")
str(oil)
oil$date=as.Date(oil$date,format = "%Y-%m-%d")
plot(oil$date,train$sales)
oilcombinne=merge(oil,train,by="date")
table(is.na(oilcombinne))
summary(oilcombinne$dcoilwtico)
str(oilcombinne)
summary(oilcombinne)

install.packages("mice")
library(mice)
my_imp=mice(oilcombinne,m=5,method = c("","pmm","","","","",""),maxit = 20)
my_imp$imp$dcoilwtico
sort(table(oilcombinne$dcoilwtico))
final_clean=complete(my_imp,3)
str(final_clean)
plot(final_clean$dcoilwtico,final_clean$sales) # oil price does not affect sales
cor(final_clean$dcoilwtico,final_clean$sales) # -0.003735659


hist(oilcombinne$dcoilwtico)
oilcombinne$dcoilwtico[is.na(oilcombinne$dcoilwtico)]=median(oilcombinne$dcoilwtico[!is.na(oilcombinne$dcoilwtico)])
str(oilcombinne)
hist(oilcombinne$dcoilwtico)
plot(oilcombinne$dcoilwtico,oilcombinne$sales)
cor(oilcombinne$dcoilwtico,oilcombinne$sales)  # -0.003742286
cor(oilcombinne$onpromotion,oilcombinne$sales)  # 0.7828386


## Transaction
transact=read.csv("transactions.csv")
str(transact)
summary(transact)
transact$store_nbr=as.factor(transact$store_nbr)
str(transact)
transact$date=as.Date(transact$date,format = "%Y-%m-%d")
str(transact)
hist(transact$date,transact$transactions, breaks = 50)
transcom=merge(transact,train,by=c("date","store_nbr"))
str(transcom)
summary(transcom)
plot(transcom$transactions,transcom$sales)
cor(transcom$transactions,transcom$sales) # 0.1111112

hol=read.csv("holidays_events.csv")
str(hol)
summary(hol)
table(hol$type)
table(hol$transferred)
table(hol$locale)
table(hol$locale_name)
hol$type=as.factor(hol$type)
hol$locale=as.factor(hol$locale)
hol$transferred=as.factor(hol$transferred)
hol$date=as.Date(hol$date,format = "%Y-%m-%d")
str(hol)
holcom=merge(hol,train,by="date")
str(holcom)
plot(holcom$type,holcom$sales)
plot(holcom$onpromotion,holcom$sales)
var(holcom$type,holcom$sales)

### Summing all to build a model
oil=read.csv("oil.csv")
str(oil)
oil$date=as.Date(oil$date,format = "%Y-%m-%d")
oilcomb=merge(oil,holcom,by="date",all.y = TRUE)
str(oilcomb)

transact=read.csv("transactions.csv")
str(transact)
transact$store_nbr=as.factor(transact$store_nbr)
transact$date=as.Date(transact$date,format = "%Y-%m-%d")
str(transact)
transcom=merge(transact,oilcomb,by=c("date","store_nbr"),all.y = TRUE)
str(transcom)
summary(transcom)

hist(transcom$transactions)
hist(transcom$dcoilwtico)

library(mice)
my_imp=mice(transcom,m=5,method = c("","","pmm","pmm","","","","","","","","",""),maxit = 10)
my_imp$imp$dcoilwtico
sort(table(oilcombinne$dcoilwtico))
final_clean=complete(my_imp,5)
str(final_clean)
table(is.na(final_clean))

hist(final_clean$transactions)
hist(final_clean$dcoilwtico)

final_clean$sales=log(final_clean$sales+3)# log() function
final_clean$onpromotion=log(final_clean$onpromotion+3)
hist(final_clean$sales)
hist(final_clean$onpromotion)

set.seed(3000)
spl = sample(nrow(final_clean), 0.8*nrow(final_clean))
salesTrain = final_clean[spl,]
salesTest = final_clean[-spl,]
nrow(salesTrain)
nrow(salesTest)
any(is.na(salesTrain))
str(salesTrain)

LR1= lm(sales~., data = salesTrain)
summary(LR1) # Multiple R-squared:  0.9102,	Adjusted R-squared:  0.9101

LR2= lm(sales~.-id-description-locale_name, data = salesTrain)
summary(LR2) # Multiple R-squared:  0.9085,	Adjusted R-squared:  0.9085 

LR3= lm(sales~date+dcoilwtico+id+store_nbr+family+onpromotion, data = salesTrain)
summary(LR3) # Multiple R-squared:  0.9016,	Adjusted R-squared:  0.9016 

modelstep=step(LR1) # Multiple R-squared:  0.9102,	Adjusted R-squared:  0.9101 
summary(modelstep)

prediction=predict(modelstep,newdata=salesTest)
prediction
salesTest$sales
SSE=sum((prediction-salesTest$sales)^2)
SSE # 23837.37
SST=sum((salesTest$sales-mean(salesTrain$sales))^2)
SST # 262004
R2=1-(SSE/SST)
R2 # 0.9090191

library(rpart)
library(rpart.plot)
tree=rpart(sales~date+store_nbr+transactions+dcoilwtico+description+transferred+id+family+onpromotion, data = salesTrain)
tree.pred=predict(tree,newdata = salesTest)
tree.pred
salesTest$sales
tree.sse=sum((tree.pred-salesTest$sales)^2)
tree.sse # 35653.46

library(caret)
library(e1071)
tr.control=trainControl(method="cv",number = 10)
cp.grid=expand.grid(.cp=(0:10)*0.001)
tr=train(sales~date+store_nbr+transactions+dcoilwtico+description+transferred+id+family+onpromotion,data=salesTrain,method="rpart",trControl=tr.control,tuneGrid=cp.grid)
best.tree=tr$finalModel
best.treepred=predict(best.tree,newdata = salesTest) # Error in eval(predvars, data, env) : object 'store_nbr2' not found
tree.sse=sum((best.treepred-Test$MEDV)^2)
tree.sse

set.seed(1000)
library(randomForest)
RFb=randomForest(sales~date+store_nbr+transactions+dcoilwtico+description+transferred+id+family+onpromotion,data=salesTrain)
predictions=predict(RFb,newdata = test)  # Error in randomForest.default(m, y, ...) : Can not handle categorical predictors with more than 53 categories.

test=read.csv("test.csv")
test$store_nbr=as.factor(test$store_nbr)
test$family=as.factor(test$family)
test$date=as.Date(test$date,format = "%Y-%m-%d")
str(test)
holcom2=merge(hol,test,by="date",all.y = TRUE)
str(holcom2)

str(oil)
oilcomb2=merge(oil,test,by="date",all.y = TRUE)
str(oilcomb2)
summary(oilcomb2) # useful: some obsevations in the test set

transcom2=merge(transact,oilcomb2,by="date",all.y = TRUE)
summary(transcom2)  # Not useful. NO data in test  set

summary(oilcomb2)
my_imp2=mice(oilcomb2,m=5,method = c("","pmm","","","",""),maxit = 10)
my_imp2$imp$dcoilwtico

final_clean2=complete(my_imp2,1)
str(final_clean)
table(is.na(final_clean))
hist(final_clean2$dcoilwtico)
hist(final_clean2$onpromotion)
final_clean2$onpromotion=log(final_clean2$onpromotion+3)

actualpred=exp(predict(LR3,newdata=final_clean2))
actualpred
actualpred2=abs(actualpred-3)
actualpred2
sub2=data.frame(id=test$id,sales=actualpred2)
str(sub2)
write.csv(sub2,"Team3Week2cor1.csv", row.names = F)

table(is.na(actualpred2))




## THIRD ATTEMPT  WEEk2cor2 and cor3
train=read.csv("train.csv")
oil=read.csv("oil.csv")
train=train[train$sales!=0,]
train$store_nbr=as.factor(train$store_nbr)
train$family=as.factor(train$family)
train$date=as.Date(train$date,format = "%Y-%m-%d")
oil$date=as.Date(oil$date,format = "%Y-%m-%d")
str(oil)
str(train)
oilcomb=merge(oil,train,by="date")
str(oilcomb)
summary(oilcomb)
hist(oilcomb$dcoilwtico)
sd(oilcomb$dcoilwtico,na.rm = T) # 24.58244
oilcomb$dcoilwtico[is.na(oilcomb$dcoilwtico)]=mean(oilcomb$dcoilwtico[!is.na(oilcomb$dcoilwtico)])
str(oilcomb)
hist(oilcomb$dcoilwtico)

str(train)
hist(oilcomb$sales)
hist(oilcomb$onpromotion)
summary(oilcomb$sales)
summary(oilcomb$onpromotion)
oilcomb$sales=log(oilcomb$sales+3)# log() function
oilcomb$onpromotion=log(oilcomb$onpromotion+3)
hist(oilcomb$onpromotion)
hist(oilcomb$sales)


set.seed(3000)
spl = sample(nrow(oilcomb), 0.8*nrow(oilcomb))
salesTrain = oilcomb[spl,]
salesTest = oilcomb[-spl,]
nrow(salesTrain) # 1175370
nrow(salesTest)  # 93843
any(is.na(salesTrain))
str(salesTrain)


LR1= lm(sales~., data = salesTrain)
summary(LR1) # Multiple R-squared:  0.9089,	Adjusted R-squared:  0.9089

LR2=lm(sales~.-id,data = salesTrain)
summary(LR2) # Multiple R-squared:  0.9089,	Adjusted R-squared:  0.9089  

LR3=lm(sales~.-date,data = salesTrain)
summary(LR3) # Multiple R-squared:  0.9089,	Adjusted R-squared:  0.9089  

LR4=lm(sales~store_nbr+family+onpromotion,data = salesTrain)
summary(LR4) # Multiple R-squared:  0.9086,	Adjusted R-squared:  0.9086  

LR5=lm(sales~dcoilwtico+store_nbr+family+onpromotion,data = salesTrain)
summary(LR5) # Multiple R-squared:  0.9089,	Adjusted R-squared:  0.9089 

LR6=lm(sales~id+date+store_nbr+onpromotion+family,data = salesTrain)
summary(LR6) # Multiple R-squared:  0.9088,	Adjusted R-squared:  0.9088  

LR7=lm(sales~id+date+family+onpromotion,data = salesTrain)
summary(LR7) #Multiple R-squared:  0.8699,	Adjusted R-squared:  0.8699 

prediction1=exp(predict(exp(LR1),newdata=salesTest))
prediction1
predictiontest=(prediction1-3)
predictiontest
salesTest$sales
SSE=sum((predictiontest-exp(salesTest$sales))^2)
SSE # 695567050815 239959900535
SST=sum((exp(salesTest$sales)-exp(mean(salesTrain$sales)))^2)
SST # 791261170663
R2=1-(SSE/SST)
R2 # 0.6967374

prediction2=predict(LR1,newdata=salesTest)
prediction2
salesTest$sales
SSE=sum((prediction2-salesTest$sales)^2)
SSE # 110251
SST=sum((salesTest$sales-mean(salesTrain$sales))^2)
SST # 1214154
R2=1-(SSE/SST)
R2 # 0.9091952

library(rpart)
library(rpart.plot)
tree=rpart(sales~., data = salesTrain)
tree.pred=predict(tree,newdata = salesTest)
tree.pred
salesTest$sales
tree.sse=sum((tree.pred-salesTest$sales)^2)
tree.sse  #169941.9

test=read.csv("test.csv")
test$store_nbr=as.factor(test$store_nbr)
test$family=as.factor(test$family)
test$date=as.Date(test$date,format = "%Y-%m-%d")

testcom=merge(oil,test,by="date",all.y = TRUE)
str(testcom)
hist(testcom$dcoilwtico)
summary(testcom)
testcom$dcoilwtico[is.na(testcom$dcoilwtico)]=median(testcom$dcoilwtico[!is.na(testcom$dcoilwtico)])
str(testcom)
hist(testcom$dcoilwtico)

summary(testcom$onpromotion)
hist(testcom$onpromotion)
testcom$onpromotion=log(testcom$onpromotion+3)
hist(testcom$onpromotion)


actualpred=predict(LR1,newdata=testcom)
actualpred
actualpred2=abs(actualpred-3)
actualpred2
sub1=data.frame(id=test$id,sales=actualpred2)
str(sub1)
write.csv(sub1,"Team3Week2cor3.csv", row.names = F)

table(is.na(actualpred2))




### DECISION TREE
train=read.csv("train.csv")
str(train)
train=train[train$sales!=0,]
str(train)
train$store_nbr=as.factor(train$store_nbr)
train$family=as.factor(train$family)
train$date=as.Date(train$date,format = "%Y-%m-%d")
str(train)
hist(train$sales)
hist(train$onpromotion)
summary(train$sales)
summary(train$onpromotion)
train$sales=log(train$sales+3)# log() function
train$onpromotion=log(train$onpromotion+3)
hist(train$onpromotion)
hist(train$sales)


set.seed(3000)
spl = sample(nrow(train), 0.8*nrow(train))
salesTrain = train[spl,]
salesTest = train[-spl,]
nrow(salesTrain)
nrow(salesTest)
any(is.na(salesTrain))
str(salesTrain)


LR1= lm(sales~., data = salesTrain)
summary(LR1) # Multiple R-squared:  0.9075,	Adjusted R-squared:  0.9075 

LR2=lm(sales~.-id,data = salesTrain)
summary(LR2) # Multiple R-squared:  0.9074,	Adjusted R-squared:  0.9074  

LR3=lm(sales~.-date,data = salesTrain)
summary(LR3) # Multiple R-squared:  0.9027,	Adjusted R-squared:  0.9027 

LR4=lm(sales~store_nbr+family+onpromotion,data = salesTrain)
summary(LR4) # Multiple R-squared:  0.9024,	Adjusted R-squared:  0.9024 

LR5=lm(sales~date+family+onpromotion,data = salesTrain)
summary(LR5) # Multiple R-squared:  0.8564,	Adjusted R-squared:  0.8564

LR6=lm(sales~id+date+store_nbr+onpromotion,data = salesTrain)
summary(LR6) # Multiple R-squared:  0.5869,	Adjusted R-squared:  0.5869 

LR7=lm(sales~id+date+family+onpromotion,data = salesTrain)
summary(LR7) # Multiple R-squared:  0.8611,	Adjusted R-squared:  0.8611 

library(rpart)
library(rpart.plot)
tree=rpart(sales~., data = salesTrain)
tree.pred=predict(tree,newdata = salesTest)
tree.pred
salesTest$sales
tree.sse=sum((tree.pred-salesTest$sales)^2)
tree.sse  # 249268.4

tree2=rpart(sales~.-id, data = salesTrain)
tree.pred2=predict(tree2,newdata = salesTest)
tree.pred2
salesTest$sales
tree.sse2=sum((tree.pred2-salesTest$sales)^2)
tree.sse2 # 249268.4

prediction1=exp(predict(exp(LR1),newdata=salesTest))
prediction1
predictiontest=(prediction1-3)
predictiontest
salesTest$sales
SSE=sum((predictiontest-exp(salesTest$sales))^2)
SSE # 695567050815 239959900535
SST=sum((exp(salesTest$sales)-exp(mean(salesTrain$sales)))^2)
SST # 791261170663
R2=1-(SSE/SST)
R2 # 0.6967374

prediction2=predict(LR1,newdata=salesTest)
prediction2
salesTest$sales
SSE=sum((prediction2-salesTest$sales)^2)
SSE # 162569.8
SST=sum((salesTest$sales-mean(salesTrain$sales))^2)
SST # 1750270
R2=1-(SSE/SST)
R2 # 0.9071173

test=read.csv("test.csv")
test$store_nbr=as.factor(test$store_nbr)
test$family=as.factor(test$family)
test$date=as.Date(test$date,format = "%Y-%m-%d")
str(test)
summary(test$onpromotion)
hist(test$onpromotion)
test$onpromotion=log(test$onpromotion+3)
hist(test$onpromotion)


actualpred=exp(predict(tree,newdata=test))
actualpred2=abs(actualpred-3)
actualpred2
sub1=data.frame(id=test$id,sales=actualpred2)
str(sub1)
write.csv(sub1,"Team3Week2decisiontree.csv", row.names = F)

table(is.na(actualpred2))







                                      ### WEEKL23
train=read.csv("train.csv")
str(train)
train=train[train$sales!=0,]
train=train[train$sales<4000,]
str(train)
train$store_nbr=as.factor(train$store_nbr)
train$family=as.factor(train$family)
train$date=as.Date(train$date,format = "%Y-%m-%d")
str(train)
hist(train$sales)
hist(train$onpromotion)
summary(train$sales)
summary(train$onpromotion)
train$sales=log(train$sales+3)# log() function
train$onpromotion=log(train$onpromotion+3)
hist(train$onpromotion)
hist(train$sales)


set.seed(3000)
spl = sample(nrow(train), 0.8*nrow(train))
salesTrain = train[spl,]
salesTest = train[-spl,]
nrow(salesTrain)
nrow(salesTest)
any(is.na(salesTrain))
str(salesTrain)


LR1= lm(sales~., data = salesTrain)
summary(LR1) # Multiple R-squared:  0.9004,	Adjusted R-squared:  0.9004 

LR2=lm(sales~.-id,data = salesTrain)
summary(LR2) # Multiple R-squared:  0.9003,	Adjusted R-squared:  0.9003  

LR3=lm(sales~.-date,data = salesTrain)
summary(LR3) #  

LR4=lm(sales~store_nbr+family+onpromotion,data = salesTrain)
summary(LR4) #  

LR5=lm(sales~date+family+onpromotion,data = salesTrain)
summary(LR5) # 

LR6=lm(sales~id+date+store_nbr+onpromotion,data = salesTrain)
summary(LR6) #  

LR7=lm(sales~id+date+family+onpromotion,data = salesTrain)
summary(LR7) #  

prediction1=exp(predict(exp(LR1),newdata=salesTest))
prediction1
predictiontest=(prediction1-3)
predictiontest
salesTest$sales
SSE=sum((predictiontest-exp(salesTest$sales))^2)
SSE # 695567050815 239959900535
SST=sum((exp(salesTest$sales)-exp(mean(salesTrain$sales)))^2)
SST # 791261170663
R2=1-(SSE/SST)
R2 # 0.6967374

prediction2=predict(LR1,newdata=salesTest)
prediction2
salesTest$sales
SSE=sum((prediction2-salesTest$sales)^2)
SSE # 153860.5
SST=sum((salesTest$sales-mean(salesTrain$sales))^2)
SST # 533555
R2=1-(SSE/SST)
R2 # 0.8996707

test=read.csv("test.csv")
test$store_nbr=as.factor(test$store_nbr)
test$family=as.factor(test$family)
test$date=as.Date(test$date,format = "%Y-%m-%d")
str(test)
summary(test$onpromotion)
hist(test$onpromotion)
test$onpromotion=log(test$onpromotion+3)
hist(test$onpromotion)


actualpred=exp(predict(LR1,newdata=test))
actualpred2=abs(actualpred-3)
actualpred2
sub1=data.frame(id=test$id,sales=actualpred2)
str(sub1)
write.csv(sub1,"Team3Week22.csv", row.names = F)

table(is.na(actualpred2))
