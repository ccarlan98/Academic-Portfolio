# Data Cleaning for D208 Part 2

# Import Med Data
med <- read.csv("E:/WGU/D208/Task 2/medical_clean.csv")

# Remove Unwanted Variables 
med <- subset(med, select = c(ReAdmis, Soft_drink, HighBlood, Stroke, Overweight, Arthritis, Diabetes, Hyperlipidemia, BackPain, Anxiety, Allergic_rhinitis, Reflux_esophagitis, Asthma))

# Check for Missing Data
colSums(is.na(med)) # There is no missing data so nothing to replace

# Convert All Variables to Factors
med[] <- lapply(med, factor, levels = c("No", "Yes"))

# Write cleaned data into csv file
write.csv(med, file = "E:/WGU/D208/Task 2/med_clean.csv", row.names = FALSE)
