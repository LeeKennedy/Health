# Clean environment ------------------------------------------------------
rm(list=ls())

# Packages----------------------------------------------------------------
library(ggplot2)
library(readxl)
library(dplyr)

# Import data ------------------------------------------------------------
data <- read_excel("rawdata/Healthcheck.xlsx",2, skip=18)

data1 <- select(data, Date, Temp1, Temp2, Temp3)%>%
        mutate(Temp1 = as.numeric(as.character(Temp1)), 
               Temp2 = as.numeric(as.character(Temp2)),
               Temp3 = as.numeric(as.character(Temp3)))%>%
        mutate(Ave.Temp = (Temp1 + Temp2 + Temp3)/3)

data1$Date <- ymd(data1$Date)
data1 <- data1[,c(1:4)]
data1 <- na.omit(data1)

data3 <- gather(data1, Type, Reading, -Date)

dev.off()
# Plot temperature -------------------------------------------------------
plot <- ggplot(data3, aes(Date, Reading, colour = Type)) +
        geom_point(size=4, shape=21) +
        geom_smooth(lwd=1) +
        scale_colour_brewer(palette="Set1") +
        theme_bw() +
        theme(panel.grid.major = element_line(size = 0.5, color = "grey"), 
              axis.line = element_line(size = 0.7, color = "black"), 
              text = element_text(size = 14))
plot

