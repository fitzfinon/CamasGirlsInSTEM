library(ggplot2)
library(plyr)
library(magrittr)
library(dplyr)

STEM_degrees_gender <- read.delim("~/Box Sync/workshops_talks/Camas STEM girls day/STEM_degrees_gender.txt")
dat <- STEM_degrees_gender
rm(STEM_degrees_gender)

summary(dat)

levels(dat$subject) <- 
  c("Biological and\nAgricultural\nSciences", 
    "Computer\nScience", 
    "Earth,\nAtmospheric,\nOcean Sciences",
    "Engineering", 
    "Mathematics", 
    "Physical\nSciences", 
    "Social Sciences,\nPsychology", 
    "Statistics")

dat$subject <- ordered(dat$subject,
                       levels = c("Engineering", "Computer\nScience",
                                  "Earth,\nAtmospheric,\nOcean Sciences",
                                  "Physical\nSciences",
                                  "Mathematics", 
                                  "Statistics",
                                  "Biological and\nAgricultural\nSciences", 
                                  "Social Sciences,\nPsychology"
                       ))

levels(dat$gender)
#dat$gender <- ordered(dat$gender, levels = c("Women", "Men"))
dat$gender <- factor(dat$gender, levels = c("Women", "Men"))
levels(dat$gender)


G <-
  ggplot(dat %>% filter(gender == "Women"), aes(x=factor(year), y=Percent, fill=factor(year))) + 
  geom_bar(stat="identity") +  #, aes(order=desc(Percent)) +
  facet_grid(.~ subject, scales="free_x", space="free") +
  scale_fill_brewer("Year", palette = "Set1") +
  scale_y_continuous(breaks = seq(0, 100, 10)) +
  ggtitle("Percentage of Women with Bachelor Degrees\nin Science and Engineering Disciplines") +
  labs(x = NULL) +
  theme_bw() + theme(legend.position = "none")
G
ggsave("~/Projects/CamasGirlsInSTEM/figures/stem_degrees_women.svg", dpi = 300, width = 12, height = 8, units = "in")
