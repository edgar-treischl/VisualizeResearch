library(tidyverse)

set.seed(1)
a <- data.frame(x = 5 + rnorm(100), y = 5 + rnorm(100)) %>% mutate(y = y-x/4)
c <- a %>% mutate(x=x+2) %>% mutate(y=y+2)
simps_df <- do.call(rbind, list(a,c))
simps_df <- simps_df %>% mutate(Sex=rep(c("Men", "Women"), each=100))


p1<- ggplot(simps_df, aes(x=x, y=y)) +
  geom_point(size=2, color="black") +
  theme_minimal(base_size = 14)+
  geom_smooth(method = "lm", formula = y ~ x, color="#29303B") 


df_text <- data.frame(
  x = c(8, 8),
  y = c(5.5, 2.9),
  text = c("Women", "Men")
)


p2 <- ggplot(simps_df) +
  geom_point(aes(x=x, y=y, color=Sex), size=2) +
  geom_smooth(aes(x=x, y=y, color=Sex), 
              method = "lm", formula = y ~ x, se=TRUE, fullrange=TRUE) +
  scale_colour_manual(values =c ("#8A8FA1", "#0057AD"))+
  theme_minimal(base_size = 14)+
  theme(legend.position="none")+
  geom_label(data = df_text, 
             aes(x = x, y = y, label = text) ,
             fill= c("#0057AD", "#8A8FA1"),
             size = 5,
             color= c("white", "white"))

p3 <- gridExtra::grid.arrange(p1, p2, ncol=2)



#Admissions#######
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
            colour = "white", size = 4, fontface = "bold")+
  theme_minimal(base_size = 20)+
  scale_fill_manual(values=c("#264653", "#e76f51"))+
  facet_wrap(. ~ Dept, ncol=3,
             labeller = as_labeller(Dept.labs))+
  theme(strip.text.x = element_text(
    size = 12, color = "black", face = "bold"))+
  guides(fill = guide_legend(reverse=TRUE))


#Export
ggsave(p3, file="Simpson.png", width = 210, height = 148, units = "mm")



