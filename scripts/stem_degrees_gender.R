library(ggplot2)
library(plyr)

STEM_degrees_gender <- read.delim("~/Box Sync/workshops_talks/Camas STEM girls day/STEM_degrees_gender.txt")
dat <- STEM_degrees_gender
rm(STEM_degrees_gender)

summary(dat)

levels(dat$subject) <- 
  c("Biological and \n Agricultural \n Sciences", 
    "Computer \n Science", 
    "Earth, \n Atmospheric,and \n Ocean Sciences",
    "Engineering", 
    "Mathematics", 
    "Physical \n Sciences", 
    "Social Sciences \n and Psychology", 
    "Statistics")

dat$subject <- ordered(dat$subject,
                       levels = c("Engineering", "Computer \n Science",
                                  "Earth, \n Atmospheric,and \n Ocean Sciences",
                                  "Physical \n Sciences",
                                  "Mathematics", 
                                  "Statistics",
                                  "Biological and \n Agricultural \n Sciences", 
                                  "Social Sciences \n and Psychology"
                       ))

levels(dat$gender)
#dat$gender <- ordered(dat$gender, levels = c("Women", "Men"))
dat$gender <- factor(dat$gender, levels = c("Women", "Men"))
levels(dat$gender)

ggplot(dat, aes(x=factor(year), y=Percent, fill=gender)) + 
  geom_bar(stat="identity", position="fill") +  #, aes(order=desc(Percent))
  facet_grid(.~ subject, scales="free_x", space="free") +
  xlab("Year") +
  scale_fill_discrete(name="Gender") +
  ggtitle("Gender Distribution of Bachelor's Degrees in Science and Engineering Disciplines")
