# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(readxl)
library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

# Functions --------------------------------------------------------------

remove_outliers <- function(x, na.rm = TRUE, ...) {
 qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
 y <- x
 y[x < (qnt[1] - H)] <- NA
 y[x > (qnt[2] + H)] <- NA
 y
}

# Data Input -------------------------------------------------------------

cholesterol <- read_excel("/Users/Study Old/Documents/GitHub/Health/rawdata/Healthcheck.xlsx", sheet=3)

# Data Cleaning ----------------------------------------------------------
cholesterol <- na.omit(cholesterol[,c(1,2,4,5)])
chol_long <- gather(data=cholesterol,key=Type,value=Level,na.rm=FALSE,Chol,HDL,LDL)

# Visualising Data -------------------------------------------------------

chol_plot <- ggplot(chol_long, aes(x=Date, y = Level, group = Type, fill = Type)) +
        geom_point(size = 4, shape = 21, colour = "black") +
        geom_line(lwd = 1, aes(colour = Type)) +
        labs(title = "Cholesterol\n")
chol_plot

### Ratio ----------------------------------------------------------------

cholesterol <- cholesterol %>% 
        mutate(ratio = LDL/HDL)

ratio_plot <- ggplot(cholesterol, aes(x=Date, y = ratio)) +
        geom_point(size = 4, shape = 21, colour = "black", fill = "cornflowerblue") +
        geom_line(lwd = 1, aes(colour = "cornflowerblue")) +
        labs(title = "Cholesterol- LDL/HDL Ratio\n")
ratio_plot

