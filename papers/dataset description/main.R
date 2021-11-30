#LOADING DATASET TO PREVIEW HEADS
> data(Smarket)
> names(Smarket)
[1] "Year"      "Lag1"      "Lag2"      "Lag3"      "Lag4"      "Lag5"     
[7] "Volume"    "Today"     "Direction"
> head(Smarket)

#Summarry of the dataset 
> summary(Smarket)

#GETTING THE CORRELATIONSHIP IN THE DATASET;

> `?`(Smarket)
> attach(Smarket)
> cor(Smarket[, -9])

#UNDERATAKNG LOGISTIC REGRESSION

> glm.fit = glm(Direction ~ Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume, data = Smarket, family = binomial)
> summary(glm.fit)

# ANALYSING THE TARINING SET 

> glm.probs = predict(glm.fit, type = "response")
> length(glm.probs)
[1] 1250
> glm.probs[1:10]
        1         2         3         4         5         6         7 
0.5070841 0.4814679 0.4811388 0.5152224 0.5107812 0.5069565 0.4926509 
        8         9        10 
0.5092292 0.5176135 0.4888378 
> contrasts(Direction)
     Up
Down  0
Up    1

#CLACULATE THE CORRECT PREDICTION WAS RIGHT

> glm.pred = rep("Down", 1250)
> glm.pred[glm.probs > 0.5] = "Up"
> # Produce a confusion matrix
> table(glm.pred, Direction)
        Direction
glm.pred Down  Up
    Down  145 141
    Up    457 507
> mean(glm.pred == Direction)
[1] 0.5216


glm.probs <- predict(glm.fit, Smarket.2005, type = "response")
glm.pred = rep("Down", nrow(Smarket.2005))
glm.pred[glm.probs > 0.5] = "Up"
table(glm.pred, Direction.2005)

mean(glm.pred == Direction.2005)

mean(glm.pred != Direction.2005)

#REFFITITNG THE MODEL
glm.fit = glm(Direction ~ Lag1 + Lag2, data = Smarket, family = binomial, subset = train)
glm.probs = predict(glm.fit, Smarket.2005, type = "response")
glm.pred = rep("Down", nrow(Smarket.2005))
glm.pred[glm.probs > 0.5] = "Up"
table(glm.pred, Direction.2005)

#THEN WE PREDICT

predict(glm.fit, newdata = data.frame(Lag1 = c(1.2, 1.5), Lag2 = c(1.1, -0.8)), 
type = "response")

#PLOT THE SCATTER GRAPH
pairs(Smarket)

#WE PLOT THE VOLUME GRAPH
plot(Volume)

#FIT AND TRAIN DATA 
> library(MASS)
> lda.fit = lda(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
> lda.fit

#APPLYING THE PREDICT FUNCTIONS ON THE TEST 


> Smarket.2005 = Smarket[!train, ]
> lda.pred = predict(lda.fit, Smarket.2005)
> names(lda.pred)
[1] "class"     "posterior" "x"        
> lda.class = lda.pred$class
> Direction.2005 = Direction[!train]
> table(lda.class, Direction.2005)
         Direction.2005
lda.class Down  Up
     Down   35  35
     Up     76 106
> mean(lda.class == Direction.2005)
[1] 0.5595238
> sum(lda.pred$posterior[, 1] >= 0.5)
[1] 70
> sum(lda.pred$posterior[, 1] < 0.5
+ )
[1] 182
> lda.pred$posterior[1:20, 1]
      999      1000      1001      1002      1003      1004      1005 
0.4901792 0.4792185 0.4668185 0.4740011 0.4927877 0.4938562 0.4951016 
     1006      1007      1008      1009      1010      1011      1012 
0.4872861 0.4907013 0.4844026 0.4906963 0.5119988 0.4895152 0.4706761 
     1013      1014      1015      1016      1017      1018 
0.4744593 0.4799583 0.4935775 0.5030894 0.4978806 0.4886331 

#PLOT THE MODEL DATA 

> lda.class[1:20]
 [1] Up   Up   Up   Up   Up   Up   Up   Up   Up   Up   Up   Down Up   Up  
[15] Up   Up   Up   Down Up   Up  
Levels: Down Up
> plot(lda.fit)
>

#QDA MODEL

> library(MASS)
> library(dplyr)
> library(ISLR)
> select <- dplyr::select
> train = Smarket %>%
+ filter(Year < 2005)
> model_QDA = qda(Direction~Lag1+Lag2, data = train)
> model_QDA

#DETERMINE THE DIRECTION OF THE MODEL

> predictions_QDA = data.frame(predict(model_QDA, test))
> test = Smarket %>% filter(Year >= 2005)
> predictions_QDA = data.frame(predict(model_QDA, test))
> predictions_QDA = cbind(test, predictions_QDA)
> predictions_QDA %>% count(class, Direction)

#PREDICT THE DIRECTION OF THE MARKET 
> predictions_QDA %>% summarize(score = mean(class == Direction))