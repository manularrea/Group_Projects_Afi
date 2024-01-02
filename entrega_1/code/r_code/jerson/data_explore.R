

getwd()

drugs <- read.csv('Consumption_data.csv', check.names = FALSE)
drugs <- drugs[, -1]
summary(drugs)

# 
# 1. Alcohol Usage Distribution by Age and Gender
# 
# Explore the distribution of alcohol usage across different
# age groups and genders to identify any significant patterns or differences.

library(dplyr)
alcoholics <- drugs %>%
  select(age, gender, alcohol) %>%
  group_by(age, gender) %>%
  summarise(n_alcoholics = n(), .groups = 'drop')

alcoholics$gender <- factor(alcoholics$gender, levels = c("Male", "Female"))


# Los hombres empiezan a beber antes pero lo van dejando según se haccen mayor.
# Las mujeres en cambio empiezan más tarde que los hombres. 

library(ggplot2)  
ggplot(alcoholics, aes(age, n_alcoholics, fill = gender)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(values = c("Male" = "darkkhaki", "Female" = "cadetblue"),
                    guide = guide_legend(title = "Gender")) +
  labs(title = "Number of Alcoholics by Age and Gender",
       x = "Age Group",
       y = "Number of alcohol consumers") +
  theme_minimal() 


# hay mucha gente sin un certificado, la mayoria de nuestro dataset se encuentra ahí.
# Y son de os mas jovenes de nuestro dataset. (Habria que ordenarlo por grupos, lo intento, pero no me sale.)

education_by_age <- drugs %>%
  select(age, education) %>%
  group_by(age, education) %>%
  summarise(cantidad_x = n(), .groups = 'drop') %>%
  group_by(age) %>%
  arrange(age, -cantidad_x) %>%
  mutate(education = factor(education, levels = unique(education)))

ggplot(education_by_age, aes(age, cantidad_x, fill = education)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_discrete(guide = guide_legend(title = "Education Level"))

# Usando facet_wrap. Se aprecia mejor las descompesación. 
# La mayoria de las personas sin estudios universitarios bebe mas que la mayoria,
# y son hombres
ggplot(education_by_age, aes(age, cantidad_x, fill = education)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~education) +
  scale_fill_discrete(guide = guide_legend(title = "Education Level"))


###  Edad + drogas
# Aqui podemos observar que las personas mayores de 55 no es que consuman drogas estimulates.
# Esta drogas es mas consumida por personas menores de 44 años.

age_recreational_drug <- table(x = drugs$age, y =drugs$recreational_drug)
age_recreational_drug
prop.table(age_recreational_drug, margin = 1) * 100 

# hago esto para tener los nombres de las columnas, me gusta mas que ir a buscarlos al dataset.
colnames(drugs[,seq(ncol(drugs) -3, ncol(drugs), 1)])

#### recreational_drug

age_recreational_drug  <- drugs %>%
  group_by(age) %>% 
  summarise(mean_recreational_drug = mean(recreational_drug))

visual_recreational <- ggplot(age_recreational_drug, aes(age, mean_recreational_drug)) +
  geom_col(fill ="cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Recreational Drugs",
       y = "Mean Comsuption", x = "")

visual_recreational

### stimulant_drugs
age_stimulant_drugs  <- drugs %>%
  group_by(age) %>% 
  summarise(mean_stimulant_drugs = mean(stimulant_drugs))

visual_stimulant <- ggplot(age_stimulant_drugs, aes(age, mean_stimulant_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Stimulant Drugs",
       y = "Mean Comsuption", x = "")

visual_stimulant

### sedative_drugs
age_sedative_drugs  <- drugs %>%
  group_by(age) %>% 
  summarise(mean_sedative_drugs = mean(sedative_drugs))

visual_sedative <- ggplot(age_sedative_drugs, aes(age, mean_sedative_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Sedative Drugs",
       y = "Mean Comsuption", x = "")

visual_sedative

### highrisk_drugs
age_highrisk_drugs  <- drugs %>%
  group_by(age) %>% 
  summarise(mean_highrisk_drugs = mean(highrisk_drugs))

visual_highrisk <- ggplot(age_highrisk_drugs, aes(age, mean_highrisk_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of highrisk Drugs",
       y = "Mean Comsuption", x = "")

visual_highrisk



# gridExtra es una libreria que te permite organizar y unir graficos en una sola 
# diapositiva. 
library(gridExtra)

# Para verlo es mejor hacerlo grande, igualmente es una idea.
# aqui podemos observar como lo que mas consumen son los más jovenes,
# podemos observar tambien que las drogas recreacionales como la marihuana es 
# mas consumida por jovenes, mientras que las demás, se ve menos diferencia entre tipo
# de sustancias.

grid.arrange(visual_recreational, visual_stimulant, visual_sedative, visual_highrisk,
             ncol = 4, top = "Drugs use by Age")

# aparte se observa que hay muy pocas observaciones de personas de mas de 65 años
# como ya vimos antes, esto todos son blancos y hombres, por lo que debemos evaluar si 
# es inteligente meter este grupo dentro de los de 55-64. Usando un test, o alguna hipotesis matematica.


#### Gender + drugs


gender_recreational_drug <- table(x = drugs$gender, y =drugs$recreational_drug)
gender_recreational_drug
prop.table(gender_recreational_drug, margin = 1) * 100 

#### recreational_drug

gender_recreational_drug  <- drugs %>%
  group_by(gender) %>% 
  summarise(mean_recreational_drug = mean(recreational_drug))

visual_gender_recreational <- ggplot(gender_recreational_drug, aes(gender, mean_recreational_drug)) +
  geom_col(fill ="cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Recreational Drugs",
       y = "Mean Comsuption", x = "") +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

visual_gender_recreational

### stimulant_drugs
gender_stimulant_drugs  <- drugs %>%
  group_by(gender) %>% 
  summarise(mean_stimulant_drugs = mean(stimulant_drugs))

visual_gender_stimulant <- ggplot(gender_stimulant_drugs, aes(gender, mean_stimulant_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Stimulant Drugs",
       y = "", x = "") +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

visual_gender_stimulant

### sedative_drugs
gender_sedative_drugs  <- drugs %>%
  group_by(gender) %>% 
  summarise(mean_sedative_drugs = mean(sedative_drugs))

visual_gender_sedative <- ggplot(gender_sedative_drugs, aes(gender, mean_sedative_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Sedative Drugs",
       y = "", x = "") +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

visual_gender_sedative

### highrisk_drugs
gender_highrisk_drugs  <- drugs %>%
  group_by(gender) %>% 
  summarise(mean_highrisk_drugs = mean(highrisk_drugs))

visual_gender_highrisk <- ggplot(gender_highrisk_drugs, aes(gender, mean_highrisk_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of highrisk Drugs",
       y = "", x = "") +
  theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())

visual_gender_highrisk

grid.arrange(visual_gender_recreational, visual_gender_stimulant, visual_gender_sedative, visual_gender_highrisk,
             ncol = 4, top = "Drugs use by Gender")

# el hombre en todos los casos consume mas sustancias consideradas drogas que la mujer. 

### lo que es el cannabis y el alcohol son drogas que pienso que deberiamos valorar por separado
### debido a lo popular que son.


#### education + drugs

education_recreational_drug <- table(x = drugs$education, y =drugs$recreational_drug)
education_recreational_drug
prop.table(education_recreational_drug, margin = 1) * 100 

#### recreational_drug
drugs$education <- factor(drugs$education, labels = unique(drugs$education) )

# unique(drugs$education) seria una buena practica convertirlos a numero, 
# porque asi me aparecerian ordenados, ya que cuando agrupo, ordeno y pinto el grafico
# no me aparece como quiero. Si lo tengo en numeros seria sencillo, despues de tenerloa si,
# puedo cambiar con ggplot los numeros por una etiqueta.

# [1] "Professional certificate/ diploma"   "Doctorate degree"                                    
# [3] "Masters degree"                      "Left school at 18 years"                             
# [5] "University degree "                 "Some college or university, no certificate or degree"

education_recreational_drug  <- drugs %>%
  group_by(education) %>% 
  summarise(mean_recreational_drug = mean(recreational_drug))

visual_education_recreational <- ggplot(education_recreational_drug, aes(education, mean_recreational_drug)) +
  geom_col(fill ="cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Recreational Drugs",
       y = "", x = "") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  coord_flip()

visual_education_recreational

### stimulant_drugs
education_stimulant_drugs  <- drugs %>%
  group_by(education) %>% 
  summarise(mean_stimulant_drugs = mean(stimulant_drugs))

visual_education_stimulant <- ggplot(education_stimulant_drugs, aes(education, mean_stimulant_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Stimulant Drugs",
       y = "", x = "") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  coord_flip()

visual_education_stimulant

### sedative_drugs
education_sedative_drugs  <- drugs %>%
  group_by(education) %>% 
  summarise(mean_sedative_drugs = mean(sedative_drugs))

visual_education_sedative <- ggplot(education_sedative_drugs, aes(education, mean_sedative_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of Sedative Drugs",
       y = "", x = "") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  coord_flip()

visual_education_sedative

### highrisk_drugs
education_highrisk_drugs  <- drugs %>%
  group_by(education) %>% 
  summarise(mean_highrisk_drugs = mean(highrisk_drugs))

visual_education_highrisk <- ggplot(education_highrisk_drugs, aes(education, mean_highrisk_drugs)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average Use of highrisk Drugs",
       y = "", x = "") +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) +
  coord_flip()

visual_education_highrisk

grid.arrange(visual_education_recreational, visual_education_stimulant,
             visual_education_sedative, visual_education_highrisk,
             nrow = 4, top = "Drugs use by education")

### education+ alcohol

### highrisk_drugs
education_alcohol  <- drugs %>%
  group_by(education) %>% 
  summarise(mean_alcohol = mean(alcohol))

visual_education_alcohol <- ggplot(education_alcohol, aes(education, mean_alcohol)) +
  geom_col(fill = "cadetblue") +
  theme_minimal() +
  labs(title = "Average consume of alcohol",
       y = "Frecuency of alcohol comsuption", x = "Education level")

visual_education_alcohol
# todos consumen mas o menos alcohol por igual. 


### podemos crear una grafico de barras que nos diga de media que droga se consume mas.

### Densidad

# geom_density_ridges()  https://cran.r-project.org/web/packages/ggridges/vignettes/introduction.html


# impulsividad y el alcohol.
impulsive_alcohol <- data %>% 
  select(impulsive, alcohol)

ggplot(impulsive_alcohol, aes(x = impulsive, y = as.factor(alcohol), fill = as.factor(alcohol))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de la impulsividad por nivel de consumo de alcohol",
       x ="Impulsividad", y = "Nivel de consumo del alcohol")


# sensación de ser visto y el alcohol.
ss_alcohol <- data %>% 
  select(imp_ss, alcohol)

ggplot(ss_alcohol, aes(x = imp_ss, y = as.factor(alcohol), fill = as.factor(alcohol))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de la sensación de ser visto por nivel de consumo de alcohol",
       x ="Sensación de ser visto", y = "Nivel de consumo del alcohol")


# sociabilidad y el alcohol.
escore_alcohol <- data %>% 
  select(escore, alcohol)

ggplot(escore_alcohol, aes(x = escore, y = as.factor(alcohol), fill = as.factor(alcohol))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de ser sociable por nivel de consumo de alcohol",
       x ="Sociabilidad", y = "Nivel de consumo del alcohol")


# apatia y el alcohol.
nscore_alcohol <- data %>% 
  select(nscore, alcohol)

ggplot(nscore_alcohol, aes(x = nscore, y = as.factor(alcohol), fill = as.factor(alcohol))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de pensamientos negativos por nivel de consumo de alcohol",
       x ="Negatividad", y = "Nivel de consumo del alcohol")



# creatividad y el alcohol.
cscore_alcohol <- data %>% 
  select(cscore, alcohol)

ggplot(cscore_alcohol, aes(x = cscore, y = as.factor(alcohol), fill = as.factor(alcohol))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de la creatividad por nivel de consumo de alcohol",
       x ="Creatividad", y = "Nivel de consumo del alcohol")

# negatividad y benzos.
nscore_benzos <- data %>% 
  select(nscore, benzos)

ggplot(nscore_benzos, aes(x = nscore, y = as.factor(benzos), fill = as.factor(benzos))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de la negatividad por nivel de consumo de benzos",
       x ="Negatividad", y = "Nivel de consumo del benzos")


# Sensación de ser visto con el canabis.
ss_cannabis <- data %>% 
  select(imp_ss, cannabis)

ggplot(ss_cannabis, aes(x = imp_ss, y = as.factor(cannabis), fill = as.factor(cannabis))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de la sensación de ser visto por nivel de consumo de cannabis",
       x ="Sensación de ser visto", y = "Nivel de consumo de cannabis")

#agrupo por los que no consumen y los puntos medios, y se observa que la sensación de ser visto
# aumenta segun mas es el consumo de drogas.

ss_highrisk <- data %>% 
  select(imp_ss, highrisk_drugs) %>%
  mutate(group_highrisk = case_when(
    highrisk_drugs == 0 ~ 0,
    highrisk_drugs < 3 ~ 1,
    highrisk_drugs < 6 ~ 2,
    highrisk_drugs < 9 ~ 3,
    TRUE ~ 4
  ))

ggplot(ss_highrisk, aes(x = imp_ss, y = as.factor(group_highrisk), fill = as.factor(group_highrisk))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de la sensación de ser visto por nivel de consumo de drogas fuertes",
       x ="Sensación de ser visto", y = "Nivel de consumo de drogas fuertes")



escore_recreational <- data %>% 
  select(escore, recreational_drug) %>%
  mutate(group_recreational = case_when(
    recreational_drug == 0 ~ 0,
    recreational_drug < 3 ~ 1,
    recreational_drug < 6 ~ 2,
    recreational_drug < 9 ~ 3,
    TRUE ~ 4
  ))

ggplot(escore_recreational, aes(x = escore, y = as.factor(group_recreational), fill = as.factor(group_recreational))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de sociabilidad por nivel de consumo de drogas recreativas",
       x ="Nivel de sociabilidad", y = "Nivel de drogas recreativas")


cscore_recreational <- data %>% 
  select(cscore, recreational_drug) %>%
  mutate(group_recreational = case_when(
    recreational_drug == 0 ~ 0,
    recreational_drug < 3 ~ 1,
    recreational_drug < 6 ~ 2,
    recreational_drug < 9 ~ 3,
    TRUE ~ 4
  ))

ggplot(cscore_recreational, aes(x = cscore, y = as.factor(group_recreational), fill = as.factor(group_recreational))) +
  geom_density_ridges(alpha = 0.5) +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(title ="Distribución de sociabilidad por nivel de consumo de drogas recreativas",
       x ="Nivel de responsabilidad", y = "Nivel de drogas recreativas")



### Es buen planteamiento agrupar por continente ya que hay pocos datos de paises 
### que no sean uk y usa. Aparte de transformarlo para que aparezca en orden descendente. 

nicotine_country <- data %>% 
  select(country, nicotine) %>% 
  group_by(country) %>% 
  arrange(-nicotine) 


ggplot(nicotine_country, aes(country, nicotine, fill = as.factor(country))) +
  geom_col()

#### ideas :https://ggplot2.tidyverse.org/reference/ggtheme.html
#### https://www.tidyverse.org/blog/2020/03/ggplot2-3-3-0/





