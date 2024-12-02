rm(list=ls())
# Random Forest Regression Algorithm for D214 Part 2

# Load Packages
library(randomForest)
library(caret)

# Import Data Sets
df <- read.csv("E:/WGU/D214/Task 2/rushing_cleaned.csv")
df_train <- read.csv("E:/WGU/D214/Task 2/training.csv")
df_test <- read.csv("E:/WGU/D214/Task 2/testing.csv")

# Use cross-validation to determine the best value for mtry using 500 trees in the RF model
set.seed(123)
train_control <- trainControl(method="cv", number=5) # 5-fold CV
tuneGrid <- expand.grid(.mtry=c(2, 3, 4, 5))
model <- train(rTD ~ ., data=df_train, method="rf", ntree = 500, trControl=train_control, tuneGrid=tuneGrid)
print(model$bestTune) # Best value for mtry is 5

# Train the Random Forest Model
rf_model <- randomForest(rTD ~ ., data = df_train, ntree = 500, mtry = 5)
print(rf_model)

# Use the RF Model to make predictions against the testing data
predictions <- predict(rf_model, df_test)
comparison <- data.frame(Actual = df_test$rTD, Predicted = predictions)
print(head(comparison))

# Calculate MSE, RSME, and MAE to determine model accuracy
mse <- mean((predictions - df_test$rTD)^2)
rmse <- sqrt(mse)
mae <- mean(abs(predictions - df_test$rTD))
cat("Mean Squared Error:", mse, "\n") # MSE of 1.592295
cat("Root Mean Squared Error:", rmse, "\n") # RMSE of 1.261862
cat("Mean Absolute Error:", mae, "\n") # MAE of 0.6596553

# Calculate R-squared
sst <- sum((df_test$rTD - mean(df_train$rTD))^2)
ssr <- sum((predictions - df_test$rTD)^2)
r_squared <- 1 - ssr / sst
cat("R-squared:", r_squared, "\n") # R-squared value of 0.768542

# Plotting Actual vs. Predicted Values
plot(df_test$rTD, predictions, main = "Actual vs. Predicted Rushing Touchdowns", 
     xlab = "Actual Rushing Touchdowns", ylab = "Predicted Rushing Touchdowns", pch = 16)
abline(0, 1, col = "red")  # Adds a 45-degree line for reference

# Determining which variables are the most statistically significant
importance <- importance(rf_model)
print(importance)
varImpPlot(rf_model)
