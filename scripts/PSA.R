library(ProjectTemplate)
load.project()

cholesterol <- read_excel("rawdata/Healthcheck.xlsx", sheet=3)

cholesterol <- na.omit(cholesterol[,c(1,2,4,5)])

chol_long <- gather(data=cholesterol,key=Type,value=Level,na.rm=FALSE,Chol,HDL,LDL)

chol_plot <- ggplot(chol_long, aes(x=Date, y = Level, group = Type, fill = Type)) +
        geom_point(size = 4, shape = 21, colour = "black") +
        geom_line(lwd = 1, aes(colour = Type)) +
        labs(title = "Cholesterol\n")
chol_plot