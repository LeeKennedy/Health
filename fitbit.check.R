#devtools::install_github("corynissen/fitbitScraper")  
library("fitbitScraper")
# just reading from file to hide pw and to make .Rmd document to work...
mypassword <- as.character("1yKVO7HW6TJL")
cookie <- login(email="mail@leekennedy.id.au", password="1yKVO7HW6TJL") 
df <- get_15_min_data(cookie, what="steps", date="2015-02-01")  
library("ggplot2")  
ggplot(df) + geom_bar(aes(x=time, y=data, fill=data), stat="identity") + 
        xlab("") +ylab("steps") + 
        theme(axis.ticks.x=element_blank(), 
              panel.grid.major.x = element_blank(), 
              panel.grid.minor.x = element_blank(), 
              panel.grid.minor.y = element_blank(), 
              panel.background=element_blank(), 
              panel.grid.major.y=element_line(colour="gray", size=.1), 
              legend.position="none") 

#### Daily Data -------------------------------------------------
df <- get_daily_data(cookie, what="steps", start_date="2015-01-01", end_date="2015-01-31")  
library("ggplot2")  
ggplot(df) + geom_bar(aes(x=time, y=data), stat="identity") + 
        xlab("") +ylab("steps") + 
        theme(axis.ticks.x=element_blank(), 
              panel.grid.major.x = element_blank(), 
              panel.grid.minor.x = element_blank(), 
              panel.grid.minor.y = element_blank(), 
              panel.background=element_blank(), 
              panel.grid.major.y=element_line(colour="gray", size=.1), 
              legend.position="none") 