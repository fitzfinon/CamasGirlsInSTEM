setwd("~/Projects/CamasGirlsInSTEM/scripts")

library(checkpoint)
checkpoint("2017-01-01", use.knitr = TRUE)

library(magrittr)
library(dplyr)
library(ggplot2)
library(knitr)
library(readxl)


setwd("../data/raw/CensusAtSchool")
f <- list.files()[1]
file.info(f)
df <- read.csv(f)
str(df)
summary(df)


setwd("../data/raw/")
f <- grep("^results.*xlsx", list.files(), value = TRUE)
file.info(f)
df <- read_excel(f)
names(df) <- c("group", "id",
               "concussionHx", "contactSport", "sport",
               "age", "genderMale", "height", "mass",
               "testCondition", "conditionNum", "swayArea",
               "meanVelocityAP", "meanVelocity", "meanVelocityML")
df <-
  df %>% 
  filter(!is.na(id)) %>% 
  mutate(sport = factor(sport),
         gender = ifelse(genderMale == 1, "Male", "Female"),
         testCondition = gsub("'", "", testCondition) %>% factor,
         eyes = ifelse(grepl("Closed", testCondition), "Closed", "Open") %>% factor)
summary(df)
df %>% 
  ggplot + aes(x = swayArea, fill = gender) +
  geom_histogram(alpha = 1/2, bins = 20) +
  facet_wrap(~ gender, ncol = 1) +
  scale_fill_brewer(palette = "Set1") +
  scale_x_continuous("Sway area (m^2 / s^4)") +
  scale_y_continuous("Frequency") +
  theme(legend.position = "none")
