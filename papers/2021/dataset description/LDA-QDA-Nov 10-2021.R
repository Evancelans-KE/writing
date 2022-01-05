
#############################################################
#############################################################
library(MASS)
library(dplyr)
library(ISLR)
library(InformationValue)
library(MLmetrics)
library(rrr)

#############################################################
head(Smarket)
train = Smarket %>%
  filter(Year < 2005)

test = Smarket %>%
  filter(Year >= 2005)

model_LDA = lda(Direction~Lag1+Lag2, data = train)
#summary(model_LDA)

print(model_LDA)

#############################################################
#############################################################
plot(model_LDA)
par("mar")
# #[1] 5.1 4.1 4.1 2.1
# par(mar=c(2,2,2,2))
#par(mar=c(5.1, 4.1, 4.1, 2.1))
# par(mar=c(2.5, 2.5, 2.5, 2.5))
# plot(model_LDA)

#############################################################
#############################################################
# plot(model_LDA, panel = function(x, y, ...) { points(x, y, ...) },
#      col = c(4,2)[factor(test$UpPrd)], 
#      pch = c(17,19)[factor(test$UpPrd)],
#      ylim=c(-3,3), xlim=c(-5,5))

#############################################################
#############################################################
pred_LDA_Train = data.frame(predict(model_LDA, train))
names(pred_LDA_Train)

pred_LDA_True = cbind(train, pred_LDA_Train)
head(pred_LDA_True)

pred_LDA_True %>%
  count(class, Direction)

pred_LDA_True %>%
  summarize(score = mean(class == Direction))


#############################################################
#############################################################
np <- 250
nd.Lag1 <- seq(from = min(train$Lag1), to = max(train$Lag1), length.out = np)
nd.Lag2 <- seq(from = min(train$Lag2), to = max(train$Lag2), length.out = np)
nd <- expand.grid(Lag1 = nd.Lag1, Lag2 = nd.Lag2)
names(nd)

predictions_LDA_2 <- as.numeric(predict(model_LDA, nd)$class)
#predictions_LDA_2 <- (predict(model_LDA, nd)$class)

plot(train[, 2:3], col = train$Direction, pch = 19)
points(model_LDA$means, pch = "*", cex = 10, col = c("blue", "red"))

contour(x = nd.Lag1, y = nd.Lag2, z = matrix(predictions_LDA_2, nrow = np, ncol = np), 
        levels = c(1,2), add = TRUE, drawlabels = FALSE)


#############################################################
#############################################################
predictions_LDA_2 <- as.numeric(predict(model_LDA, train)$class)
#predictions_LDA_2 <- (predict(model_LDA, nd)$class)

plot(train[, 2:3], col = predictions_LDA_2, pch = 19)
points(model_LDA$means, pch = "+", cex = 3, col = c("black", "red"))

predictions_LDA_2 <- as.numeric(predict(model_LDA, nd)$class)

contour(x = nd.Lag1, y = nd.Lag2, z = matrix(predictions_LDA_2, nrow = np, ncol = np), 
        levels = c(1,2), add = TRUE, drawlabels = FALSE)

# contour(x = train$Lag1, y = train$Lag2, z = matrix(predictions_LDA_2, nrow = nrow(train), ncol = nrow(train)), 
#         levels = c(1,2), add = TRUE, drawlabels = FALSE)

#############################################################
#############################################################
predicted <- predict(model_LDA, test)  # predicted scores
predicted

predictions_LDA = data.frame(predict(model_LDA, test))
names(predictions_LDA)

predictions_LDA_2 = cbind(test, predictions_LDA)

predictions_LDA_2 %>%
  count(class, Direction)

predictions_LDA_2 %>%
  summarize(score = mean(class == Direction))

#############################################################
#############################################################
UpPrd = rep(0,length(predictions_LDA_2$class))
levels(predictions_LDA_2$class)

for(i in 1:length(predictions_LDA_2$class))
{
  if (predictions_LDA_2$class[i] == "Up") 
  {UpPrd[i] = 1}
}  
UpPrd

#############################################################
#############################################################
UpClas = rep(0,length(predictions_LDA_2$Direction))
levels(predictions_LDA_2$Direction)

for(i in 1:length(predictions_LDA_2$Direction))
{
  if (predictions_LDA_2$Direction[i] == "Up") 
  {UpClas[i] = 1}
}  
UpClas

#############################################################
#############################################################
predictions_LDA_2$UpCl = UpClas
predictions_LDA_2$UpPr = UpPrd

head(predictions_LDA_2)

misClassError(predictions_LDA_2$UpCl, predictions_LDA_2$UpPr, threshold = 0.5)
misClassError(predictions_LDA_2$UpPr, predictions_LDA_2$UpCl, threshold = 0.5)

plotROC(actuals=as.numeric(test$Direction)-1,predictedScores=as.numeric(predictions_LDA_2$class)-1)

#############################################################
#############################################################
# Logistic model, for comparison
model_logistic = glm(Direction~Lag1+Lag2, data=train ,family=binomial)

logistic_probs = data.frame(probs = predict(model_logistic, test, type="response"))

predictions_logistic = logistic_probs %>%
  mutate(class = ifelse(probs>.5, "Up", "Down"))

predictions_logistic = cbind(test, predictions_logistic)

predictions_logistic %>%
  count(class, Direction)

predictions_logistic %>%
  summarize(score = mean(class == Direction))

#############################################################
# LDA
#############################################################

model_LDA = lda(Direction~Lag1+Lag2+Lag3, data = train) #Lag3
model_LDA

predictions_LDA = data.frame(predict(model_LDA, test))

predictions_LDA = cbind(test, predictions_LDA)

predictions_LDA %>%
  count(class, Direction)

predictions_LDA %>%
  summarize(score = mean(class == Direction))

#############################################################
# QDA
#############################################################

model_QDA = qda(Direction~Lag1+Lag2, data = train)
model_QDA

predictions_QDA = data.frame(predict(model_QDA, test))

predictions_QDA = cbind(test, predictions_QDA)

predictions_QDA %>%
  count(class, Direction)

predictions_QDA %>%
  summarize(score = mean(class == Direction))

#############################################################
# QDA
#############################################################

model_QDA = qda(Direction~Lag1+Lag2+Volume, data = train) #Lag3
model_QDA

predictions_QDA = data.frame(predict(model_QDA, test))

predictions_QDA = cbind(test, predictions_QDA)

predictions_QDA %>%
  count(class, Direction)

predictions_QDA %>%
  summarize(score = mean(class == Direction))

#summary(model_QDA)
#print(model_QDA)

#plotROC(predictions_QDA$Direction,predictions_QDA$class)
plotROC(actuals=as.numeric(test$Direction)-1,predictedScores=as.numeric(predictions_QDA$class)-1)



data('ActualsAndScores')
plotROC(actuals=ActualsAndScores$Actuals, predictedScores=ActualsAndScores$PredictedScores)
plotROC(predictedScores=ActualsAndScores$PredictedScores,actuals=ActualsAndScores$Actuals)


