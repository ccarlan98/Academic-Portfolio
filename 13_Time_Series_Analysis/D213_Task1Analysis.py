#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Import Packages
import pandas as pd
import matplotlib.pyplot as plt
from statsmodels.tsa.seasonal import seasonal_decompose
from statsmodels.graphics.tsaplots import plot_acf
from statsmodels.tsa.stattools import adfuller
from statsmodels.tsa.stattools import acf
import numpy as np
from pmdarima import auto_arima
import warnings
from statsmodels.tsa.statespace.sarimax import SARIMAX
from statsmodels.tsa.arima.model import ARIMA
from scipy.signal import periodogram
from sklearn.metrics import mean_squared_error
from math import sqrt


# In[2]:


# Load original and stationary data
df = pd.read_csv(r"E:\WGU\D213\Task 1\medical_time_series_cleaned.csv")
df_diff = pd.read_csv("E:/WGU/D213/Task 1/medical_time_series_differenced.csv")


# In[3]:


# Convert differenced data to time series object for decomposition
df_ts = pd.Series(df_diff['Revenue_diff'].values, index=pd.date_range(start='2020-01-01', periods=len(df_diff), freq='D'))


# In[4]:


# Decompose the time series
decomposition = seasonal_decompose(df_ts, model='additive', period=365)
fig = decomposition.plot()
plt.savefig('decomp.jpg')
plt.show()


# In[5]:


# Seasonality
plt.figure(figsize=(10, 6))
plt.plot(decomposition.seasonal)
plt.title('Seasonal Component')
plt.savefig('seasonal.jpg')
plt.show()


# In[6]:


# Trends
plt.figure(figsize=(10, 6))
plt.plot(decomposition.trend)
plt.title('Trend Component')
plt.savefig('trend.jpg')
plt.show()


# In[7]:


# ACF
plot_acf(df_ts)
plt.title("Autocorrelation Function")
plt.savefig('decomp_acf.jpg')
plt.show()


# In[8]:


# Spectral Density
f, Pxx = periodogram(df_ts, scaling='spectrum')
plt.figure(figsize=(10, 6))
plt.plot(f, Pxx)
plt.title('Spectral Density')
plt.xlabel('Frequency')
plt.ylabel('Spectral Power')
plt.savefig('spectral.jpg')
plt.show()


# In[9]:


# Residuals
plt.figure(figsize=(10, 6))
plt.plot(decomposition.resid)
plt.title('Residual Component')
plt.savefig('residual.jpg')
plt.show()


# In[10]:


# ACF of Residuals
plot_acf(decomposition.resid.dropna())
plt.title("ACF of Residuals")
plt.savefig('acf_resid.jpg')
plt.show()


# In[11]:


# ADF Test of Residuals
result = adfuller(decomposition.resid.dropna(), autolag='AIC')
print(f"ADF Statistic: {result[0]}")
print(f"p-value: {result[1]}")


# In[12]:


# Convert the data to a date range
df.index = pd.date_range(start='2020-01-01', periods=len(df), freq='D')


# In[13]:


warnings.filterwarnings("ignore")
stepwise_fit=auto_arima(df['Revenue'],trace=True, suppress_warnings=True)
stepwise_fit.summary()


# In[14]:


# Create training and testing sets using last 30 days for the testing
print(df.shape)
train = df.iloc[:-30]
test = df.iloc[-30:]
print(train.shape, test.shape)

# Write training and testing to CSV files
train.to_csv("E:/WGU/D213/Task 1/training.csv", index=False)
test.to_csv("E:/WGU/D213/Task 1/testing.csv", index=False)


# In[15]:


model = ARIMA(train['Revenue'], order=(1,1,0))
model = model.fit()
model.summary()


# In[16]:


# Make Predictions
start=len(train)
end=len(train)+len(test)-1
pred=model.predict(start=start, end=end, typ='levels')
print(pred)

# Set an index
pred.index = df.index[start:end+1]


# In[17]:


pred.plot(legend=True)
test['Revenue'].plot(legend=True)
plt.savefig('predictions.jpg')


# In[18]:


test['Revenue'].mean()


# In[19]:


rmse = sqrt(mean_squared_error(pred,test['Revenue']))
print(rmse)


# In[20]:


model2=ARIMA(df['Revenue'],order=(1,1,0))
model2=model2.fit()
df.tail()


# In[21]:


index_future_dates = pd.date_range(start='2021-12-31', end='2022-01-30')
print(index_future_dates)
pred=model2.predict(start=len(df), end=len(df)+30, typ='levels').rename('ARIMA Predictions')

pred.index=index_future_dates
print(pred)


# In[22]:


pred.plot(legend=True)
plt.savefig('predictions2.jpg')


# In[ ]:




