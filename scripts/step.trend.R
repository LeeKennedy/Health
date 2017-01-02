# Clean environment ------------------------------------------------------
rm(list=ls())

# Packages----------------------------------------------------------------
library(ggplot2)
library(readxl)
library(dplyr)
library(lubridate)

# Import data ------------------------------------------------------------
weight <- read_excel("rawdata/Healthcheck.xlsx", sheet=1)
steps <- weight[,c(1,2,3,17,18)]
colnames(steps)[5] <- "7_Day_Total"

steps.7 <- na.omit(steps)


# Plot weekly trend ------------------------------------------------------
step_plot <- ggplot(steps.7, aes(x=Date, y=`7_Day_Total`)) +
        geom_bar(stat = "identity", colour = "black", fill = "cornflowerblue") +
        geom_hline(yintercept = 70000, col = "red", lty = 2)
step_plot