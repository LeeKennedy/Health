# Clean environment ------------------------------------------------------
rm(list=ls())

# Packages----------------------------------------------------------------
library(ggplot2)
library(readxl)
library(dplyr)
library(lubridate)

# Import data ------------------------------------------------------------
weight <- read_excel("rawdata/Healthcheck.xlsx", sheet=1)

weight1 <- weight[,c(1,2,8)]
weight1 <- na.omit(weight1)
weight2 <- weight1[1660:nrow(weight1),]
weight3 <- weight[,c(4,8)]
weight3 <- na.omit(weight3)
weight4 <-weight[,c(1,2,8:10)]
height <- 1.88
BMI <- (weight4$Weight)/(height^2)
w2h <- weight4$Waist/weight4$Hips 
weight5 <- cbind(weight4, BMI,w2h)
weight5$Age = year(weight5$Date)-1954

weight5$fat <- 1.2*weight5$BMI +0.23*weight5$Age - 16.2


dev.off()

days_x <- nrow(weight2)

# Weight over 2015 (-ish) ------------------------------------------------
weight_2015 <- ggplot(weight2, aes(Date,Weight)) + 
        geom_rect(aes(ymin = 86, ymax = 88, xmin = weight2$Date[1], xmax = weight2$Date[days_x]), fill = "grey80") +
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
        geom_smooth(method=loess, colour = "darkgreen") + 
        labs(title = "Weight, January 2015 onwards", y="kg", x="") +
        theme_bw() +
        scale_y_continuous(breaks = seq(82, 98, by=1)) 
        
weight_2015

# Weight over longer time -------------------------------------------------
all_weight <- ggplot(weight1, aes(Date,Weight)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) +
  geom_smooth(colour = "darkgreen") + 
  ggtitle("Weight") +
  ylim(83,105) +
        theme_bw()

all_weight

# Boxplots of yearly weight spread ---------------------------------------
colors = c(rep("cornflowerblue",12),rep("limegreen",1))
boxplot(Weight ~ Year, 
        data = weight3,
        ylim = c(83,101),
        whisklty = 1,
        range = 0,
        col = colors)


#Waist to Hip Ratio ------------------------------------------------------
w2h_plot <- ggplot(weight5[1000:nrow(weight5),], aes(x = Date, y = w2h)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) +
        geom_smooth(colour = "darkgreen") +
        ggtitle("Waist to Hip Ratio") +
        geom_abline(slope=0, intercept=0.9, lty=2, col="red") +
        theme_bw()

w2h_plot

#Waist to Hip Ratio 2015 -------------------------------------------------
w2h_2015 <- ggplot(weight5[3000:nrow(weight5),], aes(x = Date, y = w2h)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) +
        geom_smooth(colour = "darkgreen") +
        scale_y_continuous(limits = c(0.88,0.99)) +
        ggtitle("Waist to Hip Ratio") +
        geom_abline(slope=0, intercept=0.9, lty=2, col="red") +
        theme_bw()

w2h_2015

# BMI --------------------------------------------------------------------
bmi_plot <- ggplot(weight5[1000:nrow(weight5),], aes(x = Date, y = BMI)) + 
        geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
        geom_smooth(colour = "blue") +
        ggtitle("BMI") +
        scale_y_continuous(limits = c(23, 30)) +
        #scale_y_continuous(breaks = seq(23, 30, by=1)) +
        geom_abline(slope=0, intercept=24, lty=2, col="blue") +
        geom_abline(slope=0, intercept=25, lty=2, col="red") +
        theme_bw() 

bmi_plot

