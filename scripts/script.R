setwd("~/Projects/CamasGirlsInSTEM/scripts")

library(checkpoint)
checkpoint("2017-01-01", use.knitr = TRUE)

library(magrittr)
library(dplyr)
library(ggplot2)
library(knitr)

setwd("../data/raw/CensusAtSchool")
f <- list.files()[1]
file.info(f)
df <- read.csv(f)
str(df)
summary(df)
