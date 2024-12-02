# Load Packages
library(arules)

# Import Data Set
med_raw <- read.csv("E:/WGU/D212/Task3/medical_market_basket.csv", stringsAsFactors = FALSE)

# Covert to Transactions
medical_transaction <- apply(med_raw, 1, function(row) {
  unlist(strsplit(row[!is.na(row) & row != ""], " "))
})
transactions <- as(medical_transaction, "transactions")

# Convert to Matrix in order to write transactions into a csv file 
transactions_matrix <- as(transactions, "matrix")
transactions.df <- as.data.frame(transactions_matrix)
write.csv(transactions.df, "E:/WGU/D212/Task3/medical_transactions.csv", row.names = FALSE)

# Use Apriori Algorithm to create Rules
rules <- apriori(transactions, parameter = list(support = 0.1, confidence = 0.8))

# Sort by Lift to find the top 3 relevant rules
rules_sorted <- sort(rules, by="lift")
inspect(rules_sorted[1:3])
