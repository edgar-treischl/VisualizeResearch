library(tidyverse)
library(ggbrace)

median_mpg <- median(mtcars$mpg)
min_mpg <- min(mtcars$mpg)
max_mpg <- max(mtcars$mpg)

#iqr_mpg <- IQR(mtcars$mpg)

#quant_mpg <- quantile(mtcars$mpg)
#whiskermax <- quant_mpg[4] + 1.5*iqr_mpg


intern_p <- ggplot(mtcars, aes(mpg)) + 
  geom_boxplot()+
  coord_flip()


dat <- ggplot_build(intern_p)$data[[1]]

mtcars %>% 
  ggplot(aes(y = mpg))+
  geom_boxplot(outlier.colour = "red", colour = "black")+
  geom_segment(data=dat, aes(y=xmiddle , yend=xmiddle, 
                             x=ymin, xend=ymax), 
               colour="red", size=1.5)+
  coord_flip()+
  theme_minimal()+
  xlab("")+
  ylab("")+
  #median
  annotate("text", y=median_mpg, x=0.42, label= "Median")+
  #max
  annotate("text", y=max_mpg - 1, x=-.52, 
           label= "Maximum")+
  geom_segment(aes(x = -0.04, y = max_mpg - 1.3 , #median
                   xend = -.45 , yend = max_mpg - 1.3),
               arrow = arrow(length = unit(0.5, "cm")),
               size = 1)+
  #outliers
  annotate("text", y=36.5, x=0, 
           label= "Potential\noutliers",
           color = "red")+
  #min
  annotate("text", y=min_mpg, x=-.52, label= "Minimum")+
  geom_segment(aes(x = -0.04, y = min_mpg, #median
                   xend = -.45 , yend = min_mpg),
               arrow = arrow(length = unit(0.5, "cm")),
               size = 1)+
  geom_brace(aes(c(-.38, -0.48), c(15.425, 22.800), label=""), 
             inherit.data=F, labelsize=5, rotate = 270)+
  annotate("text", y=19.9, x=-.52, label= "Interquartile range")+
  ylim(5, 40)+
  xlim(-.65, .5)


#export
ggsave(file="boxplot.png", width = 210, height = 148, units = "mm")
