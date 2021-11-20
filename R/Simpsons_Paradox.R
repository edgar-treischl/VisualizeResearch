library(tidyverse)

df  <- as.data.frame(UCBAdmissions)


df2 <- df %>%
  group_by(Gender, Admit)%>%
  summarise(
    Freq = sum(Freq)) %>% 
  mutate(Percent = Freq/sum (Freq)*100)


df2%>%
  ggplot(aes(x = Gender, y = Percent, group = Gender, fill= Admit))+
  geom_bar(stat="identity", position=position_stack())+
  geom_text(aes(label = round(Percent, 2)), 
            position = position_stack(vjust = 0.5),
            colour = "white", size = 5, fontface = "bold")+
  theme_minimal(base_size = 20)+
  scale_fill_manual(values=c("#264653", "#e76f51"))+
  guides(fill = guide_legend(reverse=TRUE))



df_dep <- df %>%
  group_by(Dept) %>%
  mutate(Percent = Freq/sum (Freq)*100)

Dept.labs <- c(`A` = "Department A", 
               `C` = "Department C", 
               `F` = "Department F")



df_dep%>%
  filter (Dept == "A" | Dept == "C" | Dept == "F") %>% 
  ggplot(aes(x = Gender, y = Percent, group = Gender, 
             fill= Admit))+
  geom_bar(stat="identity", position=position_stack())+
  geom_text(aes(label = round(Percent, 2)), 
            position = position_stack(vjust = 0.5),
            colour = "white", size = 5, fontface = "bold")+
  theme_minimal(base_size = 20)+
  scale_fill_manual(values=c("#264653", "#e76f51"))+
  facet_wrap(. ~ Dept, ncol=3,
             labeller = as_labeller(Dept.labs))+
  theme(strip.text.x = element_text(
    size = 12, color = "black", face = "bold"))+
  guides(fill = guide_legend(reverse=TRUE))






