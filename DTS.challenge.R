
library(ggplot2)
library(readxl)
library(dplyr)

weight <- read_excel("Healthcheck.xlsx", sheet=1)
weight <- weight %>%
        filter(Date >"2015-11-30")

weight1 <- weight[,c(1,2,8)]
weight2 <- na.omit(weight1)

#weight2 <- weight1[1600:nrow(weight1),]

weight3 <- weight[,c(4,8)]
weight3 <- na.omit(weight3)
weight4 <-weight[,c(1,2,8:10)]
height <- 1.89
BMI <- (weight4$Weight)/(height^2)
w2h <- weight4$Waist/weight4$Hips
weight5 <- na.omit(cbind(weight4, BMI,w2h))


dev.off()

#Weight 
ggplot(weight2, aes(Date,Weight)) + 
  geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
  geom_smooth(method=loess, colour = "darkgreen") + 
  ggtitle("Weight") +
  ylim(85,98) +
        theme_bw()

#Waist to Hip Ratio
ggplot(weight5, aes(x = Date, y = w2h)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) +
        geom_smooth(colour = "darkgreen") +
        ggtitle("Waist to Hip Ratio") +
        geom_abline(slope=0, intercept=0.9, lty=2, col="red") +
        theme_bw()

#BMI
ggplot(weight5, aes(x = Date, y = BMI)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
        geom_smooth(colour = "blue") +
        ggtitle("BMI") +
        scale_y_continuous(limits = c(23, 29)) +
        geom_abline(slope=0, intercept=24, lty=2, col="red") +
        theme_bw()

