rm(list=ls())
# Logistic Regression in R

# Load Packages
library(stats)
library(MASS)
library(caret)
library(ggplot2)

# Import Cleaned Med Data
med <- read.csv("E:/WGU/D208/Task 2/med_clean.csv")

# Convert All Variables to Factors
med[] <- lapply(med, factor, levels = c("No", "Yes"))

# Create the Initial Model
lr_model <- glm(ReAdmis ~., data = med, family = binomial)
summary(lr_model) # BackPain and Asthma have p-values the closest to 0.05 so we will reduce the model with these two predictor variables

# Reduce the Model using Train and Testing Data
set.seed(1)
trainIndex <- sample(1:nrow(med), 0.7*nrow(med))
training <- med[trainIndex, ]
testing <- med[-trainIndex,]
reduced_lr_model <- glm(ReAdmis ~ BackPain + Asthma, data = training, family = binomial)
summary(reduced_lr_model)

# Create Confusion Matrix
predicted_probs <- predict(reduced_lr_model, newdata = testing, type = "response")
hist(predicted_probs) # Centered around approx 0.367
predicted_classes <- ifelse(predicted_probs > 0.367, "Yes", "No")
cm <- confusionMatrix(as.factor(predicted_classes), testing$ReAdmis)
cm

# Accuracy Calculator
accuracy <- sum(predicted_classes == testing$ReAdmis) / length(predicted_classes)
accuracy

# Create Regression Equation for the Reduced Model
reduced_coef <- coef(reduced_lr_model)
regression_eq <- sprintf("log(p/(1-p)) = %.5f + (%.5f * BackPainYes) + (%.5f * AsthmaYes)",
            reduced_coef["(Intercept)"],
            reduced_coef["BackPainYes"],
            reduced_coef["AsthmaYes"])
print(regression_eq)
