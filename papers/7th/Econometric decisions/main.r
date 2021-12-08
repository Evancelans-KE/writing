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
>

##CALCULATE COB DOUGLAS EQUATION

library(micEcon)
> productionOutput <- production$valuedadd
> QuantityInputs <-production$capital
> productionTime <- c(1:20)
estResult <-  translogEst( "valueadd", c( "labor","capital", "productionTime"),
                           production, linear = TRUE )

