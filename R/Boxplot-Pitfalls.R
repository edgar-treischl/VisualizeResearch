library(ggplot2)

# create a dataset
data <- data.frame(
  group=c(rep('A', 100), rep("B", 500), rep("C", 15)),
  outcome=c(rnorm(100, 12, 1), rnorm(500, 13, 1), rnorm(15, 20, 4))
)

p1 <- data %>%
  ggplot(aes(x=group, y=outcome, color=group)) +
  geom_boxplot()+
  scale_color_manual(values=c(rep("#969696", 4)))+
  theme(legend.position="none")+
  ggtitle("A: A boxplot")+
  theme_minimal()

# Plot B
p2 <- data %>%
  ggplot(aes(x=group, y=outcome, color=group)) +
  geom_boxplot()+
  geom_jitter(color="black", size=0.7, alpha=0.5) +
  #geom_point(size=2, alpha=0.2) +
  scale_color_manual(values=c(rep("#969696", 4)))+
  theme(legend.position="none")+
  ggtitle("B: A boxplot with jitter")+
  theme_minimal()

p3 <- gridExtra::grid.arrange(p1, p2, ncol=2)

#Export
#ggsave(p3, file="boxplot_pitfalls.png", width = 210, height = 148, units = "mm")
