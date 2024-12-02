rm(list=ls())
# Data Cleaning for D214 Part 2

# Load Libraries
library(dplyr)
library(ggplot2)
library(caret)

# Import Data Set
df <- read.csv("E:/WGU/D214/Task 2/rushing_stats.csv")

# Subset the data to only include our predictor variables
df <- select(df, Age, GS, rAtt, rYds, rTD, r1D, rLng, rY.A, rY.g, Fmb)

# Check for Missing Data
colSums(is.na(df)) # There is no missing data

# Check for outliers for each variable using a boxplot
boxplot(df$Age, main="Boxplot for Age", ylab="Age")
boxplot(df$GS, main="Boxplot for Games Started", ylab="Games Started") # No outliers present
boxplot(df$rAtt, main="Boxplot for Rushing Attempts", ylab="Rushing Attempts")
boxplot(df$rYds, main="Boxplot for Rushing Yards", ylab="Rushing Yards")
boxplot(df$rTD, main="Boxplot for Rushing TDs", ylab="Rushing TDs")
boxplot(df$r1D, main="Boxplot for Rushing First Downs", ylab="Rushing First Downs")
boxplot(df$rLng, main="Boxplot for Longest Rush", ylab="Longest Rush")
boxplot(df$rY.A, main="Boxplot for Rushing Yards per Attempt",  ylab="Rushing Yards per Attempt")
boxplot(df$rY.g, main="Boxplot for Rushing Yards per Game", ylab="Rushing Yards per Game")
boxplot(df$Fmb, main="Boxplot for Fumbles", ylab="Fumbles")
# All fields except for GS has outliers present
# Will keep all outliers within this data set as the RF algorithm can handle them well but it is also expected that first stringers and star athletes will have more rAtt, rYds, etc than those on varying positions on team depth charts

# Write cleaned data to CSV file
write.csv(df, file = "E:/WGU/D214/Task 2/rushing_cleaned.csv", row.names = FALSE)

# Create training and testing data sets using an 80-20 split
set.seed(123)
myIndex <- createDataPartition(df$rTD, p = 0.8, list = FALSE)
df_train <- df[myIndex, ]
df_test <- df[-myIndex, ]

# Write training and testing to CSV files
write.csv(df_train, file = "E:/WGU/D214/Task 2/training.csv", row.names = FALSE)
write.csv(df_test, file = "E:/WGU/D214/Task 2/testing.csv", row.names = FALSE)
