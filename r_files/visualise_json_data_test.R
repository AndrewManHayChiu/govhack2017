library(tidyjson)
library(jsonlite)
library(dplyr)
library(ggplot2)
library(rjson)

## Location of file
fileName <- "../data/anti-money-laundering-and-counter-terrorism-financing.json"

## Load json file into R
data <- read_json(fileName)

data

class(data)

attr(data, "JSON")

## Identify JSON structure with json_types()
data %>% json_types

## How many keys are there?
data %>% json_lengths()


## What keys are in the json file / object?
data %>% 
  gather_keys() %>%
  json_types

## There are:
## - schema
## - additionalProperties
## - type
## - description
## - definitions
## - properties

## How many objects are within each object?
data %>%
  gather_keys() %>%
  json_lengths()


## visually inspect a single record with jsonlite:prettify()
data %>% prettify

data %>%
  gather_keys %>%
  json_types %>%
  json_lengths


## Enter the properties (rules) object
data %>% 
  spread_values(properties = jstring("properties")) %>%
  enter_object("properties") %>%
  gather_keys %>%
  json_types %>%
  json_lengths

data %>% 
  spread_values(properties = jstring("properties")) %>%
  enter_object("properties") %>%
  spread_values(rule = jstring("FirstPersonAbnIsKnown")) %>%
  enter_object("FirstPersonAbnIsKnown") -> temp

# rjson -------------------------------------------------------------------

cat(toJSON(data))