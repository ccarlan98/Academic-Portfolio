# Summary Statistics and Univariate/Bivariate Distributions 

# Import Packages
library(ggplot2)

# Import Cleaned Med Data
med <- read.csv("E:/WGU/D208/Task 2/med_clean.csv")

# Convert All Variables to Factors
med[] <- lapply(med, factor, levels = c("No", "Yes"))

# Display the Summary Stats
summary(med)

# Generate Univariate Statistics for each Variable
ReAdmis_plot <- ggplot(med, aes(x=ReAdmis)) +
  geom_bar() +
  ggtitle("Univariate Distribution of ReAdmis")
ReAdmis_plot # Target Variable

Softdrink_plot <- ggplot(med, aes(x=Soft_drink)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Soft_drink")
Softdrink_plot

HighBlood_plot <- ggplot(med, aes(x=HighBlood)) +
  geom_bar() +
  ggtitle("Univariate Distribution of HighBlood")
HighBlood_plot

Stroke_plot <- ggplot(med, aes(x=Stroke)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Stroke")
Stroke_plot

Overweight_plot <- ggplot(med, aes(x=Overweight)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Overweight")
Overweight_plot

Arthritis_plot <- ggplot(med, aes(x=Arthritis)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Arthritis")
Arthritis_plot

Diabetes_plot <- ggplot(med, aes(x=Diabetes)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Diabetes")
Diabetes_plot

Hyperlipidemia_plot <- ggplot(med, aes(x=Hyperlipidemia)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Hyperlipidemia")
Hyperlipidemia_plot

BackPain_plot <- ggplot(med, aes(x=BackPain)) +
  geom_bar() +
  ggtitle("Univariate Distribution of BackPain")
BackPain_plot

Anxiety_plot <- ggplot(med, aes(x=Anxiety)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Anxiety")
Anxiety_plot

AllergicRhinitis_plot <- ggplot(med, aes(x=Allergic_rhinitis)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Allergic_rhinitis")
AllergicRhinitis_plot

Reflux_plot <- ggplot(med, aes(x=Reflux_esophagitis)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Reflux_esophagitis")
Reflux_plot

Asthma_plot <- ggplot(med, aes(x=Asthma)) +
  geom_bar() +
  ggtitle("Univariate Distribution of Asthma")
Asthma_plot

# Generate Bivariate Statistics using the ReAdmis Target Variable
ReAdmis_Softdrink_plot <- ggplot(med, aes(x=ReAdmis, fill = Soft_drink)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Soft_drink")
ReAdmis_Softdrink_plot

ReAdmis_HighBlood_plot <- ggplot(med, aes(x=ReAdmis, fill = HighBlood)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by HighBlood")
ReAdmis_HighBlood_plot

ReAdmis_Stroke_plot <- ggplot(med, aes(x=ReAdmis, fill = Stroke)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Stroke")
ReAdmis_Stroke_plot

ReAdmis_Overweight_plot <- ggplot(med, aes(x=ReAdmis, fill = Overweight)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Overweight")
ReAdmis_Overweight_plot

ReAdmis_Arthritis_plot <- ggplot(med, aes(x=ReAdmis, fill = Arthritis)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Arthritis")
ReAdmis_Arthritis_plot

ReAdmis_Diabetes_plot <- ggplot(med, aes(x=ReAdmis, fill = Diabetes)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Diabetes")
ReAdmis_Diabetes_plot

ReAdmis_Hyperlipidemia_plot <- ggplot(med, aes(x=ReAdmis, fill = Hyperlipidemia)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Hyperlipidemia")
ReAdmis_Hyperlipidemia_plot

ReAdmis_BackPain_plot <- ggplot(med, aes(x=ReAdmis, fill = BackPain)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by BackPain")
ReAdmis_BackPain_plot

ReAdmis_Anxiety_plot <- ggplot(med, aes(x=ReAdmis, fill = Anxiety)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Anxiety")
ReAdmis_Anxiety_plot

ReAdmis_Allergic_plot <- ggplot(med, aes(x=ReAdmis, fill = Allergic_rhinitis)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Allergic_rhinitis")
ReAdmis_Allergic_plot

ReAdmis_Reflux_plot <- ggplot(med, aes(x=ReAdmis, fill = Reflux_esophagitis)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Reflux_esophagitis")
ReAdmis_Reflux_plot

ReAdmis_Asthma_plot <- ggplot(med, aes(x=ReAdmis, fill = Asthma)) +
  geom_bar(position = "dodge") + 
  ggtitle("Distribution of ReAdmis by Asthma")
ReAdmis_Asthma_plot

