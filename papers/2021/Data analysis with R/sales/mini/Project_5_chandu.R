rm(list=ls())
train=read.csv("train.csv")
submission=read.csv("sample_submission.csv")
train=train[train$transactions!=0,]
train=train[train$transactions<10000,]
train$store_nbr=as.factor(train$store_nbr)
train$family=as.factor(train$family)
train$date=as.Date(train$date,format = "%Y-%m-%d")
train$transactions=log(train$transactions+3)# log() function
train$onpromotion=log(train$onpromotion+3)

set.seed(1212)
spl = sample(nrow(train), 0.75*nrow(train))
transactionsTrain = train[spl,]
#transactionsTest = train[-spl,]

LR1= lm(transactions~., data = transactionsTrain)
summary(LR1)

test=read.csv("test.csv")
test$store_nbr=as.factor(test$store_nbr)
test$family=as.factor(test$family)
test$date=as.Date(test$date,format = "%Y-%m-%d")

test$onpromotion=log(test$onpromotion+3)



p1=exp(predict(LR1,newdata=test))
p2=abs(p1-3)
summary(p2)
P_dataframe=as.data.frame(p2)

submission$transactions=P_dataframe$p2

write.csv(submission,"Project_5_chandu.csv",row.names = F)

> tree <- rpart(formula = transactions~transactions, data=transactions, control = rpart.control(maxdepth = 3, minbucket = 1),cp = 0)
> prp(tree,fatransactionsen = 0, cex = 0.8, extra = 1)



