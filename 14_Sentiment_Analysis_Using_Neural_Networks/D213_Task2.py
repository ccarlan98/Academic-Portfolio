#!/usr/bin/env python
# coding: utf-8

# In[1]:


# Packages
import pandas as pd
import random
import numpy as np
import matplotlib.pyplot as plt
from collections import Counter
import seaborn as sns
import re
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Embedding, LSTM, Dense, Dropout
from tensorflow.keras.callbacks import EarlyStopping, ModelCheckpoint
from tensorflow.keras.preprocessing.text import Tokenizer
from tensorflow.keras.preprocessing.sequence import pad_sequences
from sklearn.model_selection import train_test_split


# In[2]:


# Set Random Seeds to Ensure the Models are Reproducable 
random.seed(123)
np.random.seed(123)
tf.random.set_seed(123)


# In[3]:


# Load Data
df = pd.read_csv(r'E:\WGU\D213\Task 2\sentiment labelled sentences\amazon_cells_labelled.txt', delimiter='\t', header=None, names=['Reviews', 'Sentiment'])
df.head()


# In[4]:


# Verify Proper Loading. Expected 1000
print(f"Total number of lines: {len(df)}") # Confirmed


# In[5]:


# Exploratory Data Analysis


# In[6]:


# Check for unusual characters 
characters = re.compile("[^\w\s,.!?;:()\'\"-]") # Standard English Characters and punctuations
unusual_chars = df['Reviews'].apply(lambda x: bool(characters.search(x)))
print("Reviews with unusual characters:", unusual_chars.sum()) # 25 unusual characters


# In[7]:


# Remove unusual characters
def clean_text(text):
    return characters.sub("", text)  # Remove all characters not in our defined list
df['Reviews'] = df['Reviews'].apply(clean_text)

# Check again to verify removal
unusual_chars = df['Reviews'].apply(lambda x: bool(characters.search(x)))
print("Reviews with unusual characters:", unusual_chars.sum()) # Confirmed


# In[8]:


# Vocabulary Size
words = Counter(word for review in df['Reviews'] for word in re.findall(r'\b\w+\b', review.lower()))
print("Vocabulary size:", len(words)) # 1867

vocab_size = 1867


# In[9]:


# Set embedding length to 100 
embedding_length = 100  # Standard embedding length 
print(f"Proposed word embedding length: {embedding_length}")


# In[10]:


# Statistical justification for chosen maximum sequence length
review_lengths = df['Reviews'].str.split().map(len)
max_seq_length = int(review_lengths.quantile(0.95))  # Setting max length to the 95th percentile
print("Chosen max sequence length (95th percentile):", max_seq_length) #23

max_seq_length = 23


# In[11]:


# Tokenization and Padding Process


# In[12]:


# Normalize the Text
tokenizer = Tokenizer(num_words=len(words))
tokenizer.fit_on_texts(df['Reviews'])
tk_reviews = tokenizer.texts_to_sequences(df['Reviews'])


# In[13]:


# Padding
pad_reviews = pad_sequences(tk_reviews, maxlen=max_seq_length, padding='post')
print("Example of a padded sequence:", pad_reviews[0])


# In[14]:


# Define Sentiment Categories and Activation Function


# In[15]:


# Sentiment Categories
num_cats = df['Sentiment'].nunique()
activation_function = 'sigmoid' if num_cats == 2 else 'softmax'
print("Number of sentiment categories:", num_cats)
print("Activation function for the final layer:", activation_function)


# In[16]:


# Splitting data into training, validation, and test sets on a 60-20-20 split
train_data, test_data, train_labels, test_labels = train_test_split(pad_reviews, df['Sentiment'], test_size=0.2, random_state=123)
train_data, val_data, train_labels, val_labels = train_test_split(train_data, train_labels, test_size=0.25, random_state=123) 

print("Training set size:", len(train_data))
print("Validation set size:", len(val_data))
print("Test set size:", len(test_data))


# In[17]:


# Save the datasets
train_df = pd.DataFrame(train_data)
train_df['Sentiment'] = train_labels
val_df = pd.DataFrame(val_data)
val_df['Sentiment'] = val_labels
test_df = pd.DataFrame(test_data)
test_df['Sentiment'] = test_labels

train_df.to_csv(r'E:\WGU\D213\Task 2\training.csv', index=False)
val_df.to_csv(r'E:\WGU\D213\Task 2\validation.csv', index=False)
test_df.to_csv(r'E:\WGU\D213\Task 2\testing.csv', index=False)

amazon_df_clean = pd.DataFrame(train_data, columns=[f"Word_{i+1}" for i in range(train_data.shape[1])])
amazon_df_clean['Sentiment'] = train_labels.reset_index(drop=True)
amazon_df_clean.to_csv(r'E:\WGU\D213\Task 2\amazon_df_clean.csv', index=False)


# In[18]:


# LSTM Modeling


# In[19]:


import warnings
warnings.filterwarnings('ignore', category=UserWarning, message=".*input_length.*")

# Define the model
model = Sequential([
    Embedding(input_dim=vocab_size, output_dim=embedding_length, input_length=max_seq_length),
    LSTM(50, return_sequences=False),
    Dense(50, activation='relu'),
    Dropout(0.5),
    Dense(1, activation='sigmoid')
]) # Best paramaters determined through experimentation determined to be 50 nodes for lstm and dense

# Manually build the model by specifying the input shape
model.build(input_shape=(None, max_seq_length))

model.compile(optimizer='adam',
              loss='binary_crossentropy',
              metrics=['accuracy'])

model.summary()


# In[20]:


# Criteria for Early stopping 
callbacks = [
    EarlyStopping(monitor='val_loss', patience=3, verbose=1, restore_best_weights=True),
    ModelCheckpoint('SentimentAnalysisModelD213.keras', save_best_only=True)
] # Stops the model if does not improve after 3 epochs and saves the best model


# In[21]:


# Training the model
history = model.fit(train_data, train_labels,
                    epochs=20,
                    validation_data=(val_data, val_labels),
                    callbacks=callbacks) 
# Stopped the model after 9 epochs with the determination that epoch 6 is the best model


# In[22]:


# Plots the Loss over Training Epochs 
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.plot(history.history['loss'], label='Training Loss')
plt.plot(history.history['val_loss'], label='Validation Loss')
plt.title('Loss Over Epochs')
plt.legend()
plt.savefig('Loss.jpg')
plt.show()


# In[23]:


# Plots the Accuracy over Training Epochs
plt.subplot(1, 2, 2)
plt.plot(history.history['accuracy'], label='Training Accuracy')
plt.plot(history.history['val_accuracy'], label='Validation Accuracy')
plt.title('Accuracy Over Epochs')
plt.legend()
plt.savefig('Accuracy.jpg')
plt.show()


# In[24]:


# Evaluate the Model Accuracy
test_loss, test_accuracy = model.evaluate(test_data, test_labels)
print(f'Test Accuracy: {test_accuracy}')

