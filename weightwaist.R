library(ggplot2)
library(readxl)

weight <- read_excel("Healthcheck.xlsx", sheet=1)
w2w <- na.omit(weight[,c(8,9)])

fit <- lm(w2w$Waist~w2w$Weight)
summary(fit)

ggplot(w2w, aes(x=Waist, y=Weight)) +
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4, alpha=0.25) +
        geom_smooth(method=lm) +
        theme_bw()
