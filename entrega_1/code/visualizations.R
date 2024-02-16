
library(ggplot2)
library(dplyr)
library(ggridges) # multiple density plots in a staggered fashion

drugs <- read.csv("../data/drug_consumption_clean_r.csv", check.names = FALSE)


# impulsividad y el alcohol.
impulsive_alcohol <- drugs %>% 
  select(impulsive, alcohol, age)

consumo <- c("Never",
             "Over a Decade Ago",
             "Last Decade",
             "Last Year",
             "Last Month",
             "Last Week",
             "Last Day")

ggplot(impulsive_alcohol[impulsive_alcohol$age  == "18-24",], 
       aes(x = impulsive, y = as.factor(alcohol), fill = as.factor(alcohol))) + 
  geom_density_ridges(alpha = 0.5) +
  labs(title ="Distribución de la impulsividad por nivel de consumo de alcohol",
       x ="Impulsividad", y = "Nivel de consumo") +
  theme_minimal() +
  theme(legend.position = "none") +
  scale_y_discrete(labels = consumo)
