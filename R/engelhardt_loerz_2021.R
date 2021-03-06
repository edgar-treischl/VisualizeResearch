library(datapasta)
library(tidyverse)
library(ggrepel)



#Data and Prep########
df <- tibble::tribble(
  ~Ranking,                                  ~Fach, ~`1976`, ~`1978`, ~`1980`, ~`1983`, ~`1986`,
       15L,                              "Medizin",     9.67,     9.62,     9.22,     13.7,    15.12,
       14L,                                 "Jura",     5.53,     4.91,     5.25,     4.32,     3.61,
       13L,                         "Maschinenbau",     6.15,     6.75,      8.3,     6.15,     5.99,
       12L,                       "Elektrotechnik",     1.35,     1.64,     1.32,     1.23,      1.3,
       11L,                "Mathematik/Informatik",     4.84,     5.83,     5.49,     3.09,     3.59,
       10L,            "Biologie/Chemie/Pharmazie",     6.77,     7.98,     8.46,     6.97,     7.02,
        9L,               "Physik/Geowissenschaft",     6.87,     6.01,      6.2,     6.96,     7.67,
        8L,              "Wirtschaftswissenschaft",     7.68,     7.96,     8.42,     1.21,    12.46,
        7L,        "Architektur/Bauingenieurwesen",     3.98,     4.35,     3.76,     3.28,     3.37,
        6L,                          "Psychologie",    18.92,    16.88,    15.27,    11.78,    10.78,
        5L,                   "Sozialwissenschaft",     5.71,     4.69,     6.28,     9.26,     8.77,
        4L,           "Kultur-/Sprachwissenschaft",     7.99,     8.82,     8.15,     7.45,     7.83,
        3L,                     "Kunst/Gestaltung",     4.58,     4.67,     4.64,     4.86,      5.7,
        2L,                            "EWS/Sport",     6.41,     5.48,     5.58,     6.05,     3.96,
        1L, "Agrar-/Ernährungs-/Forstwissenschaft",     3.54,     4.41,     3.66,     2.81,     2.82
  )

df

df2 <- df %>% mutate(
  differences = `1986` - `1976`
)

df2 <- df2 %>% 
  mutate(
    development = (
      case_when(
        differences > 0  ~ "Zunahme",
        differences < 0 ~ "Abnahme"
      )
    )
  )





#summary(df2$differences)


df_long <- df2 %>% 
  drop_na()  %>% 
  pivot_longer(cols = c(`1976`, `1978`, `1980`, `1983` ,`1986`), 
               names_to = "year", 
               values_to = "outcome")

  


#The Plot######

ggplot(data=df_long, aes(x=year, y = outcome, group=Fach)) +
  geom_line(color = "gray")+
  geom_line(data = df_long %>% filter(differences <= -1.2 | differences > 1),
            aes(color = Fach))+
  geom_point(data = df_long %>% filter(differences <= -1.2 | differences > 1),
            aes(color = Fach))+
  facet_grid(. ~ development)+
  geom_vline(xintercept=4, linetype='dashed', col = 'black')+
  annotate("text", x = 4.05, y = 19, label = "Bafög   Reform", size = 4)+
  theme_minimal(base_size = 14)+
  geom_label_repel(data = df_long %>% filter(year == "1983" & development == "Zunahme" & differences >= 1),
                   aes(label = Fach, color = Fach),
                   #hjust = -1.0,
                   #vjust = 0.5,
                   fontface = "bold",
                   size = 3)+
  geom_label_repel(data = df_long %>% filter(year == "1983" & development == "Abnahme" & differences <= -1.2),
             aes(label = Fach, color = Fach),
             #hjust = -1.0,
             #vjust = 0.5,
             fontface = "bold",
             size = 3)+
  labs(title = "Studierende nach Studienrichtung zwischen 1976 und 1986",
       guides = FALSE,
       caption = "(Nach Engelhardt & Lörz 2021)") +
  xlab("Jahr")+
  ylab("Studierende (%)")+
  theme(legend.position="none")+
  #scale_color_viridis(discrete=TRUE, option="viridis")+
  scale_color_manual(values=c("#001219","#005f73", "#0a9396", "#94d2bd",
                              "#ee9b00","#bb3e03", "#457b9d", "#1d3557"))+
  theme(strip.text.x = element_text(size = 14))
  

#scale_color_brewer(palette = "Set2")+
  

#Export######  
#setwd("C:/Users/gu99mywo/Dropbox/Lehre/Bildung/Bildung MA/WiSe_21_22")
#ggsave(file="a5_output.png", width = 210, height = 148, units = "mm")




