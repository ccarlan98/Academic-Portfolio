# Multiple Linear Regression for D208

# Import Packages
library(stats)
library(MASS)
library(caret)
library(ggplot2)
library(car)

# Import Cleaned Medical Data 
med <- read.csv("E:/WGU/D208/Task 1/med_clean.csv") 

# Create Initial Model and Omit the original categorical variables since we created dummy variables
initial_model <- lm(TotalCharge~ ., data = med)
summary(initial_model) #NAs suggest issues with multicollinearity 

# Check alias to figure out which variables are causing problems
alias(initial_model) #GenderNonbinary, Initial_adminObservation.Admission, Complication_riskMedium, ServicesMRI causing issues

# Recreate Initial Model to fix Multicollinearity issues 
initial_model2 <- lm(TotalCharge~ . -GenderNonbinary -Initial_adminObservation.Admission -Complication_riskMedium -ServicesMRI,  data = med)
summary(initial_model2) 

# Use Stepwise Reduction to Reduce the Model
stepwise_model <- step(initial_model2, direction = "both", trace=FALSE)
summary(stepwise_model)

# Create a Residual Plot
plot(stepwise_model$residuals, main = "Residual Plot", ylab = "Residuals", xlab = "Index")

# Residual Standard Error
sigma(stepwise_model)

