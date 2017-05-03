# Clean environment ------------------------------------------------------
rm(list=ls())

# Packages----------------------------------------------------------------
library(ggplot2)
library(readxl)
library(dplyr)

# Import data ------------------------------------------------------------
weight <- read_excel("rawdata/Healthcheck.xlsx", sheet=1)
weight2 <- weight %>%
        filter(Date >"2015-11-30") %>%
        filter(Date <"2017-04-30")
cache("weight2")



# Plot weight ------------------------------------------------------------ 
plot_wt <- ggplot(weight2, aes(Date,Weight)) + 
                geom_rect(aes(ymin = 85, ymax = 87, xmin = weight2$Date[1], xmax = weight2$Date[517]), fill = "grey80") +
                geom_rect(aes(ymin = 87, ymax = 88, xmin = weight2$Date[1], xmax = weight2$Date[517]), fill = "grey90") +
                geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 6) + 
                geom_smooth(method=loess, colour = "darkgreen", size = 2) + 
                geom_hline(yintercept = 95.3, lty=2, col="red") +
                geom_vline(xintercept=as.numeric(weight2$Date[71]), lty=2, col="red") +
                theme_bw() +
                scale_y_continuous(breaks = seq(82, 96),1) +
                labs(title="Weight since DTS Greatest Loser Challenge started...\n", y="") + 
                theme(plot.title = element_text(size = 14)) 
plot_wt

