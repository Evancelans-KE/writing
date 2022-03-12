##

load(file = "econ_data")
names(econ.data)

##

rm(x, y)
attach(econ_data)

##

plot(x, col = y + 1)

##
dat1 = data.frame(y = factor(y), x)
fit1 = svm(factor(y) ~ ., data = dat1, scale = FALSE, kernel = "radial", cost = 5)


##

xgrid_1 = expand.grid(X1 = px1, X2 = px2)
ygrid_1 = predict(fit1, xgrid)

##

plot(xgrid, col = as.numeric(ygrid_1), pch = 20, cex = .2)
points(x, col = y + 1, pch = 19)

##

func1 = predict(fit, xgrid_1, decision.values = TRUE)
func1 = attributes(func)$decision

xgrid_1 = expand.grid(X1 = px1, X2 = px2)
ygrid_1 = predict(fit, xgrid)
plot(xgrid_1, col = as.numeric(ygrid), pch = 20, cex = .2)
points(x, col = y + 1, pch = 19)

contour(px1, px2, matrix(func, 69, 99), level = 0, add = TRUE)
contour(px1, px2, matrix(func, 69, 99), level = 0.5, add = TRUE, col = "blue", lwd = 2)


