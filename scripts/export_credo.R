# Clean Up environment ---------------------------------------------------
rm(list=ls())

# Packages ---------------------------------------------------------------
library(tidyverse)
library(readxl)
library(lubridate)


# Data Input 1 -------------------------------------------------------------
wt_data <- read_excel("~/Documents/GitHub/Health/rawdata/Healthcheck.xlsx", 
                      sheet = "Daily Data")


# Data Cleaning ----------------------------------------------------------

wt_data2 <- wt_data[, c(1:11)]

wt_data2 <- wt_data2 %>% 
        filter(Year == 2017)

wt_data3 <- wt_data[, c(1:11)]

# Export Data -------------------------------------------------------

write_csv(wt_data2, "~/Documents/GitHub/Credo/data/wt_data.csv")
write_csv(wt_data3, "~/Documents/GitHub/Credo/data/wt_data_all.csv")

# Data Input 2 -------------------------------------------------------------
bp_data <- read_excel("~/Documents/GitHub/Health/rawdata/Healthcheck.xlsx", 
                       sheet = "BP, Pulse & Temp")


# Data Cleaning ----------------------------------------------------------

bp_data2 <- bp_data[, c(1,14,15,16)]
bp_data2$Year <- year(bp_data2$Date)

bp_data2 <- bp_data2 %>% 
        filter(Year == 2018)
bp_data2 <- bp_data2[,c(1,5,2,3,4)]
colnames(bp_data2)[3] <- "Systolic"
colnames(bp_data2)[4] <- "Diastolic"
colnames(bp_data2)[5] <- "Pulse"

bp_data3 <- tidyr::gather(data = bp_data2, key = Reading, value = Value, na.rm = FALSE, Systolic, Diastolic, Pulse)

# Export Data -------------------------------------------------------

write_csv(bp_data3, "~/Documents/GitHub/Credo/data/bp_data.csv")

# Data Input 3 -------------------------------------------------------------
chol_data <- read_excel("~/Documents/GitHub/Health/rawdata/Healthcheck.xlsx", 
                        sheet = "Tests")


# Data Cleaning ----------------------------------------------------------

chol_data2 <- chol_data[, c(1:8)]



# Export Data -------------------------------------------------------

write_csv(chol_data2, "~/Documents/GitHub/Credo/data/chol_data.csv")

