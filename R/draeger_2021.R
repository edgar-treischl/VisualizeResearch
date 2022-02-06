library(tidyverse)


df <- tribble(
  ~school, ~prediction, ~group,
  "Hauptschule",   19.58, "10",
  "Gesamtschule",   8.45, "10",
  "Realschule",   29.79, "10",
  "Gymnasium",   42.16, "10",
  "Hauptschule",   11.79, "90",
  "Gesamtschule",   7.5, "90",
  "Realschule",   30.36, "90",
  "Gymnasium",   50.307, "90"
)

#df <-  as.data.frame(df)


#df$school <- as.factor(df$school)

#df$school <- factor(df$school, 
                    #labels = c("Hauptschule", "Gesamtschule",
                               #"Realschule", "Gymnasium"))



ggplot(data=df, aes(x=fct_reorder(school, prediction), y=prediction, fill = group)) +
  geom_bar(stat="identity", position=position_dodge())+
  theme_minimal(base_size = 12)+
  labs(title = "Vorhergesagt Wahrscheinlichkeit der 5. Klasse (unconditional)",
       fill = "Perzentil",
       caption = "(based on Dräger 2021)") +
  xlab("Schule")+
  ylab("Vorhersage (%)")+
  scale_fill_brewer(palette = "Set1")


df2 <- df %>%
  pivot_wider(names_from = group , 
              values_from = prediction)

df3 <- df2 %>% mutate(
  differences = `90` - `10`
)


ggplot(data=df3, aes(x=fct_reorder(school, differences), y=differences)) +
  geom_bar(stat="identity")+
  theme_minimal(base_size = 12)+
  labs(title = "Differenz der Wahrscheinlichkeit der 5. Klasse (unconditional)",
       caption = "(Dräger 2021: P90 - P10)") +
  xlab("Schule")+
  ylab("Vorhersage (%)")+
  coord_flip()

#guides(fill=FALSE)
#scale_fill_manual(values=c("darkred", "darkgreen", "darkred", "darkgreen"))+
  
  



#2#################

df <- tribble(
  ~school, ~prediction, ~group,
  "Hauptschule",   22.82, "10",
  "Gesamtschule",   7.4, "10",
  "Realschule",   30.5, "10",
  "Gymnasium",   39.17, "10",
  "Hauptschule",   12.91, "90",
  "Gesamtschule",   4.3, "90",
  "Realschule",   33.31, "90",
  "Gymnasium",   49.53, "90"
)



ggplot(data=df, aes(x=fct_reorder(school, prediction), y=prediction, fill = group)) +
  geom_bar(stat="identity", position=position_dodge())+
  theme_minimal(base_size = 12)+
  labs(title = "Vorhergesagt Wahrscheinlichkeit der 9. Klasse (unconditional)",
       fill = "Perzentil",
       caption = "(based on Dräger 2021)") +
  xlab("Schule")+
  ylab("Vorhersage (%)")+
  scale_fill_brewer(palette = "Set1")



df2 <- df %>%
  pivot_wider(names_from = group , 
              values_from = prediction)

df3 <- df2 %>% mutate(
  differences = `90` - `10`
)

ggplot(data=df3, aes(x=fct_reorder(school, differences), y=differences)) +
  geom_bar(stat="identity", position=position_dodge())+
  theme_minimal(base_size = 12)+
  labs(title = "Differenz der Wahrscheinlichkeit der 9. Klasse (unconditional)",
       caption = "(Dräger 2021: P90 - P10)") +
  xlab("Schule")+
  ylab("Vorhersage (%)")+
  scale_fill_brewer(palette = "Set1")+
  coord_flip()




#3#################

df <- tribble(
  ~school, ~prediction, ~group,
  "None",   5.2, "10",
  "QA",   14.35, "10",
  "Mittl. Reife",   28.47, "10",
  "Fachhochschulreife",   8.19, "10",
  "Abitur",   43.69, "10",
  "None",   1.33, "90",
  "QA",   8.13, "90",
  "Mittl. Reife",   27.55, "90",
  "Fachhochschulreife",   9.86, "90",
  "Abitur",   53.12, "90"
)



ggplot(data=df, aes(x=fct_reorder(school, prediction), y=prediction, fill = group)) +
  geom_bar(stat="identity", position=position_dodge())+
  theme_minimal(base_size = 12)+
  labs(title = "Vorhergesagte Wahrscheinlichkeit Abschluss (unconditional)",
       fill = "Percentile",
       caption = "(based on Dräger 2021)") +
  xlab("Schule")+
  ylab("Vorhersage (%)")+
  scale_fill_brewer(palette = "Set1")



df2 <- df %>%
  pivot_wider(names_from = group , 
              values_from = prediction)

df3 <- df2 %>% mutate(
  differences = `90` - `10`
)

ggplot(data=df3, aes(x=fct_reorder(school, differences), y=differences)) +
  geom_bar(stat="identity", position=position_dodge())+
  theme_minimal(base_size = 12)+
  labs(title = "Differenz Wahrscheinlichkeit Abschluss (unconditional)",
       caption = "(Dräger 2021: P90 - P10)") +
  xlab("Abschluss")+
  ylab("Vorhersage (%)")+
  scale_fill_brewer(palette = "Set1")+
  coord_flip()




#4##########################
df <- tribble(
  ~school, ~prediction, ~group,
  "Other",   10.07, "10",
  "Employment",   13.16, "10",
  "Prevocation",   6.07, "10",
  "VET school",   14.79, "10",
  "Dual VET",   35.10, "10",
  "UAS",   4.63, "10",
  "Dual study",   1.8, "10",
  "University",   14.33, "10",
  "Other",   9.6, "90",
  "Employment",   11.42, "90",
  "Prevocation",   2.56, "90",
  "VET school",   8.82, "90",
  "Dual VET",   38.42, "90",
  "UAS",   6.7, "90",
  "Dual study",   3.66, "90",
  "University",   18.72, "90"
)

ggplot(data=df, aes(x=fct_reorder(school, prediction), y=prediction, fill = group)) +
  geom_bar(stat="identity", position=position_dodge())+
  theme_minimal(base_size = 12)+
  labs(title = "Vorhergesagt Wahrscheinlichkeit Aktivität (unconditional)",
       fill = "Percentile",
       caption = "(based on Dräger 2021)") +
  xlab("Schule")+
  ylab("Vorhersage (%)")+
  scale_fill_brewer(palette = "Set1")+
  coord_flip()



df2 <- df %>%
  pivot_wider(names_from = group , 
              values_from = prediction)

df3 <- df2 %>% mutate(
  differences = round(`90` - `10`,2)
)

ggplot(data=df3, aes(x=fct_reorder(school, differences), y=differences)) +
  geom_bar(stat="identity")+
  theme_minimal(base_size = 12)+
  labs(title = "Nach dem Abschluss (unconditional)",
       caption = "(Dräger 2021: P90 - P10)") +
  xlab("Tätigkeit")+
  ylab("Differenz in der Vorhersage (%)")+
  scale_fill_brewer(palette = "Set1")+
  coord_flip()


