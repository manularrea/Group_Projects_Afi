

# 1. Limpiando y ennumerando las características de dataset

getwd()

data <- read.csv("drug_consumption.data", header = FALSE, col.names = c("id", "age", "gender", 
                                                                             "education", "country", "ethnicity",
                                                                             "nscore", "escore", "oscore",
                                                                             "ascore", "cscore", "impulsive",
                                                                             "imp_ss", "alcohol", "amphet",
                                                                             "amy", "benzos", "caff",
                                                                             "cannabis", "choc", "coke",
                                                                             "crack", "ecstasy", "heroin", "ketamine",
                                                                             "legalh", "lsd", "meth", "mushrooms",
                                                                             "nicotine", "semer", "vsa"))


# Dimensión y estrutura
dim(data)
str(data)

# Comprobación de datos duplicados
sum(duplicated(data))
colSums(is.na(data))


## Data cleaning

### Edades

data$age <- ifelse(data$age == -0.95197, "18-24",
                        ifelse(data$age == -0.07854, "25-34",
                               ifelse(data$age == 0.49788, "35-44",
                                      ifelse(data$age == 1.09449, "45-54",
                                             ifelse(data$age == 1.82213, "55-64", "65+"))))) 

                   


table(data$age)

library(dplyr)


# Esto de semer es una droga inventada que no existe.
# Por otro lado la cafeina y el chocolate no es considerado como una droga.

# Excluyo estas columnas de mi dataset usando select de dplyr.

data <- select(data,-c("semer", "caff", "choc"))

dim(data)

#Cambio las etiquetas por un numero, ya que es una forma más fácil de valorar estas variables.

# creo una función
transform_data <- function(drug_data) {
  result <- ifelse(drug_data == 'CL0', 0,
                   ifelse(drug_data == 'CL1', 1,
                          ifelse(drug_data == 'CL2', 2,
                                 ifelse(drug_data == 'CL3', 3,
                                        ifelse(drug_data == 'CL4', 4,
                                               ifelse(drug_data == 'CL5', 5,
                                                      ifelse(drug_data == 'CL6', 6, 0)))))))
  return(result)
}

# Selecciono las columnas a transformar
cols_to_transform <- colnames(data)[14:ncol(data)]

# Uso un lapply para aplicar por fila. 
data[cols_to_transform] <- lapply(data[cols_to_transform], transform_data)


# ranting drugs
# CL0 --> Never Used
# CL1 --> Used over a Decade Ago
# CL2 --> Used in Last Decade
# CL3  Used in Last Year
# CL4 --> Used in Last Month
# CL5 --> Used in Last Week
# CL6 --> Used in Last Day




# Cambio los generos por hombre y mujer
data$gender <- ifelse(data$gender == 0.48246, "Female", "Male")

# categorizo la educación de forma correcta.
# He decidido categorizar los que hayan dejado la escuela antes de los 18 todos juntos. 
data$education <- ifelse(data$education == -2.43591, "Left school at 18 years",
                         ifelse(data$education == -1.73790, "Left school at 18 years",
                                ifelse(data$education == -1.43719, "Left school at 18 years",
                                       ifelse(data$education ==  -1.2275, "Left school at 18 years",
                                              ifelse(data$education == -0.61113, "Some college or university, no certificate or degree",
                                                     ifelse(data$education == -0.05921, "Professional certificate/ diploma",
                                                            ifelse(data$education == 0.45468, "University degree ",
                                                                   ifelse(data$education == 1.16365, "Masters degree", "Doctorate degree"))))))))



# Transformo las columnas de país y etnía

data <- data %>%
  mutate(country = case_when(
    country == -0.09765 ~ "Australia",
    country == 0.24923 ~ "Canada",
    country == -0.46841 ~ "New Zealand",
    country == -0.28519 ~ "Other",
    country == 0.21128 ~ "Republic of Ireland",
    country == 0.96082 ~ "UK",
    country == -0.57009 ~ "USA")
  )


data <- data %>%
  mutate(ethnicity = case_when(
    ethnicity == -0.50212 ~ "Asian",
    ethnicity == -1.10702 ~ "Black",
    ethnicity == 1.90725 ~ "Mixed-Black/Asian",
    ethnicity == 0.12600 ~ "Mixed-White/Asian",
    ethnicity == -0.22166 ~ "Mixed-White/Black",
    ethnicity == 0.11440 ~ "Other",
    ethnicity == -0.31685 ~ "White"
  ))

# Creo varios grupos según el tipo de droga para evaluar el consumo

data <- data %>% 
  mutate(recreational_drug = cannabis + lsd + ecstasy + mushrooms,
         stimulant_drugs = amphet + coke + nicotine + meth,
         sedative_drugs = benzos + heroin + ketamine + legalh,
         highrisk_drugs = amy + crack + vsa)



# Exploratorio de información. Cómo se distribuye mi información, si hace falta hacer algún cambio
# En el set de datos, sobretodo si hace falta prescindir de algún grupo (en edad y etnía principalmente.)

# exploratorio de edad + drugs. Seria interesante tener en cuenta el porcentaje del total de la muestra que tenemos
# Ya que podemos hacerno una idea sobre el total de la muestra. 
table(data$age)
prop.table(table(data$age)) *100 # Porcentaje de personas por edad en el data set.
# Aqui podemos observar que las personas mayores de 55 no es que consuman drogas estimulates.
# Esta drogas es mas consumida por personas menores de 44 años.

age_recreational_drug <- table(x = data$age, y =data$recreational_drug)
age_recreational_drug
prop.table(age_recreational_drug, margin = 1) * 100  # el 1 es para calcular porcentajes por fila

# Pasa igual que antes, las personas mayores no suelen consumir este tipo de sustancias. 
# Lo que si podemos ver es que hay mas personas entre los 45-54 que consumen más de este tipo de sustancias.
# que las anteriores. Esto es para explorarlo en un grafico.
table(x = data$age, y =data$stimulant_drugs)

# Esta droga es más común en personas menores de 34 años. 
table(x = data$age, y =data$sedative_drugs)

# Los que mas consumen son los jovenes. Esto es porque en nuestro data set la mayoria son jovenes.
table(x = data$age, y =data$highrisk_drugs)

# gran parte de los que toman son menores de 44 años. 
table(x = data$age, y =data$alcohol)


# edad + educación
table(x = data$age, y =data$education)

# observo la distribución de los datos por edad en la educación. 
# La mayoria de nuestros datos es de personas que no tienen un grado universitario. Dis. por edad.
prop.table(table(x = data$age, y =data$education), margin =1 ) * 100 

# Aqui observo por educación cual es la distribución. Distribución por caracteristica.
prop.table(table(x = data$age, y =data$education), margin = 2) * 100 


# educación + drugs

# Todos consumen alcohol.
prop.table(table(x = data$alcohol, y =data$education), margin = 2) * 100

# aqui se puede observar que los que no tienen un grado universitario, solo no consumen un 7% del total.
prop.table(table(x = data$stimulant_drugs, y =data$education), margin = 2) * 100

# ethnicity + edad.

table(data$ethnicity)

# la mayor parte de nuestros datos son personas blancas, y los demás tienen poca representación.
# Por ejemplo, todas las personas mayores de 65 son blancos.
prop.table(table(x = data$ethnicity, y =data$age), margin= 2) * 100

# La mayoría de los blancos son personas de los jovenes son blancos.
prop.table(table(x = data$ethnicity, y =data$age), 2) * 100


# Genero + drogas

# son los mismos hombres que mujeres.
table(data$gender)

table(data$gender, data$ethnicity)

table(data$gender, data$education)

# el 35% de los hombres no tienen titulo universitario. 
# A diferencia de las mujeres que, el 31% si tiene titulo
prop.table(table(data$gender, data$education), 1) * 100

# la mayoria de las personas que obtienen un master son mujeres.
prop.table(table(data$gender, data$education), 2) * 100


# la conclusión que saco es que la mayoria de las personas que estan en este set de datos
# son personas sin titulos universitarios y universitarios, quizas porque eran los que tenian más 
# tiempo para hacer esto ( me refiero a dar sus datos para esto). Unido a esto, que acompaña esta idea,
# es que la mayoria son personas menores de 34 años. 

# Para hacer los graficos con esto es suficiente, pienso que lo mejor es hacer algunos de barra y
# graficos de densidad que muestren como se distribuyen estos según la personalidad de uno y otro.

# Otra cosa a evaluar es si una droga no se super pone con otra, es decir, si es redundante, evaluar eso,
# es relevante porque al final añade valor al hecho de que quizás puede que estemos evaluando dos veces lo mismo,
# y por lo tanto malagastando recursos. 

write.csv(data, "Consumption_data.csv")


 












