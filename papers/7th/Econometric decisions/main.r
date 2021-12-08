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

Call:
glm(formula = psi ~ tuce + gpa + grade + lette, family = binomial, 
    data = grade)

Deviance Residuals: 
    Min       1Q   Median       3Q      Max  
-1.7647  -0.8474  -0.6056   0.8341   1.9234  

Coefficients: (1 not defined because of singularities)
            Estimate Std. Error z value Pr(>|z|)  
(Intercept)  2.50685    3.72800   0.672   0.5013  
tuce         0.02359    0.11560   0.204   0.8383  
gpa         -1.28341    1.21369  -1.057   0.2903  
grade        2.40763    1.42364   1.691   0.0908 .
letteB      -0.29410    1.05940  -0.278   0.7813  
letteC            NA         NA      NA       NA  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for binomial family taken to be 1)

    Null deviance: 43.860  on 31  degrees of freedom
Residual deviance: 36.293  on 27  degrees of freedom
AIC: 46.293

Number of Fisher Scoring iterations: 4