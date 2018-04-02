# Clean environment ------------------------------------------------------
rm(list=ls())

# Packages----------------------------------------------------------------
library(ggplot2)
library(readxl)
library(dplyr)
library(lubridate)
library(tidyr)

# Import data ------------------------------------------------------------
data <- read_excel("rawdata/Healthcheck.xlsx",2, skip=18)

data2 <- data[,c(1,16)]
data2 <- na.omit(data2)
colnames(data2)[2] <- "Pulse"

data2$Date <- ymd(data2$Date)

# Plot blood pressure ----------------------------------------------------
pulse_plot <- ggplot(data2, aes(Date, Pulse)) +
        geom_point(size=4, shape=21, fill = "cornflowerblue") +
        geom_smooth(lwd=1) +
        geom_hline(yintercept = 50, lty=2,col="red") +
        scale_y_continuous(limits = c(40,90)) +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              text = element_text(size = 14))
pulse_plot

pulse_hist <- ggplot(data2, aes(x=Pulse)) +
        geom_histogram(aes(y = ..density..), fill="cornflowerblue", col="darkgreen") +
        stat_function(fun = dnorm, 
                      args = list(mean = mean(data2$Pulse), sd = sd(data2$Pulse)), 
                      lwd = 1, 
                      col = 'red') +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              text = element_text(size = 14))

pulse_hist

data2$Year <- year(data2$Date)

colors = c(rep("cornflowerblue",4),rep("limegreen",1))

pulse_box <- ggplot(data2, aes(x=Year, y=Pulse, group = Year)) +
        geom_boxplot(fill = colors) +
        geom_hline(yintercept = 50, lty=2,col="red") +
        scale_y_continuous(limits = c(40,90)) +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
        axis.line = element_line(size = 0.7, color = "black"), 
        text = element_text(size = 14))
pulse_box
