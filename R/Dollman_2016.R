library(tidyverse)
library(copycat)
  
df <- tibble::tribble(
  ~Education, ~Background, ~`Not-Mandatory`, ~Mandatory, ~Probabilities,
       "Low",    "Native",             0.07,       0.17,       "Actual",
       "Low",      "Turk",             0.15,       0.14,       "Actual",
       "Mid",    "Native",             0.36,       0.37,       "Actual",
       "Mid",      "Turk",             0.24,       0.24,       "Actual",
      "High",    "Native",             0.79,       0.73,       "Actual",
      "High",      "Turk",             0.33,       0.33,       "Actual",
       "Low",    "Native",              0.1,       0.24,    "Predicted",
       "Low",      "Turk",             0.24,       0.22,    "Predicted",
       "Mid",    "Native",             0.26,       0.35,    "Predicted",
       "Mid",      "Turk",             0.43,       0.36,    "Predicted",
      "High",    "Native",             0.69,       0.64,    "Predicted",
      "High",      "Turk",             0.59,       0.48,    "Predicted"
  )

head(df)


df2 <- df %>%
  filter(Probabilities == "Predicted")%>%
  select(!Probabilities)


df2$Education <- as.factor(df2$Education)


df2 <- df2 %>%
  pivot_longer(!Education:Background, names_to = "Mandatory", values_to = "Probabilities")



df2$Education <- fct_relevel(df2$Education, c("Low", "Mid", "High"))
df2$Mandatory <- fct_relevel(df2$Mandatory, "Not-Mandatory")



ggplot(data=df2, aes(x=Mandatory, y=Probabilities, 
                     group = Education, fill = Background)) +
  geom_bar(stat="identity")+
  theme_minimal(base_size = 14)+
  xlab("Transition")+
  ylab("Predicted probabilities")+
  #scale_fill_brewer(palette = "Set1")+
  facet_grid(Background ~ Education)+
  labs(title = "Predicted probabilities for the transition to upper secondary track",
       caption = "Based on: Dollmann 2016")+
  theme(legend.position="none")+
  theme(strip.text.x = element_text(size = 14),
        strip.text.y = element_text(size = 14))+
  scale_fill_manual(values=c("#ee9b00", "#005f73"))
  
  
  

  
  
  
  
  
  
  
