#### Use this script to get count values from windows before a prompt in uEMA

#### Import libraries
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

#### read uEMA responses file
uEMAAllResponses <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", 
                             sep = ",", header = TRUE)

head(uEMAAllResponses)
nrow(uEMAAllResponses)

#### Filter the participant of interest. For participant 1, use uEMA01

uEMA01Responses <- uEMAAllResponses[uEMAAllResponses$USER_ID == "uema01@micropa_com",]
head(uEMA01Responses)
tail(uEMA01Responses)
nrow(uEMA01Responses)
