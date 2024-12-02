#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Import Packages
import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.stattools import adfuller


# In[2]:


# Load data
df = pd.read_csv(r"E:\WGU\D213\Task 1\medical_time_series .csv")


# In[3]:


# Line graph visualization
plt.figure(figsize=(10, 6))
plt.plot(df['Day'], df['Revenue'], marker='', color='blue', linewidth=2)
plt.title('Time Series of Daily Revenue')
plt.xlabel('Day')
plt.ylabel('Revenue')
plt.grid(True)
plt.savefig('Line_Graph.jpg')
plt.show()


# In[4]:


# Convert 'Day' into numeric
df['Day'] = pd.to_numeric(df['Day'])


# In[5]:


# Check for gaps in the sequence and describe the length of the sequence
expected = range(df['Day'].min(), df['Day'].max() + 1)
missing_days = set(expected).difference(df['Day'])
length_of_sequence = f"The time series spans {len(df['Day'])} days and includes {len(missing_days)} missing days."
print(length_of_sequence) # No Missing Days


# In[6]:


# Check for NAs
na_count = df['Revenue'].isna().sum()
print(f'Number of missing values in the Revenue column: {na_count}') # No NAs in the Data


# In[7]:


# Write Cleaned Data to CSV
df.to_csv("E:/WGU/D213/Task 1/medical_time_series_cleaned.csv", index=False)


# In[8]:


# Evaluate stationarity
result = adfuller(df['Revenue'], autolag='AIC', regression='c')
print(f"ADF Statistic: {result[0]}")
print(f"p-value: {result[1]}") # The data is not stationary


# In[9]:


# Convert data to stationarity using differencing
df['Revenue_diff'] = df['Revenue'].diff().fillna(0)


# In[10]:


# Remove revenue column to keep differenced version
df = df.drop(columns=['Revenue'])


# In[11]:


# Rewrite df to include the version without any NAs
df = df.dropna(subset=['Revenue_diff'])


# In[12]:


# Reevaluate with ADF test
result_diff = adfuller(df['Revenue_diff'], autolag='AIC', regression='c')
print(f"Differenced ADF Statistic: {result_diff[0]}")
print(f"Differenced p-value: {result_diff[1]}") # Data is now stationary


# In[13]:


# Write differenced data to csv files
df.to_csv("E:/WGU/D213/Task 1/medical_time_series_differenced.csv", index=False)

