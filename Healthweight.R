
library(ggplot2)
library(readxl)

weight <- read_excel("Healthcheck.xlsx", sheet=1)

#weight <- read.csv("Healthcheck.csv", header = TRUE)
weight1 <- weight[,c(1,8)]
weight1 <- na.omit(weight1)
weight2 <- weight1[1600:nrow(weight1),]
weight3 <- weight[,c(4,8)]
weight3 <- na.omit(weight3)
weight4 <-weight[,c(1,8:10)]
height <- 1.89
BMI <- (weight4$Weight)/(height^2)
w2h <- weight4$Waist/weight4$Hips
weight5 <- cbind(weight4, BMI,w2h)


dev.off()

#Weight over 2015 (-ish)
ggplot(weight2, aes(Index,Weight)) + 
  geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
  geom_smooth(method=loess, colour = "darkgreen") + 
  ggtitle("Weight") +
  ylim(85,98) +
        theme_bw()

#Weight over longer time
ggplot(weight1, aes(Index,Weight)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) +
  geom_smooth(colour = "darkgreen") + 
  ggtitle("Weight") +
  ylim(85,105) +
        theme_bw()

colors = c(rep("cornflowerblue",9),rep("limegreen",1))
boxplot(Weight ~ Year, 
        data = weight3,
        col = colors)
abline(h=94, lty=2, col="red")


#Waist to Hip Ratio
ggplot(weight5[2400:nrow(weight5),], aes(x = Index, y = w2h)) + 
        geom_point() +
        geom_smooth(colour = "darkgreen") +
        ggtitle("Waist to Hip Ratio")

#BMI
ggplot(weight5[2000:nrow(weight5),], aes(x = Index, y = BMI)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
        geom_smooth(colour = "blue") +
        ggtitle("BMI") +
        geom_abline(slope=0, intercept=25, lty=2, col="red") +
        theme_bw()

