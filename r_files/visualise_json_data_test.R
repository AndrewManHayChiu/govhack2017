library(tidyjson)
library(dplyr)
library(ggplot2)

## Location of file
fileName <- "../data/anti-money-laundering-and-counter-terrorism-financing.json"

## Load json file into R
data <- read_json(fileName)

