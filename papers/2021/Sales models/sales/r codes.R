--Getting the coefficient correlation  between the transactionsuster and the transactions they belong to:

> transactions <- read_csv("ci.csv")
>print(transactions)
Rows: 54 Columns: 5                                                                            
-- Column specification -----------------------------------------------------------------------
Delimiter: ","
chr (3): transactionsuster,transactions


i Use `spec()` to retrieve the full column specification for this data.
i Specify the column types or set `show_col_types = FALSE` to quiet this message.
> View(transactions)
> cor(transactions$transactionsuster, transactions$transactions)
[1] -0.05928399


-------Plotting the correlation graph

> library(ggplot2)
> ggplot(transactions) + aes(x = transactionsuster, y = transactions) + geom_point(colur = "#0c4c8a")+ theme_minimal()

---time series modelling

#STEP 1
> View(transactions_transactions_1)
> plot.ts(transactions_transactions_1)

#STEP 2 
# MODELING THE TIME SERIES OF VARIOUS CITY transactions

> library(ggplot2) ggplot(transactions, aes(city, transactionsuter)) + geom_line()
Error: unexpected symbol in "library(ggplot2) ggplot"
> library(ggplot2)
> ggplot(transactions, aes(city, transactions)) + geom_line()

#STEP 3 
# PREDCICT THE SHOP transactions

plot(diff(log(transactions$transactions)),type='l', main='log returns plot')

#STEP 4 STATIONARISE OUR TIME SERIES

>adf.test(diff(log(as.numeric(transactions$transactions))), alternative="stationary", k=0)

#STEP 5
#DETERMINE OUR ACF AND PACF ON OUR DATASET

>acf(diff(log(transactions$transactions)))
>pacf(diff(log(transactions$transactions)))

#STEP 6
#CALL OUR FORECAST LIBRARY INStransactionsusterE ARIMA MODEL 
> library(forecast)
> (fit <- arima(diff(log(transactions$transactions)), c(3, 0, 1)))

#FITTING OUR ARIMA

> fitARIMA <- auto.arima(diff(log(transactions$transactions)), trace=TRUE)

#CHECKNG TO SEE HOW OUR ARIMA MODEL FITTED WITH THE TRAINING DATASET

> plot(as.ts(diff(log(store$transactions))) )
> lines(fitted(fitARIMA), col="red")

#STEP 7  
#MAKING A PREDICTION BASED ON OUR ARIMA MODEL

 >futurVal <- forecast(fitARIMA,h=5, level=c(99)) 
> plot(forecast(futurVal))





##RNN MODEL 

##STEP 1 
##SETTING OUR MODEL PARAMETERS

> View(transactions)
> max_len <- 6
> batch_size <- 32
> total_epochs <- 15
> set.seed(123)
> store_type <- transactions$type

## STEP 2 
##HERE WE SELECT THE DATASET COLUMN THAT WE WANT TO FORECAST

> table(store_type)
store_type
 A  B  C  D  E 
 9  8 15 18  4 

## STEP 3
 ##WE USE MOVING BLOCK SUB SAMPLING TO ENABLE US CUT OUR VECTOR INTO SMALL BITS FOR EASIER SAMPLING

> start_indexes <- seq(1, length(store_type)- (max_len + 1), by = 3)
> transactions_matrix <- matrix(nrow = length(start_indexes), ncol = max_len + 1)
> for (i in 1:length(start_indexes)){transactions_matrix [i,] + max_len)]}

> for (i in 1:length(start_indexes))
{transactions_matrix [i,] <-store_type[start_indexes[i]:(start_indexes[i] + max_len)]}

#REMOVE WARNING MESSAGES
> dev.off()
null device

## STEP 4
#WE REMOVE N/A values and converting our matrix to NUMERIC       
> for (i in 1:length(start_indexes))
{transactions_matrix [i,] <-store_type[start_indexes[i]:(start_indexes[i] + max_len)]}
> transactions_matrix <- transactions_matriX * 1 
> transactions_matrix <- suppressWarnings(as.numeric(transactions_matrix) * 1) 
> if(anyNA(transactions_matrix)){
+     transactions_matrix <- na.omit(transactions_matrix)
+ }
 
## STEP 5
#SEPARATE OUR DATA INTO PREVIOUS DAYS AND THEN DEFINE DAYS WE WANT TO PREDICT FOR THE STORE TYPE IN Y VARIABLE

X <- transactions_matrix[,-ncol(transactions_matrix)]
y <- transactions_matrix[,ncol(transactions_matrix)]

## STEP 6
# THIS INDEXING WILL SEPARATE OUR DATA INTO TRAINING AND TESTING UNITS
training_index <- createDataPartition(y, p = .9, 
                                  list = FALSE, 
                                  times = 1)
## STEP 7
# THEN TRAIN THE DATA
X_train <- array(X[training_index,], dim = c(length(training_index), max_len, 1))
y_train <- y[training_index]

## STEP 7
# THEN TEST THE DATA
X_test <- array(X[-training_index,], dim = c(length(y) - length(training_index), max_len, 1))
y_test <- y[-training_index]

## STEP 8
# DEFINE A NEW MODEL FOR THE transactions DATASET
transactions_transactions_model <- keras_model_sequential()

# DEFINE NEW DIMENSIONS FOR INPUT DATA
dim(X_train)

## STEP 9
# THEN DEFINE INPUT LAYER OF THE MODEL
transactions_transactions_model %>%
    layer_dense(input_shape = dim(X_train)[2:3], units = max_len)

transactions_transactions_model %>% 
    layer_simple_rnn(units = 6)

transactions_transactions_model %>%
    layer_dense(units = 1, activation = 'sigmotransactionsuster')  

# TO GET A SUMMARY OF THE MODEL STRUCTURE USE summary command
summary(transactions_transactions_model)

transactions_transactions_model %>% compile(loss = 'binary_crossentropy', 
                  optimizer = 'RMSprop', 
                  metrics = c('accuracy'))

## STEP 10
# TRAINING THE MODEL
transactions_transactions_training_model <- transactions_transactions_model %>% fit(
    x = X_train,  
    y = y_train,  
    batch_size = batch_size, 
    epochs = total_epochs,  
    valtransactionsusteration_split = 0.1)  

## STEP 11
# PREVIEW THE MODEL
transactions_transactions_training_model 

# PLOT THE RESULTING MODEL AS TRAINED
plot(transactions_transactions_training_model)

## STEP 12
# CONDUCT AN RNN FORCASTING ON THE STORE TYPE
transactionsass_prediction <- transactions_transactions_model %>% predict_transactionsass_prediction(X_test, batch_size = batch_size)




