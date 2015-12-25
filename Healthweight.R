
library(ggplot2)
library(readxl)

weight <- read_excel("Healthcheck.xlsx", sheet=1)

#weight <- read.csv("Healthcheck.csv", header = TRUE)
weight1 <- weight[,c(1,2,8)]
weight1 <- na.omit(weight1)
weight2 <- weight1[1660:nrow(weight1),]
weight3 <- weight[,c(4,8)]
weight3 <- na.omit(weight3)
weight4 <-weight[,c(1,2,8:10)]
height <- 1.89
BMI <- (weight4$Weight)/(height^2)
w2h <- weight4$Waist/weight4$Hips
weight5 <- cbind(weight4, BMI,w2h)


dev.off()

#Weight over 2015 (-ish)
ggplot(weight2, aes(Date,Weight)) + 
  geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
  geom_smooth(method=loess, colour = "darkgreen") + 
  ggtitle("Weight") +
  ylim(83,98) +
        theme_bw()

dev.off()
#Weight over longer time
ggplot(weight1, aes(Date,Weight)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) +
  geom_smooth(colour = "darkgreen") + 
  ggtitle("Weight") +
  ylim(83,105) +
        theme_bw()

colors = c(rep("cornflowerblue",9),rep("limegreen",1))
boxplot(Weight ~ Year, 
        data = weight3,
        ylim = c(83,101),
        whisklty = 1,
        range = 0,
        col = colors)
abline(h=90.4, lty=2, col="red")


#Waist to Hip Ratio
ggplot(weight5[1000:nrow(weight5),], aes(x = Date, y = w2h)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) +
        geom_smooth(colour = "darkgreen") +
        ggtitle("Waist to Hip Ratio") +
        geom_abline(slope=0, intercept=0.9, lty=2, col="red") +
        theme_bw()

#Waist to Hip Ratio 2015
ggplot(weight5[3000:nrow(weight5),], aes(x = Date, y = w2h)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) +
        geom_smooth(colour = "darkgreen") +
        scale_y_continuous(limits = c(0.88,0.99)) +
        ggtitle("Waist to Hip Ratio") +
        geom_abline(slope=0, intercept=0.9, lty=2, col="red") +
        theme_bw()

#BMI
ggplot(weight5[1000:nrow(weight5),], aes(x = Date, y = BMI)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
        geom_smooth(colour = "blue") +
        ggtitle("BMI") +
        scale_y_continuous(limits = c(23, 29)) +
        geom_abline(slope=0, intercept=24, lty=2, col="red") +
        theme_bw()

