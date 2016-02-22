library(ProjectTemplate)
load.project()

weight <- read_excel("rawdata/Healthcheck.xlsx", sheet=1)
weight2 <- weight %>%
        filter(Date >"2015-11-30") %>%
        filter(Date <"2016-03-29")
cache("weight2")

#dev.off()

#Weight 
plot_wt <- ggplot(weight2, aes(Date,Weight)) + 
                geom_point(shape = 21, fill = "cornflowerblue", colour = "blue", size = 8) + 
                geom_smooth(method=loess, colour = "darkgreen", size = 2) + 
                geom_hline(yintercept = 95.3, lty=2, col="red") +
                geom_hline(yintercept = 84, lty=2, col="red") +
                geom_vline(xintercept=as.numeric(weight2$Date[71]), lty=2, col="red") +
                theme_bw() +
                scale_y_continuous(breaks = seq(82, 96),1) +
                ggtitle("Weight since DTS Greatest Loser Challenge started...\n") + 
                theme(plot.title = element_text(size = 18))
               
plot_wt


