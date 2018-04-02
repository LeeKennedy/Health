# Clean environment ------------------------------------------------------
rm(list=ls())

# Packages----------------------------------------------------------------
library(ggplot2)
library(readxl)
library(dplyr)
library(lubridate)
library(tidyr)

psa <- read_excel("rawdata/Healthcheck.xlsx", sheet="Tests")

psa <- na.omit(psa[,c(1,7)])

psa_plot <- ggplot(psa, aes(x=Date, y = PSA)) +
        geom_point(size = 4, shape = 21, fill = "cornflowerblue", colour = "black") +
        geom_line(lwd = 1) +
        labs(title = "PSA\n") +
        scale_y_continuous(limits = c(0,1))
psa_plot