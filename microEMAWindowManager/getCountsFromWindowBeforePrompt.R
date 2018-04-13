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


#### Keep only relevant columns
uEMA01Responses <- uEMA01Responses[, c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE")]
head(uEMA01Responses)

#### Convert all the date time columns into date time objects
uEMA01Responses$ANSWER_TIME <- as.POSIXct(uEMA01Responses$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
uEMA01Responses$PROMPT_TIME <- as.POSIXct(uEMA01Responses$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")
class(uEMA01Responses$PROMPT_TIME)
class(uEMA01Responses$ANSWER_TIME)

#### Filter a data frame with only responded prompts
uEMA01AnsweredPrompts <- uEMA01Responses[!uEMA01Responses$ACTIVITY_TYPE == "MISSED", ]
uEMA01AnsweredPrompts <- uEMA01Responses[!uEMA01Responses$ACTIVITY_TYPE == "DISMISSED", ]
head(uEMA01AnsweredPrompts)
levels(uEMA01AnsweredPrompts$ACTIVITY_TYPE)
