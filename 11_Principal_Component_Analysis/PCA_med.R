# Import Packages
library(factoextra)
library(FactoMineR)
library(corrr)
library(ggcorrplot)

# Import Data Set
med <- read.csv("E:/WGU/D212/Task2/medical_clean.csv")

# Select Variables 
med <- subset(med, select = c(Children, Age, Income, VitD_levels, Doc_visits, Full_meals_eaten, vitD_supp, Initial_days, TotalCharge, Additional_charges))

# Check for Null Values
colSums(is.na(med))

# Normalize the Data
med_normalized <- scale(med)

# Write to CSV for assessment submission
write.csv(med_normalized, file = "E:/WGU/D212/Task2/med_normalized.csv", row.names = FALSE)

# Create Loading Matrix 
med_pca <- prcomp(med_normalized)
lds_matrix <- med_pca$rotation
lds_matrix

# Compute the correlation matrix
corr_matrix <- cor(med_normalized)
ggcorrplot(corr_matrix)

# Create the Scree Plot
med_scree <- fviz_eig(med_pca, addlabels = TRUE)
med_scree

