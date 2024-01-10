# -*- coding: utf-8 -*-

# Importamos librerías y el script de constantes.
import pandas as pd
import utilities.constants as cte

# Leemos el set de datos.
df = pd.read_csv('../data/drug_consumption.data', sep=',', header=None, names=cte.names)


# Transformamos las columnas para ser capaces de entender el set de datos.
# Utilizamos los valores indicados en la siguiente url:
# https://archive.ics.uci.edu/dataset/373/drug+consumption+quantified

df.age = df.age.apply(lambda row: cte.age_values[row])
df.gender = df.gender.apply(lambda row: cte.gender_values[row])
df.education = df.education.apply(lambda row: cte.education_values[row])
df.country = df.country.apply(lambda row: cte.country_values[row])
df.ethnicity = df.ethnicity.apply(lambda row: cte.ethnicity_values[row])
df.n_score = df.n_score.apply(lambda row: cte.nscore_values[row])
df.e_score = df.e_score.apply(lambda row: cte.escore_values[row])
df.o_score = df.o_score.apply(lambda row: cte.oscore_values[row])
df.a_score = df.a_score.apply(lambda row: cte.ascore_values[row])
df.c_score = df.c_score.apply(lambda row: cte.cscore_values[row])
for column in cte.drugs_columns:
    df[column] = df[column].apply(lambda row: cte.drugs_values[row])
    
    
# Eliminamos la columna id ya que no tiene información relevante.
del df['id']


# Para la columna age seguimos los valores indicados en la url anterior, sin embargo
# agrupamos el grupo de personas con 65+ años al grupo de personas de 55-64 años ya que
# tenemos menos de un 1% de personas con 65+ años y son dos grupos de población parecidos.

df.age = df.age.apply(lambda row: cte.age_values[row])


# Para la columna education seguimos los valores indicados en la url anterior, sin embargo
# agrupamos las personas que abandonaron la escuela antes del los 16, las que la abandonaron
# a los 16, a los 17 y a los 18 como personas sin estudios, y agrupamos las personas con un
# grado universitario/master/doctorado como personas con estudios superiores. Los otros dos
# grupos lo forman estudiantes y personas con un título de formación profesional respectivamente.

df.education = df.education.apply(lambda row: cte.education_values[row])


# Para las columnas de drogas seguimos los valores indicados en la url anterior, sin embargo
# agrupamos CL0, CL1 y CL2 (nunca ha consumido, lleva más de 10 años sin consumir y lleva más
# de un año sin consumir) como 0 (no consumidor) y agrupamos CL3, CL4, CL5 y CL6 (consumió el
# último año, consumió el último mes, consumió la última semana y consumió el último día)
# como 1 (consumidor).

for column in cte.drugs_columns:
    df[column] = df[column].apply(lambda row: cte.drugs_values[row])

    
# Vamos a agrupar en ciertas variables para tener mayor representatividad de los datos.
df_grouped = pd.DataFrame()
df_grouped[['age', 'gender']] = df[['age', 'gender']]
df_grouped['education'] = df['education'].apply(lambda row: cte.education_values_grouped[row])
df_grouped[['country', 'ethnicity', 'n_score', 'e_score', 'o_score', 'a_score', 'c_score', 'impulsive', 'sensation_seeing']] = df[['country', 'ethnicity', 'n_score', 'e_score', 'o_score', 'a_score', 'c_score', 'impulsive', 'sensation_seeing']]
for column in cte.drugs_columns:
    df_grouped[column] = df[column].apply(lambda row: cte.drugs_values_grouped[row])




##############

# OJO DATOS
# Mentirosos: son los que hayan contestado que alguna vez han consumido semer.
mentirosos = df.loc[df.semer != 'Never Used']

# Valores extraños: son las personas con 24 años o menos que hayan consumido alguna droga hace más de 10 años.
valores_extraños = {}
for column in cte.drugs_columns:
    p = df.loc[(df.age == '18-24') & (df[column] == 'Used over a Decade Ago')]
    valores_extraños[column] = p


##############

# Creo un DataFrame que contendrá por columnas cada droga y por filas la impulsividad media de
# los distintos consumidores.

df_impulsive = pd.DataFrame()
for column in cte.drugs_columns:
    series = df_grouped[[column, 'impulsive']].groupby(column).mean()
    df_impulsive[column] = series
    
df_impulsive = df_impulsive.loc[['No consume', 'Consumo anual', 'Consumo frecuente', 'Consumo diario']]

df_grouped['impulsive'].mean()


# Creo un DataFrame que contendrá por columnas cada droga y por filas la sensación de ser visto
# media de los distintos consumidores.

df_sen_seeing = pd.DataFrame()
for column in cte.drugs_columns:
    series = df_grouped[[column, 'sensation_seeing']].groupby(column).mean()
    df_sen_seeing[column] = series
    
df_sen_seeing = df_sen_seeing.loc[['No consume', 'Consumo anual', 'Consumo frecuente', 'Consumo diario']]

df_grouped['sensation_seeing'].mean()


# Creo un DataFrame que contendrá por columnas cada droga y por filas el neuroticismo
# medio de los distintos consumidores.

df_n_score = pd.DataFrame()
for column in cte.drugs_columns:
    series = df_grouped[[column, 'n_score']].groupby(column).mean()
    df_n_score[column] = series
    
df_n_score = df_n_score.loc[['No consume', 'Consumo anual', 'Consumo frecuente', 'Consumo diario']]

df_grouped['n_score'].mean()


# Creo un DataFrame que contendrá por columnas cada droga y por filas la extraversión
# media de los distintos consumidores.

df_e_score = pd.DataFrame()
for column in cte.drugs_columns:
    series = df_grouped[[column, 'e_score']].groupby(column).mean()
    df_e_score[column] = series
    
df_e_score = df_e_score.loc[['No consume', 'Consumo anual', 'Consumo frecuente', 'Consumo diario']]

df_grouped['e_score'].mean()


# Creo un DataFrame que contendrá por columnas cada droga y por filas lo abierto a experiencias
# que están de media los distintos consumidores.

df_o_score = pd.DataFrame()
for column in cte.drugs_columns:
    series = df_grouped[[column, 'o_score']].groupby(column).mean()
    df_o_score[column] = series
    
df_o_score = df_o_score.loc[['No consume', 'Consumo anual', 'Consumo frecuente', 'Consumo diario']]

df_grouped['o_score'].mean()


# Creo un DataFrame que contendrá por columnas cada droga y por filas lo agradable
# que son de media los distintos consumidores.

df_a_score = pd.DataFrame()
for column in cte.drugs_columns:
    series = df_grouped[[column, 'a_score']].groupby(column).mean()
    df_a_score[column] = series
    
df_a_score = df_a_score.loc[['No consume', 'Consumo anual', 'Consumo frecuente', 'Consumo diario']]

df_grouped['a_score'].mean()


# Creo un DataFrame que contendrá por columnas cada droga y por filas lo conscientes
# que son de media los distintos consumidores.

df_c_score = pd.DataFrame()
for column in cte.drugs_columns:
    series = df_grouped[[column, 'c_score']].groupby(column).mean()
    df_c_score[column] = series
    
df_c_score = df_c_score.loc[['No consume', 'Consumo anual', 'Consumo frecuente', 'Consumo diario']]

df_grouped['c_score'].mean()
