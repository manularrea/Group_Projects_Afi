# -*- coding: utf-8 -*-

# Importamos librerías y el script de constantes.
import pandas as pd
import utilities.constants as cte
import plotnine as p9

# Leemos el set de datos.
df = pd.read_csv('../data/drug_consumption.data', sep=',', header=None, names=cte.names)

# Eliminamos la columna id ya que no tiene información relevante.
del df['id']

# Transformamos las columnas para ser capaces de entender el set de datos.
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
    
# Empecemos a sacar insights y gráficos.
#       OBS: me da error al pintar el gráfico del cannabis
for column in cte.drugs_columns:
    grafico_droga =   (
                        p9.ggplot(df, p9.aes(x=column, fill=column))
                        + p9.geom_bar(show_legend=False)
                        + p9.scale_x_discrete(limits=['Never Used',
                                                    'Used over a Decade Ago',
                                                    'Used in Last Decade',
                                                    'Used in Last Year',
                                                    'Used in Last Month',
                                                    'Used in Last Week',
                                                    'Used in Last Day'])
                        + p9.labs(title=f'Consumo de {column}')
                        + p9.theme(axis_text_x=p9.element_text(angle=45, hjust=1))
                        )
    print(grafico_droga)
    
    grafico_droga_edad = (
                p9.ggplot(df, p9.aes(x='age', fill=column))
                + p9.geom_bar(position='fill')
                + p9.scale_x_discrete(limits=['18-24',
                                              '25-34',
                                              '35-44',
                                              '45-54',
                                              '55-64',
                                              '65+'])
                + p9.labs(title=f'Consumo de {column} por edad')
                + p9.scale_fill_discrete(name='Nivel de consumo',
                                          limits=['Never Used',
                                                  'Used over a Decade Ago',
                                                  'Used in Last Decade',
                                                  'Used in Last Year',
                                                  'Used in Last Month',
                                                  'Used in Last Week',
                                                  'Used in Last Day'])
                )
    print(grafico_droga_edad)
    
    grafico_droga_ethnicity = (
                p9.ggplot(df, p9.aes(x='ethnicity', fill=column))
                + p9.geom_bar(position='fill')
                + p9.scale_x_discrete(limits=['Asian',
                                              'Black',
                                              'Mixed-Black/Asian',
                                              'Mixed-White/Asian',
                                              'Mixed-White/Black',
                                              'Other',
                                              'White'],
                                      labels=['Asian',
                                              'Black',
                                              'Black/Asian',
                                              'White/Asian',
                                              'White/Black',
                                              'Other',
                                              'White'])
                + p9.labs(title=f'Consumo de {column} por etnia')
                + p9.theme(axis_text_x=p9.element_text(angle=45, hjust=1))
                + p9.scale_fill_discrete(name='Nivel de consumo',
                                          limits=['Never Used',
                                                  'Used over a Decade Ago',
                                                  'Used in Last Decade',
                                                  'Used in Last Year',
                                                  'Used in Last Month',
                                                  'Used in Last Week',
                                                  'Used in Last Day'])
                )
    print(grafico_droga_ethnicity)
    
    grafico_droga_gender = (
                p9.ggplot(df, p9.aes(x=column, fill='gender'))
                + p9.geom_bar(position='dodge')
                + p9.scale_x_discrete(limits=['Never Used',
                                              'Used over a Decade Ago',
                                              'Used in Last Decade',
                                              'Used in Last Year',
                                              'Used in Last Month',
                                              'Used in Last Week',
                                              'Used in Last Day'])
                + p9.labs(title=f'Consumo de {column} por género')
                + p9.theme(axis_text_x=p9.element_text(angle=45, hjust=1))
                + p9.scale_fill_discrete(name='Género',
                                          labels=['Mujer', 'Hombre'])
                )
    print(grafico_droga_gender)
    
    grafico_droga_country = (
                p9.ggplot(df, p9.aes(x='country', fill=column))
                + p9.geom_bar(position='fill')
                + p9.scale_x_discrete(limits=['Australia',
                                              'Canada',
                                              'New Zealand',
                                              'Other',
                                              'Republic of Ireland',
                                              'UK',
                                              'USA'],
                                      labels=['Australia',
                                              'Canada',
                                              'New Zealand',
                                              'Other',
                                              'Rep. Ireland',
                                              'UK',
                                              'USA'])
                + p9.labs(title=f'Consumo de {column} por país')
                + p9.theme(axis_text_x=p9.element_text(angle=45, hjust=1))
                + p9.scale_fill_discrete(name='Nivel de consumo',
                                         limits=['Never Used',
                                                 'Used over a Decade Ago',
                                                 'Used in Last Decade',
                                                 'Used in Last Year',
                                                 'Used in Last Month',
                                                 'Used in Last Week',
                                                 'Used in Last Day'])
                )
    print(grafico_droga_country)


#############



#############

grafico_droga_educacion = (
            p9.ggplot(df, p9.aes(x='education', y=column))
            + p9.geom_count(show_legend=False)
            + p9.scale_x_discrete(limits=['Left school before 16 years',
                                          'Left school at 16 years',
                                          'Left school at 17 years',
                                          'Left school at 18 years',
                                          'Some college or university, no certificate or degree',
                                          'Professional certificate/diploma',
                                          'University degree',
                                          'Masters degree',
                                          'Doctorate degree'])
            + p9.scale_y_discrete(limits=['Never Used',
                                        'Used over a Decade Ago',
                                        'Used in Last Decade',
                                        'Used in Last Year',
                                        'Used in Last Month',
                                        'Used in Last Week',
                                        'Used in Last Day'])
            + p9.labs(title=f'Consumo de {column} por nivel educativo')
            + p9.theme(axis_text_x=p9.element_text(angle=45, hjust=1),
                        axis_text_y=p9.element_text(angle=45, hjust=1))
            )
print(grafico_droga_educacion)