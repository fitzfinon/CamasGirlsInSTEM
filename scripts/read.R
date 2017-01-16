setwd("~/CamasGirlsInSTEM/scripts")

library(checkpoint)
checkpoint("2017-01-01")

library(magrittr)
library(dplyr)
library(ggplot2)
library(knitr)
library(readxl)


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
         gender = factor(genderMale, labels = c("Female", "Male")),
         testCondition = factor(grepl("Closed", gsub("'", "", testCondition)), labels = c("Open", "Closed")),
         concussionHx = factor(concussionHx, labels = c("No history", "Concussion history")),
         contactSport = factor(contactSport, labels = c("Non-contact sport", "Contact sport"))) %>% 
  select(-matches("genderMale"))

