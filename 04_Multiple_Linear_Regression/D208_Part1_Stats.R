# Summary Statistics and Univariate/Bivariate Distributions 

# Import Packages
library(ggplot2)

# Import Cleaned Med Data Set
med <- read.csv("E:/WGU/D208/Task 1/medical_clean.csv") 
med <- subset(med, select = c(Age, Gender, Doc_visits, Initial_admin, Complication_risk, Services, Initial_days, TotalCharge))
# Will reuse the original data set and a subset that has not been encoded yet

# Convert Categorical Variables to Factor for the Summary
med$Gender <- as.factor(med$Gender)
med$Initial_admin <- as.factor(med$Initial_admin)
med$Complication_risk <- as.factor(med$Complication_risk)
med$Services <- as.factor(med$Services)

# Display the Summary Statistics
summary(med)

# Generate Univariate Statistics for each variable
# Categorical Variables
Gender_plot <- ggplot(med, aes(x=Gender)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Gender")
Gender_plot

Initial_admin_plot <- ggplot(med, aes(x=Initial_admin)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Initial_admin")
Initial_admin_plot

Comp_risk_plot <- ggplot(med, aes(x=Complication_risk)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Complication_risk")
Comp_risk_plot

Services_plot <- ggplot(med, aes(x=Services)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Services")
Services_plot

# Continuous Variables
Age_plot <- ggplot(med, aes(x=Age)) + 
  geom_histogram() +
  ggtitle("Univariate Distribution of Age")
Age_plot

Doc_visits_plot <- ggplot(med, aes(x=Doc_visits)) + 
  geom_histogram() +
  ggtitle("Univariate Distribution of Doc_visits")
Doc_visits_plot

Initial_days_plot <- ggplot(med, aes(x=Initial_days)) + 
  geom_histogram() +
  ggtitle("Univariate Distribution of Initial_days")
Initial_days_plot

TotalCharge_plot <- ggplot(med, aes(x=TotalCharge)) + 
  geom_histogram() +
  ggtitle("Univariate Distribution of TotalCharge")
TotalCharge_plot # Target Variable

# Generate Bivariate Visualizations against TotalCharge
# Categorical Variables
TotalCharge_Gender_plot <- ggplot(med, aes(x=Gender, y=TotalCharge)) +
  geom_boxplot(aes(fill=Gender)) +
  ggtitle("TotalCharge vs Gender") + 
  xlab("Gender") +
  ylab("TotalCharge")
TotalCharge_Gender_plot

TotalCharge_Admin_plot <- ggplot(med, aes(x=Initial_admin, y=TotalCharge)) +
  geom_boxplot(aes(fill=Initial_admin)) +
  ggtitle("TotalCharge vs Initial_admin") + 
  xlab("Initial_admin") +
  ylab("TotalCharge")
TotalCharge_Admin_plot

TotalCharge_Comp_plot <- ggplot(med, aes(x=Complication_risk, y=TotalCharge)) +
  geom_boxplot(aes(fill=Complication_risk)) +
  ggtitle("TotalCharge vs Complication_risk") + 
  xlab("Complication_risk") +
  ylab("TotalCharge")
TotalCharge_Comp_plot

TotalCharge_Services_plot <- ggplot(med, aes(x=Services, y=TotalCharge)) +
  geom_boxplot(aes(fill=Services)) +
  ggtitle("TotalCharge vs Services") + 
  xlab("Services") +
  ylab("TotalCharge")
TotalCharge_Services_plot

# Continuous Variables
TotalCharge_Age_plot <- ggplot(med, aes(x=Age, y=TotalCharge)) +
  geom_point(alpha=0.5) +
  ggtitle("TotalCharge vs Age") + 
  xlab("Age") +
  ylab("TotalCharge")
TotalCharge_Age_plot

TotalCharge_Doc_plot <- ggplot(med, aes(x=Doc_visits, y=TotalCharge)) +
  geom_point(alpha=0.5) +
  ggtitle("TotalCharge vs Doc_visits") + 
  xlab("Doc_visits") +
  ylab("TotalCharge")
TotalCharge_Doc_plot

TotalCharge_Days_plot <- ggplot(med, aes(x=Initial_days, y=TotalCharge)) +
  geom_point(alpha=0.5) +
  ggtitle("TotalCharge vs Initial_days") + 
  xlab("Initial_days") +
  ylab("TotalCharge")
TotalCharge_Days_plot

