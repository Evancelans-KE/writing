##
> library(readr)
Warning message:
package ‘readr’ was built under R version 4.1.1 
> production <- read_csv("class/hello/papers/7th/Econometric decisions/production.csv")
Rows: 27 Columns: 4                                                                                                                  
-- Column specification --------------------------------------------------------------------------
Delimiter: ","
dbl (4): obs, valuedadd, labor, capital

i Use `spec()` to retrieve the full column specification for this data.
i Specify the column types or set `show_col_types = FALSE` to quiet this message.
> View(production)

> str(production)
spec_tbl_df [27 x 4] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
 $ obs      : num [1:27] 1 2 3 4 5 6 7 8 9 10 ...
 $ valuedadd: num [1:27] 657 936 1111 1201 1053 ...
 $ labor    : num [1:27] 162 214 186 246 211 ...
 $ capital  : num [1:27] 280 542 722 1168 812 ...
 - attr(*, "spec")=
  .. cols(
  ..   obs = col_double(),
  ..   valuedadd = col_double(),
  ..   labor = col_double(),
  ..   capital = col_double()
  .. )
 - attr(*, "problems")=<externalptr> 
> 

##CALCULATE COB DOUGLAS EQUATION

library(micEcon)
> productionOutput <- production$valuedadd
> QuantityInputs <-production$capital
> productionTime <- c(1:20)
estResult <-  translogEst( "valueadd", c( "labor","capital", "productionTime"),
                           production, linear = TRUE )

 ##DETERMINING MULTICOLINEARITY 

 > library(corrplot)
corrplot 0.92 loaded
Warning message:
package ‘corrplot’ was built under R version 4.1.2 
> cor1 = cor(production)
> corrplot.mixed(cor1, lower.col = “black”, number.cex = .7)
> corrplot.mixed(cor1, lower.col ="black", number.cex = .7)
>


##GETTING CORRELATION COFFICIENTS
> library(tidyverse)
> cor(production$valuedadd, production$capital)
[1] 0.9753576
> library(ggplot2)
> ggplot(production) +
+     aes(x = capital, y = valueadd) +
+     geom_point(colour = "red") +
+     theme_minimal()
> ggplot(production) +
+     aes(x = production$capital, y = production$valuedadd) +
+     geom_point(colour = "red") +
+     theme_minimal()
>

##GRADE DATA 

> View(grade)
> str(grade)
spec_tbl_df [32 x 6] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
 $ obs  : num [1:32] 1 2 3 4 5 6 7 8 9 10 ...
 $ gpa  : num [1:32] 2.66 2.89 3.28 2.92 4 2.86 2.76 2.87 3.03 3.92 ...
 $ tuce : num [1:32] 20 22 24 12 21 17 17 21 25 29 ...
 $ psi  : num [1:32] 0 0 0 0 0 0 0 0 0 0 ...
 $ grade: num [1:32] 0 0 0 0 1 0 0 0 0 1 ...
 $ lette: chr [1:32] "C" "B" "B" "B" ...
 - attr(*, "spec")=
  .. cols(
  ..   obs = col_double(),
  ..   gpa = col_double(),
  ..   tuce = col_double(),
  ..   psi = col_double(),
  ..   grade = col_double(),
  ..   lette = col_character()
  .. )
 - attr(*, "problems")=<externalptr> 
> 

#CREATE TRAINIGN AND TEST DATA

> set1 <- grade$gpa
> set2 <- grade$tuce
> set.seed(1000)
> logitmodel <- glm(set1,set2)


#MODEL
> glm.fits=glm(psi∼ tuce + gpa + grade + lette, data=grade,family =binomial)
> summary(glm.fits)

#GETTING THE COEFFICIENT FITS

> coef(glm.fits)
(Intercept)        tuce         gpa       grade      letteB      letteC 
 2.50684627  0.02359214 -1.28340785  2.40762555 -0.29409538          NA 
> 

#AND THEN SUMMARY
> summary(glm.fits)$coef
               Estimate Std. Error    z value   Pr(>|z|)
(Intercept)  2.50684627   3.728001  0.6724371 0.50130550
tuce         0.02359214   0.115601  0.2040825 0.83828902
gpa         -1.28340785   1.213690 -1.0574431 0.29030942
grade        2.40762555   1.423644  1.6911705 0.09080424
letteB      -0.29409538   1.059397 -0.2776064 0.78131455
>

#COEFFICIENTS
> library(tidyverse)
> cor(grade$gpa, grade$grade)
[1] 0.4971474
>

ggplot(grade) + aes(x = grade$tuce, y = grade$gpa) + geom_point(colour = "red") +theme_minimal()

#PREDICTING GRADE

> fit_1 <- lm(gpa ~ lette, data = gpa_a)
> summary(fit_1)

Call:
lm(formula = gpa ~ lette, data = gpa_a)

Residuals:
     Min       1Q   Median       3Q      Max 
-1.04273 -0.21250  0.02313  0.25156  0.56727 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   3.4327     0.1191  28.827  < 2e-16 ***
letteB       -0.3527     0.1618  -2.180 0.037519 *  
letteC       -0.6890     0.1835  -3.754 0.000776 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.395 on 29 degrees of freedom
Multiple R-squared:  0.3301,	Adjusted R-squared:  0.2839 
F-statistic: 7.144 on 2 and 29 DF,  p-value: 0.003002

#
> ggplot(data=gpa_a, aes(fit_1$residuals)) +
+     geom_histogram(binwidth = 1, color = "black", fill = "purple4") +
+     theme(panel.background = element_rect(fill = "white"),
+           axis.line.x=element_line(),
+           axis.line.y=element_line()) +
+     ggtitle("Histogram for Model Residuals")
>
#PREDICT GPA
predict(fit_1, data.frame(gpa = 3.5))