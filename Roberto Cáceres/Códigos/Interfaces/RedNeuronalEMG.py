
import tensorflow as tf
import numpy as np
import pandas as pd # procesamiento de data, CSV I/O (pd.read_csv)
from matplotlib import pyplot
import matplotlib.pyplot as plt
from scipy import io
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from tensorflow import keras #Fue necesario importar keras
from keras.optimizers import SGD
from tensorflow.keras import layers

import pandas as pd
import matplotlib.pyplot as plt
import tensorflow as tf
import seaborn as sns



#Pre-Procesing Data
#df = pd.read_csv("DataSegundoEntrenamiento.csv")
df = pd.read_csv("DataPrimerEntrenamiento.csv")
#creamos el componente label encoder de la clase sklearn
le = LabelEncoder()
#Empezamos a dar valores numericos a las etiquetas que necesitamos
df["Clase"]= le.fit_transform(df["Clase"])
#df["transmission"]= le.fit_transform(df["transmission"])
#df["fuelType"]= le.fit_transform(df["fuelType"])

Y = df.iloc[:, -1] #tomas el valor de la columna price ya como etiquetas para y
#Y.head()

X1 = df.iloc[:, :8] #sacas las features ya procesadas dejando fuera del dataframe la columna price
#Reordenamos las columnas para hacer mas facil la extraccion de caracteristicas 
#df = df.reindex(columns=['model','year','transmission','mileage','fuelType','tax','mpg','engineSize','price'])

#Data Normalization
#Normalizamos la data ya que necesitamos tener las features en un mismo rango, para que sea mas facil 
#encontrar los minimos
X1 = X1.iloc[:,0:] 
print(df)
df_norm = (X1 - X1.mean()) / X1.std() 
df_norm.head()
print(df_norm)


# Creando Training and Test Sets

X_arr = df_norm.values
Y_arr = Y.values

print('X_arr shape: ', X_arr.shape) #'shape nos da la dimension 
print('Y_arr shape: ', Y_arr.shape)



X_train, X_test, y_train, y_test = train_test_split(X_arr, Y_arr, test_size = 0.15, shuffle = True, random_state=1) 
#This predefined function splits the dataset to train and test set, where test size is given in 'test_size'(Here 5%) 
#Random state ensures that the splits that you generate are reproducible. Scikit-learn uses random permutations to generate the splits.

print('X_train shape: ', X_train.shape)
print('y_train shape: ', y_train.shape)
print('X_test shape: ', X_test.shape)
print('y_test shape: ', y_test.shape)

# ***************************
# DEFINA EL MODELO AQUÍ
# ***************************


# ***************************
# DEFINA EL MODELO AQUÍ
# ***************************




#history = model.fit(X_train,y_train, epochs = 100, validation_data=(X_test,y_test))
from sklearn.neural_network import MLPClassifier
mlp=MLPClassifier(hidden_layer_sizes=(10,10,10), max_iter=1500, alpha=0.0001,
                     solver='lbfgs',tol=0.000000001)
history = mlp.fit(X_train,y_train)
predictions = mlp.predict(X_test)
from sklearn.metrics import classification_report
print(classification_report(y_test,predictions))

# Se obtienen las predicciones del modelo para el set de validación
yhat = mlp.predict(X_train)
# Se obtiene la matriz de confusión para el set de validación
confusion = tf.math.confusion_matrix(labels = y_train, predictions = yhat)
print(confusion)



