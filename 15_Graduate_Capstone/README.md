D214: Graduate Capstone

This project explores the use of Random Forest Regression to predict NFL rushing touchdowns based on various player statistics.

**Research Question:** To what extent do variables such as age, rushing yards, first down runs, and fumbles affect the number of rushing touchdowns scored?

**Methods:** The analysis was conducted using R, involving data cleaning, training/testing splits (80/20), and hyperparameter tuning with cross-validation to optimize the random forest model.

**Key Findings:**
  - The number of first downs was the strongest predictor, followed by rushing yards and rushing attempts.
  - The model achieved an MSE of 1.59 and explained 76.85% of the variance in rushing touchdowns, indicating a good fit.
  
**Limitations:** The model outputs continuous values, which don't align perfectly with the discrete nature of touchdowns, and it is computationally intensive.

**Implications:** Results can help NFL teams optimize offensive strategies, improve player evaluation metrics, and better predict performance outcomes.

Additionally, this project includes a written summary for technical audiences and a PowerPoint presentation for non-technical audiences. 
