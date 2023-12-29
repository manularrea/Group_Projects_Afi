# -*- coding: utf-8 -*-

import pandas as pd
import utilities.constants as cte

df = pd.read_csv('../data/drug_consumption.csv', sep=',', header=None, names=cte.names)

del df['id']

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