# Data Cleaning and Transformation For D208 Part 1

# Import Med Data
med <- read.csv("E:/WGU/D208/Task 1/medical_clean.csv")

# Remove Unwanted Variables
med <- subset(med, select = c(Age, Gender, Doc_visits, Initial_admin, Complication_risk, Services, Initial_days, TotalCharge))

# Check for Missing Data
colSums(is.na(med)) # There is no missing data

# Check for Duplicates
med <- med[!duplicated(med), ]

# Check for Outliers in Numeric Data Using Boxplots
boxplot(med$Age)
boxplot(med$Doc_visits)
boxplot(med$Initial_days)
boxplot(med$TotalCharge) # There are no outliers in any of our numerical data

# Encode Categorical Variables
med_gender <- model.matrix(~Gender - 1, med)
med_initial_admin <- model.matrix(~Initial_admin - 1, med)
med_comp_risk <- model.matrix(~Complication_risk -1, med)
med_services <- model.matrix(~Services - 1, med)
med <- cbind(med, med_gender, med_initial_admin, med_comp_risk, med_services)

# Omit the Original Categorical Variables to prevent Multicollinearity
med <- subset(med, select = -c(Gender, Initial_admin, Complication_risk, Services))

# Will Not Scale continuous data as that will affect interpretability

# Write to CSV file
write.csv(med, file = "E:/WGU/D208/Task 1/med_clean.csv", row.names = FALSE)

