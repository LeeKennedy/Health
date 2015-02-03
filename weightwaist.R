ww <- read.csv("w2w.csv", as.is= TRUE, header=TRUE)
library(ggplot2)

ww$Waist <- sapply(ww$Waist, as.numeric)

fit <- lm(ww$Waist~ww$Weight)
summary(fit)

ggplot(ww, aes(x=Waist, y=Weight)) +
      geom_point(color="blue",size=4, alpha=0.25) +
      geom_smooth(method=lm)