
library(ggplot2)
library(readxl)
library(dplyr)

weight <- read_excel("Healthcheck.xlsx", sheet=1)
weight2 <- weight %>%
        filter(Date >"2015-11-30") %>%
        filter(Date <"2016-02-02")


dev.off()

#Weight 
plot_wt <- ggplot(weight2, aes(Date,Weight)) + 
                geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 4) + 
                geom_point(aes(Date,Target), shape = 19, colour = "darkgreen", size = 1) + 
                geom_smooth(method=loess, colour = "darkgreen") + 
                geom_abline(slope = 0, intercept = 95.3, lty=2, col="red") +
                geom_abline(slope = 0, intercept = 85, lty=2, col="red") +
                ggtitle("Weight") +
                ylim(82,98) +
                theme_bw()
plot_wt

