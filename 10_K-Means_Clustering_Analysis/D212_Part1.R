rm(list=ls())
# K Means in R 

# Import Packages
library(factoextra)
library(cluster)

# Import Data
df <- read.csv("E:/WGU/D212/Task1/churn_clean.csv")

# Remove Unwanted Variables
df <- subset(df, select = c(Income, Outage_sec_perweek, Tenure, Bandwidth_GB_Year))

# Check for Missing Data
colSums(is.na(df))
# There is no missing data 

# Check for Outliers Using Boxplots
boxplot(df) # Outliers Present for Income and Outage
# Will keep income outliers because it is expected people have varying degrees of income which can be registered as outliers

# Remove outliers for Outage_sec_perweek
outliers <- boxplot(df$Outage_sec_perweek, plot = FALSE)$out
df <- df[-which(df$Outage_sec_perweek %in% outliers),]
boxplot(df$Outage_sec_perweek)

# Scale the Data
df_scaled <- scale(df)

# Write Cleaned Data into CSV File
write.csv(df_scaled, file = "E:/WGU/D212/Task1/churn_clean_scaled.csv", row.names = FALSE)

# Find the Number of Clusters (k)
fviz_nbclust(df_scaled, kmeans, method = "silhouette")

# Set Seed
set.seed(1)

# Perform K Means Clustering at K = 2
km <- kmeans(df_scaled, centers = 2, nstart = 25)
km

# Plot the Model
fviz_cluster(km, data = df_scaled)

# Find the Mean for Each Cluster
aggregate(df, by=list(cluster = km$cluster), mean)

