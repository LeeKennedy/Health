library(dplyr)
library(ggplot2)
library(lubridate)
library(tidyr)
library(xlsx)
#data <- read.csv("BP.csv", as.is=TRUE, header=TRUE, skip=18)
data <- read.xlsx("Healthcheck.xlsx",2, startRow=19, header=TRUE)

data1 <- select(data, Date, Temp.1, Temp.2, Temp.3)%>%
        mutate(Temp.1 = as.numeric(as.character(Temp.1)), 
               Temp.2 = as.numeric(as.character(Temp.2)),
               Temp.3 = as.numeric(as.character(Temp.3)))%>%
        mutate(Ave.Temp = (Temp.1 + Temp.2 + Temp.3)/3)%>%
        na.omit

data1$Date <- ymd(data1$Date)

data3 <- gather(data1, Type, Reading, -Date)

plot <- ggplot(data3, aes(Date, Reading, colour = Type)) +
        geom_point(size=4, shape=21) +
        geom_smooth(lwd=1) +
        scale_colour_brewer(palette="Set1") +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              text = element_text(size = 14))
plot

