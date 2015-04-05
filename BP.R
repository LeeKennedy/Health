library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(xlsx)
#data <- read.csv("BP.csv", as.is=TRUE, header=TRUE, skip=18)
data <- read.xlsx("Healthcheck.xlsx",2, startRow=19, header=TRUE)

data1 <- select(data, everything())%>%
        mutate(Systolic = as.numeric(as.character(A)), 
               Diastolic = as.numeric(as.character(B)))%>%
        na.omit

data2 <- data1[,c(1,16,17)]

data2$Date <- ymd(data2$Date)

data3 <- gather(data2, Type, Reading, -Date)

plot <- ggplot(data3, aes(Date, Reading, colour = Type)) +
        geom_point(size=4, shape=21) +
        geom_smooth(lwd=1) +
        scale_colour_brewer(palette="Set1") +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              text = element_text(size = 14))
plot

