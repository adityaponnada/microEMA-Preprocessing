#### Use this script to get count values from windows before a prompt in uEMA

#### Import libraries
library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

# #### read uEMA responses file
# uEMAAllResponses <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/uEMAPromptResponses.csv", 
#                              sep = ",", header = TRUE)
# 
# head(uEMAAllResponses)
# nrow(uEMAAllResponses)
# 
# #### Filter the participant of interest. For participant 1, use uEMA01
# 
# uEMA01Responses <- uEMAAllResponses[uEMAAllResponses$USER_ID == "uema01@micropa_com",]
# head(uEMA01Responses)
# tail(uEMA01Responses)
# nrow(uEMA01Responses)
# 
# 
# #### Keep only relevant columns
# uEMA01Responses <- uEMA01Responses[, c("USER_ID", "PROMPT_TIME", "ANSWER_TIME", "RESPONSE_TIME", "ACTIVITY_TYPE")]
# head(uEMA01Responses)
# 
# #### Convert all the date time columns into date time objects
# uEMA01Responses$ANSWER_TIME <- as.POSIXct(uEMA01Responses$ANSWER_TIME, format = "%m/%d/%Y %H:%M:%OS")
# uEMA01Responses$PROMPT_TIME <- as.POSIXct(uEMA01Responses$PROMPT_TIME, format = "%m/%d/%Y %H:%M:%OS")
# class(uEMA01Responses$PROMPT_TIME)
# class(uEMA01Responses$ANSWER_TIME)
# 
# #### Filter a data frame with only responded prompts
# #uEMA01AnsweredPrompts <- uEMA01Responses[!uEMA01Responses$ACTIVITY_TYPE == "MISSED", ]
# #uEMA01AnsweredPrompts <- uEMA01Responses[!uEMA01Responses$ACTIVITY_TYPE == "DISMISSED", ]
# toMatch <- c("MISSED", "DISMISSED")
# uEMA01AnsweredPrompts <- uEMA01Responses[- grep(paste(toMatch,collapse="|"), 
#                                                 uEMA01Responses$ACTIVITY_TYPE),]
# 
# uEMA01AnsweredPrompts <- subset(uEMA01AnsweredPrompts, ANSWER_TIME < "2018-02-09 23:00:00")
# 
# head(uEMA01AnsweredPrompts)
# levels(uEMA01AnsweredPrompts$ACTIVITY_TYPE)

# #### read the actigraph counts file (1 sec epoch intervals): Ankle
# uEMA01AnkleCounts <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/ANKLE/YASEEN_ANKLE (2018-02-02)1secDataTable.csv", 
#                               sep = ",", header = TRUE)
# 
# head(uEMA01AnkleCounts)
# 
# #### Concatinate date time columns in date time object
# uEMA01AnkleCounts$DATE_TIME_ANKLE <- as.POSIXct(paste(uEMA01AnkleCounts$Date, uEMA01AnkleCounts$Time), 
#                                                    format = "%m/%d/%Y %H:%M:%S")
# 
# head(uEMA01AnkleCounts)
# 
# #### use only selected columns
# uEMA01AnkleCounts <- uEMA01AnkleCounts[, c("DATE_TIME_ANKLE", "Vector.Magnitude")]
# head(uEMA01AnkleCounts)
# 
# 
# #### rename these columns
# 
# colnames(uEMA01AnkleCounts)[2] <- "COUNTS_MAGNITUDE_ANKLE"
# head(uEMA01AnkleCounts)



# #### read the actigraph counts file (1 sec epoch intervaLS) :  Wrist
# 
# uEMA01WristCounts <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/VizDataCheck/uema01_activity/WRIST/YASEEN_WRIST (2018-02-02)1secDataTable.csv", 
#                               sep = ",", header = TRUE)
# 
# head(uEMA01WristCounts)
# 
# #### Concatinate date time columns in date time object
# uEMA01WristCounts$DATE_TIME_ANKLE <- as.POSIXct(paste(uEMA01WristCounts$Date, uEMA01WristCounts$Time), 
#                                                 format = "%m/%d/%Y %H:%M:%S")
# 
# head(uEMA01WristCounts)
# 
# #### use only selected columns
# uEMA01WristCounts <- uEMA01WristCounts[, c("DATE_TIME_ANKLE", "Vector.Magnitude")]
# head(uEMA01WristCounts)
# 
# 
# #### rename these columns
# 
# colnames(uEMA01WristCounts)[2] <- "COUNTS_MAGNITUDE_WRIST"
# head(uEMA01WristCounts)

#### get windowed avergaes from the time before the promt - Ankle
timeBefore = 60

combinedAnkleEMA <- uEMAParticipantAnsweredPrompts
combinedAnkleEMA$COUNTS_AVERAGE_ANKLE_BEFORE <- NA
#combinedAnkleEMA[1,]$COUNTS_AVERAGE_ANKLE_BEFORE <- 0


###################### Raw code ###################

k=0

for (i in 1:nrow(uEMAParticipantAnsweredPrompts)){
  print(paste0("Starting with the uEMA index: ", i))
  uEMAPickedRow <- uEMAParticipantAnsweredPrompts[i,]
  
  k = k+1
  
  if (k > nrow(uEMAAnkleCounts)){
    print("Maxed out in the second file ... exiting")
    break
    
  }
  print("creating a temporary data frame")
  tempDataFrame = data.frame()
  
  for (j in k:nrow(uEMAAnkleCounts)){
    print(paste0("Starting with the second file index: ", j, " and k is: ", k))
    
    countsPickedRow <- uEMAAnkleCounts[j,]
    
    timeDifference = difftime(uEMAPickedRow$PROMPT_TIME, countsPickedRow$DATE_TIME_ANKLE,   units = "secs")
    print(paste0("The time difference is: ", timeDifference))
    
    if (timeDifference <= timeBefore & timeDifference >= 0){
      
      print(paste0("Time difference is within the range at ", "j = ", j, " k = ", k, " for i = ", i))
      
      ## Add all these rows in a temporary data frame
      tempDataFrame <- rbind(tempDataFrame, countsPickedRow)
      print("Get average counts")
      
      countsSum = sum(tempDataFrame$COUNTS_MAGNITUDE_ANKLE)
      print("Assign average as a new column")
      
      print(paste0("CountsAverage is: ", countsSum))
      
      combinedAnkleEMA$COUNTS_AVERAGE_ANKLE_BEFORE[i] <- countsSum
      #tempAverages[i,] <- i
      k = j
     
      
    } else if (timeDifference < 0) {
      print("Time difference negative ... exiting")
      
      break
    }
    
    
  }
  
  print(paste0("i is: ", i))
  
}

#tempMicroEMA$COUNTS_AVERAGE_ANKLE_BEFORE <- tempAverages

head(combinedAnkleEMA)

#### get windows for wrist counts
#### get windowed avergaes from the time before the promt - Ankle
timeBefore = 60

combinedWristEMA <- uEMAParticipantAnsweredPrompts
combinedWristEMA$COUNTS_AVERAGE_WRIST_BEFORE <- NA
#combinedAnkleEMA[1,]$COUNTS_AVERAGE_ANKLE_BEFORE <- 0


###################### Raw code ###################

k=0

for (i in 1:nrow(uEMAParticipantAnsweredPrompts)){
  print(paste0("Starting with the uEMA index: ", i))
  uEMAPickedRow <- uEMAParticipantAnsweredPrompts[i,]
  
  k = k+1
  
  if (k > nrow(uEMAWristCounts)){
    print("Maxed out in the second file ... exiting")
    break
    
  }
  print("creating a temporary data frame")
  tempDataFrame = data.frame()
  
  for (j in k:nrow(uEMAWristCounts)){
    print(paste0("Starting with the second file index: ", j, " and k is: ", k))
    
    countsPickedRow <- uEMAWristCounts[j,]
    
    timeDifference = difftime(uEMAPickedRow$PROMPT_TIME, countsPickedRow$DATE_TIME_ANKLE,   units = "secs")
    print(paste0("The time difference is: ", timeDifference))
    
    if (timeDifference <= timeBefore & timeDifference >= 0){
      
      print(paste0("Time difference is within the range at ", "j = ", j, " k = ", k, " for i = ", i))
      
      ## Add all these rows in a temporary data frame
      tempDataFrame <- rbind(tempDataFrame, countsPickedRow)
      print("Get average counts")
      
      countsSum = sum(tempDataFrame$COUNTS_MAGNITUDE_WRIST)
      print("Assign average as a new column")
      
      print(paste0("CountsAverage is: ", countsSum))
      
      combinedWristEMA$COUNTS_AVERAGE_WRIST_BEFORE[i] <- countsSum
      #tempAverages[i,] <- i
      k = j
      
      
    } else if (timeDifference < 0) {
      print("Time difference negative ... exiting")
      
      break
    }
    
    
  }
  
  print(paste0("i is: ", i))
  
}

#tempMicroEMA$COUNTS_AVERAGE_ANKLE_BEFORE <- tempAverages

head(combinedWristEMA)




