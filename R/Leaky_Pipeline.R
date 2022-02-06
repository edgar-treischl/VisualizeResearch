library(tidyverse)

library(showtext)

font_add_google("Patua One", "Patua")
showtext_auto()


leakypipeline_plot <- function(variables) {
  leaky_pipeline <- tibble::tribble(
    ~Gruppe, ~`2017`, ~`2018`, ~`2019`,     ~Sex,
    "Studierende",     485,     489,     493, "Frauen",
    "Absolventen",     508,     511,     517, "Frauen",
    "Promotion",     448,     452,     454, "Frauen",
    "Habilitation",     293,     316,     319, "Frauen",
    "C4-Professur",     115,     117,     117, "Frauen",
    "Studierende",     515,     511,     507, "Männer",
    "Absolventen",     492,     489,     483, "Männer",
    "Promotion",     552,     548,     546, "Männer",
    "Habilitation",     707,     684,     681, "Männer",
    "C4-Professur",     885,     883,     883, "Männer"
  )
  
  leaky_pipeline$Gruppe <- factor(leaky_pipeline$Gruppe, 
                                  levels = c("Studienanfänger", 
                                             "Studierende",
                                             "Absolventen", 
                                             "Promotion", 
                                             "Habilitation", 
                                             "C4-Professur"))
  
  
  
  
  ggplot(leaky_pipeline, aes(x=Gruppe, y=`2019`, group = Sex, color = Sex)) +
    geom_line(size = 1.5) +
    geom_point(size = 2.5)+
    theme_minimal(base_size = 14)+
    geom_label(data = leaky_pipeline %>% filter(Gruppe == "Promotion"),
               aes(label = Sex, color = Sex),
               #hjust = 1.0,
               #vjust = 0.5,
               fontface = "bold",
               size = 5.5,
               family="Patua")+
    labs(caption = "Daten: destatis.de",
         y = "Anzahl nach akademischer Laufbahn (2019)")+
    theme(legend.position="none")+
    scale_color_manual(values = c("#264653", "#e76f51"))+
    theme(text=element_text(family="Patua"))
  
}

leakypipeline_plot()



