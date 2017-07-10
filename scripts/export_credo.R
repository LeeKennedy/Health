# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(tidyverse)
library(readxl)
library(lubridate)

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
wt_data <- read_excel("~/Documents/GitHub/Health/rawdata/Healthcheck.xlsx", 
                      sheet = "Daily Data")


# Data Cleaning ----------------------------------------------------------

wt_data2 <- wt_data[, c(1:11)]

wt_data2 <- wt_data2 %>% 
        filter(Year == 2017)

# Export Data -------------------------------------------------------

write_csv(wt_data2, "~/Documents/GitHub/Credo/data/wt_data.csv")