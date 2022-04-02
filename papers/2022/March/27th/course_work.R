library(carData)
data("Salaries")
attach(Salaries) 

##

set.seed(15)
train = sample(nrow(Salaries),0.80*nrow(Salaries))

##

fit.train=lm(salary ~ ., data = Salaries, subset = train)
summary(fit.train)

##

glm.fit = glm(salary ~ ., data=Salaries)
summary(glm.fit)


library(boot)
cv.loo <- cv.glm(Salaries,glm.fit)
cv.loo$delta[1]


##

cv.10K <- cv.glm(Salaries,glm.fit,K=10)
cv.10K$delta[1]

##

library(ISLR)
library(perturb)
lm.fit.all <-lm(Apps~Accept+Enroll+Top10perc+Top25perc+F.Undergrad+P.Undergrad+Outstate+ Room.Board+Books+Personal+PhD+Terminal+S.F.Ratio+perc.alumni+Expend+Grad.Rate, College)
colldiag(lm.fit.all, scale = FALSE, center = FALSE, add.intercept = TRUE)

##

colldiag(lm.fit.all, scale = FALSE, center = TRUE, add.intercept = FALSE)

## 
x=model.matrix(Apps~Enroll+Top10perc+Outstate+Room.Board+PhD+S.F.Ratio+Expend+Grad.Rate, College)
y=College$Apps
ridge.mod=glmnet(x,y,alpha=0,)
ridge.mod

##

ridge.cv = cv.glmnet(x,y, alpha = 0)
plot(ridge.cv)

###

bestlam = ridge.cv$lambda.min
bestlam

[1] 359.4596

coef(ridge.cv, bestlam)

####

set.seed(1)

lasso.mod <- glmnet(x, y, family = "binomial", alpha = 1)
plot(lasso.mod)
lasso.cv <- cv.glmnet(x, y, family = "binomial", alpha = 1) 

cbind("Lambda" = lasso.cv$lambda, 
      "10FCV Deviance" = lasso.cv$cvm)[1:20, ]

plot(lasso.cv)

bestlamda.lasso <- lasso.cv$lambda.min
min.dev.lasso <- min(lasso.cv$cvm)

cbind("Best LASSO Lambda" = bestlamda.lasso, 
      "Best LASSO Deviance" = min.dev.lasso)

lasso.coef.best <- coef(lasso.mod, s=bestlamda.lasso)


lasso.coef.large  <- coef(lasso.mod, s=0.04) 

coef.all <- round(cbind(ridge.coef.best, 
                        ridge.coef.large, 
                        lasso.coef.best, 
                        lasso.coef.large),
                  digits = 3)

colnames(coef.all) <- c("Ridge Best", "Large", "LASSO Best", "Large")

coef.all