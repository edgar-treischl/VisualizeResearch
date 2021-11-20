library(datapasta)
library(tidyverse)
library(ggrepel)



#Data and Prep########
df <- tibble::tribble(
     ~Sex, ~Performance,   ~Outcome,    ~Jahr,
    "All",  52.3,     "Math", "2017(1)",
   "Boys", 57.32,     "Math", "2017(1)",
  "Girls", 47.29,     "Math", "2017(1)",
    "All", 51.88,     "Math", "2018(1)",
   "Boys", 56.97,     "Math", "2018(1)",
  "Girls", 46.81,     "Math", "2018(1)",
    "All", 50.88,     "Math", "2019(1)",
   "Boys", 56.12,     "Math", "2019(1)",
  "Girls",  45.6,     "Math", "2019(1)",
    "All", 50.71,     "Math", "2020(1)",
   "Boys", 56.28,     "Math", "2020(1)",
  "Girls", 45.08,     "Math", "2020(1)",
    "All",  52.5,     "Math", "2017(2)",
   "Boys", 57.24,     "Math", "2017(2)",
  "Girls", 47.77,     "Math", "2017(2)",
    "All", 51.84,     "Math", "2018(2)",
   "Boys", 56.54,     "Math", "2018(2)",
  "Girls", 47.15,     "Math", "2018(2)",
    "All", 51.53,     "Math", "2019(2)",
   "Boys", 56.51,     "Math", "2019(2)",
  "Girls", 46.53,     "Math", "2019(2)",
    "All", 49.26,     "Math", "2020(2)",
   "Boys", 54.57,     "Math", "2020(2)",
  "Girls", 43.93,     "Math", "2020(2)",
    "All",  53.3,  "Reading", "2017(1)",
   "Boys", 49.77,  "Reading", "2017(1)",
  "Girls", 56.81,  "Reading", "2017(1)",
    "All", 52.08,  "Reading", "2018(1)",
   "Boys", 48.96,  "Reading", "2018(1)",
  "Girls", 55.19,  "Reading", "2018(1)",
    "All", 50.99,  "Reading", "2019(1)",
   "Boys",  47.7,  "Reading", "2019(1)",
  "Girls", 54.31,  "Reading", "2019(1)",
    "All", 50.56,  "Reading", "2020(1)",
   "Boys", 47.46,  "Reading", "2020(1)",
  "Girls", 53.69,  "Reading", "2020(1)",
    "All", 52.94,  "Reading", "2017(2)",
   "Boys", 49.66,  "Reading", "2017(2)",
  "Girls", 56.23,  "Reading", "2017(2)",
    "All", 52.19,  "Reading", "2018(2)",
   "Boys", 49.21,  "Reading", "2018(2)",
  "Girls", 55.17,  "Reading", "2018(2)",
    "All", 51.92,  "Reading", "2019(2)",
   "Boys", 49.07,  "Reading", "2019(2)",
  "Girls", 54.77,  "Reading", "2019(2)",
    "All",  49.9,  "Reading", "2020(2)",
   "Boys", 47.25,  "Reading", "2020(2)",
  "Girls", 52.57,  "Reading", "2020(2)",
    "All", 52.39, "Spelling", "2017(1)",
   "Boys", 50.34, "Spelling", "2017(1)",
  "Girls", 54.43, "Spelling", "2017(1)",
    "All", 51.73, "Spelling", "2018(1)",
   "Boys", 50.11, "Spelling", "2018(1)",
  "Girls", 53.35, "Spelling", "2018(1)",
    "All", 51.18, "Spelling", "2019(1)",
   "Boys", 49.77, "Spelling", "2019(1)",
  "Girls",  52.6, "Spelling", "2019(1)",
    "All",  51.6, "Spelling", "2020(1)",
   "Boys", 50.44, "Spelling", "2020(1)",
  "Girls", 52.78, "Spelling", "2020(1)",
    "All", 51.48, "Spelling", "2017(2)",
   "Boys", 49.17, "Spelling", "2017(2)",
  "Girls", 53.79, "Spelling", "2017(2)",
    "All", 51.63, "Spelling", "2018(2)",
   "Boys", 49.53, "Spelling", "2018(2)",
  "Girls", 53.73, "Spelling", "2018(2)",
    "All",  52.1, "Spelling", "2019(2)",
   "Boys", 50.42, "Spelling", "2019(2)",
  "Girls", 53.78, "Spelling", "2019(2)",
    "All", 51.12, "Spelling", "2020(2)",
   "Boys",  49.5, "Spelling", "2020(2)",
  "Girls", 52.74, "Spelling", "2020(2)"
  )


#Main plot

df2 <- df %>% filter(Sex == "All")


ggplot(df2, aes(x=Jahr, y = Performance, group = Outcome, 
             color = Outcome)) +
  geom_line()+
  geom_point()+
  geom_vline(xintercept=7.5, linetype='dashed', col = 'red')+
  annotate("text", x = 7, y = 52.5, label = "Lock\nDown", size = 5)+
  scale_color_manual(values=c("#ee9b00", "#001219","#005f73"))+
  #expand_limits(y = c(40, 60))+
  geom_label(data = df2 %>% filter(Jahr == "2017(2)"),
                 aes(label = Outcome, color = Outcome),
                 #hjust = -1.0,
                 #vjust = 0.5,
                 fontface = "bold",
                 size = 4)+
    theme(legend.position="none")+
    theme_minimal(base_size = 12)+
    theme(legend.position="none")+
    labs(title = "Lock Down und schulische Kompetenzen",
         caption = "(Nach Engzell et al. 2021)")
    


  
#Sex Plot###############  
df3 <- df %>% filter(Sex != "All" & Outcome != "Spelling")
  

ggplot(data=df3, aes(x=Jahr, y = Performance, 
                    group = Sex, color = Sex)) +
  geom_line()+
  geom_point()+
  geom_vline(xintercept=7.5, linetype='dashed', col = 'red')+
  annotate("text", x = 6.5, y = 52, label = "Lock\nDown", size = 5)+
  geom_label(data = df3 %>% filter(Jahr == "2018(2)"),
                   aes(label = Sex, color = Sex),
                   #hjust = -1.0,
                   #vjust = 0.5,
                   fontface = "bold",
                   size = 4)+
  theme_minimal(base_size = 12)+
  facet_grid(. ~ Outcome)+
  theme(legend.position="none")+
  theme(strip.text.x = element_text(size = 14))+
  scale_color_manual(values=c("#ee9b00", "#001219","#005f73"))+
  theme(axis.text.x = element_text(size=10, angle=45))+
  labs(title = "Lock Down und Geschlecht",
       caption = "(Nach Engzell et al. 2021)")
  





#Social background

parents <- tibble::tribble(
             ~education,  ~Outcome, ~Performance, ~Messzeitpunkt,
                 "High",    "Math",   54.1,         1L,
                  "Low",    "Math",  37.82,         1L,
               "Lowest",    "Math",   34.1,         1L,
                 "High",    "Math",  53.54,         3L,
                  "Low",    "Math",  36.41,         3L,
               "Lowest",    "Math",  34.41,         3L,
                 "High",    "Math",  52.47,         5L,
                  "Low",    "Math",  35.29,         5L,
               "Lowest",    "Math",  33.51,         5L,
                 "High",    "Math",  52.18,         7L,
                  "Low",    "Math",  34.31,         7L,
               "Lowest",    "Math",  33.29,         7L,
                 "High",    "Math",  54.33,         2L,
                  "Low",    "Math",  37.24,         2L,
               "Lowest",    "Math",  34.52,         2L,
                 "High",    "Math",  53.51,         4L,
                  "Low",    "Math",  36.55,         4L,
               "Lowest",    "Math",  34.48,         4L,
                 "High",    "Math",   53.1,         6L,
                  "Low",    "Math",  36.08,         6L,
               "Lowest",    "Math",  34.47,         6L,
                 "High",    "Math",  50.85,         8L,
                  "Low",    "Math",  30.64,         8L,
               "Lowest",    "Math",  29.36,         8L,
                 "High", "Reading",  55.37,         1L,
                  "Low", "Reading",  37.77,         1L,
               "Lowest", "Reading",   31.4,         1L,
                 "High", "Reading",  54.03,         3L,
                  "Low", "Reading",  35.63,         3L,
               "Lowest", "Reading",  30.46,         3L,
                 "High", "Reading",  52.87,         5L,
                  "Low", "Reading",   34.3,         5L,
               "Lowest", "Reading",  29.17,         5L,
                 "High", "Reading",  52.29,         7L,
                  "Low", "Reading",  32.75,         7L,
               "Lowest", "Reading",  28.86,         7L,
                 "High", "Reading",  54.91,         2L,
                  "Low", "Reading",     38,         2L,
               "Lowest", "Reading",  29.75,         2L,
                 "High", "Reading",   54.1,         4L,
                  "Low", "Reading",  36.38,         4L,
               "Lowest", "Reading",  29.73,         4L,
                 "High", "Reading",  53.82,         6L,
                  "Low", "Reading",  34.85,         6L,
               "Lowest", "Reading",  29.27,         6L,
                 "High", "Reading",  51.72,         8L,
                  "Low", "Reading",   30.6,         8L,
               "Lowest", "Reading",  26.38,         8L
             )


parents <- parents %>%mutate(
  Jahr = case_when(
    Messzeitpunkt == 1 ~ "2017(1)",
    Messzeitpunkt == 2 ~ "2017(2)",
    Messzeitpunkt == 3 ~ "2018(1)",
    Messzeitpunkt == 4 ~ "2018(2)",
    Messzeitpunkt == 5 ~ "2019(1)",
    Messzeitpunkt == 6 ~ "2019(2)",
    Messzeitpunkt == 7 ~ "2020(1)",
    Messzeitpunkt == 8 ~ "2020(2)"
    
  )
)


ggplot(data=parents, aes(x=Jahr, y = Performance, 
                     group = education, color = education)) +
  geom_line()+
  geom_point()+
  geom_vline(xintercept=7.5, linetype='dashed', col = 'red')+
  annotate("text", x = 6.5, y = 45, label = "Lock\nDown", size = 5)+
  theme_minimal(base_size = 12)+
  geom_label_repel(data = parents %>% filter(Messzeitpunkt == 5 ),
                   aes(label = education, color = education),
                   #hjust = -1.0,
                   #vjust = 0.5,
                   fontface = "bold",
                   size = 3)+
  facet_grid( ~ Outcome)+
  theme(legend.position="none")+
  theme(strip.text.x = element_text(size = 14))+
  theme(axis.text.x = element_text(size=10, angle=45))+
  scale_color_manual(values=c("#ee9b00", "#001219","#005f73"))+
  labs(title = "Lock Down nach Bildung der Eltern",
       caption = "(Nach Engzell et al. 2021)")


