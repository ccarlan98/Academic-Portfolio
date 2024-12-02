# Load Packages 
library(randomForest)
library(tidyverse)
library(caret)
library(caTools)
library(pROC)

# Import Data Set
med <- read.csv("E:/WGU/D209/Task 2/medical_clean.csv")

# Remove Unwanted Data
med <- subset(med, select = c(ReAdmis, Item1, Item2, Item3, Item4, Item5, Item6, Item7, Item8))

# Rename Item Variables
med <- med %>% 
  rename (
    TimelyAdmission = Item1,
    TimelyTreatment = Item2,
    TimelyVisits = Item3,
    Reliability = Item4,
    Options = Item5,
    Hours_of_Treatment = Item6,
    CourteousStaff = Item7,
    Evidence_of_Active_Listening = Item8
  )

# Check for Missing Data
colSums(is.na(med)) # No Missing Data

# Change ReAdmins Value to 0 for No and 1 For Yes then change to Numeric
med$ReAdmis[med$ReAdmis == "Yes"] <- 1
med$ReAdmis[med$ReAdmis == "No"] <- 0
med$ReAdmis <- as.numeric(med$ReAdmis)

# Write Cleaned Data Set to CSV File
write.csv(med, file = "E:/WGU/D209/Task 2/med_clean.csv", row.names = FALSE)

# Set the Seed
set.seed(1)

# Create Training and Testing Data Sets
myIndex <- createDataPartition(med$ReAdmis, p = 0.7, list = FALSE)
med_train <- med[myIndex, ]
med_test <- med[-myIndex, ]

# Write Training and Testing to CSV Files
write.csv(med_train, file = "E:/WGU/D209/Task 2/Training.csv", row.names = FALSE)
write.csv(med_test, file = "E:/WGU/D209/Task 2/Testing.csv", row.names = FALSE)

# Change Target Variable to Factor
med$ReAdmis <- as.factor(med$ReAdmis)
med_train$ReAdmis <- as.factor(med_train$ReAdmis)
med_test$ReAdmis <- as.factor(med_test$ReAdmis)

# Random Forest Model
model <- randomForest(ReAdmis~., data = med_train)
model

# Make Predictions using the Test Data
pred_test <- predict(model, newdata = med_test, type = "class")

# Make Confusion Matrix
cm <- confusionMatrix(pred_test, med_test$ReAdmis, positive = "1")
cm

# MSE is not viable for classification so we will use AUC here

# Calculate the AUC using Predicted Probabilities
roc_pred_test <- predict(model, newdata = med_test, type = "prob")
probs <- roc_pred_test[, "1"]
roc_object <- roc(med_test$ReAdmis, probs)
auc(roc_object)
plot(roc_object, main="ROC", col="red")
