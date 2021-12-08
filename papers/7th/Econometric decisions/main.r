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