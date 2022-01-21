set.seed(42) #Initializes the number of instances to be taken as 42, same as use table values
a <- state("SS","HH","DD") #Define current obkcet states
b <- list(a, a)
n_days <- 300 #Consider the highest number of days

#Define the transition matcrix of 3 rows and 3 columns assignining it a variable of transition matrix
transition_matrix <- matrix(c(a, 0.3, 0.001,
                            0.4, b, 0.01,
                            0, 0, 1), nrow=3, ncol=3, byrow=TRUE)


state <- 1 #Consider initial state as 1 and begin check within the 300 days
patient_record <- rep(0, n_days) 

for (day in 1:n_days) {
  pr <- transition_matrix[state, ]

  state <- sample(c(1:3), size = 1, prob = pr)
  patient_record[day] <- state
}

#Plot the matrix probablility
plot(1:n_days, patient_record, "l") 

####

library(tidyverse)
load("assess_data_21.Rdata")
pca_x <- t(log(Y + 1))
pca_res1 <- prcomp(pca_x, center = TRUE, scale = TRUE)
pc_df1 <- data.frame(pca_res1$x[1:21, 1:21], tissue = patient_data$tissue[1:21],
patient = patient_data$patient[1:21])
ggplot(pc_df1, aes(x = PC1, y = PC2, shape = tissue, col = patient)) +
geom_point(size = 4)

















