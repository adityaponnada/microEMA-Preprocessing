## Import libraries

library(psych)
library(ggplot2)
library(plotly)
library(MASS)
library(plyr)
options(digits.secs=3)

head(combinedAnkleEMA)
head(combinedWristEMA)


###### get counts after a certain period from uEMA time stamp - Ankle ######

timeAfter = 60
combinedAnkleEMA$COUNTS_SUM_ANKLE_AFTER <- NA

# tempMicroEMA <- head(combinedAnkleEMA, 10)
# tempCounts <- head(uEMA01AnkleCounts, 6000)

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
    
    timeDifference = difftime(countsPickedRow$DATE_TIME_ANKLE, uEMAPickedRow$PROMPT_TIME, units = "secs")
    print(paste0("The time difference is: ", timeDifference))
    
    if (timeDifference <= timeAfter & timeDifference >= 0){
      
      print(paste0("Time difference is within the range at ", "j = ", j, " k = ", k, " for i = ", i))
      
      ## Add all these rows in a temporary data frame
      tempDataFrame <- rbind(tempDataFrame, countsPickedRow)
      print("Get average counts")
      
      countsSum = sum(tempDataFrame$COUNTS_MAGNITUDE_ANKLE)
      print("Assign average as a new column")
      
      print(paste0("CountsAverage is: ", countsSum))
      
      combinedAnkleEMA$COUNTS_SUM_ANKLE_AFTER[i] <- countsSum
      #tempAverages[i,] <- i
      k = j
      
      
    } else if (timeDifference > timeAfter) {
      print("Time difference exceeding the range ... exiting")
      
      break
    }
    
    
  }
  
  print(paste0("i is: ", i))
  
}

#combinedAnkleEMA#tempMicroEMA$COUNTS_AVERAGE_ANKLE_BEFORE <- tempAverages

head(combinedAnkleEMA)




##### get counts after a certain period from uEMA time stamp - Wrist ####

timeAfter = 60
combinedWristEMA$COUNTS_SUM_WRIST_AFTER <- NA

# tempMicroEMA <- head(combinedAnkleEMA, 10)
# tempCounts <- head(uEMA01AnkleCounts, 6000)

# k=0
# 
# for (i in 1:nrow(uEMAParticipantAnsweredPrompts)){
#   print(paste0("Starting with the uEMA index: ", i))
#   uEMAPickedRow <- uEMAParticipantAnsweredPrompts[i,]
# 
#   k = k+1
# 
#   if (k > nrow(uEMAWristCounts)){
#     print("Maxed out in the second file ... exiting")
#     break
# 
#   }
#   print("creating a temporary data frame")
#   tempDataFrame = data.frame()
# 
#   for (j in k:nrow(uEMAWristCounts)){
#     print(paste0("Starting with the second file index: ", j, " and k is: ", k))
# 
#     countsPickedRow <- uEMAWristCounts[j,]
# 
#     timeDifference = difftime(countsPickedRow$DATE_TIME_ANKLE, uEMAPickedRow$PROMPT_TIME, units = "secs")
#     print(paste0("The time difference is: ", timeDifference))
# 
#     if (timeDifference <= timeAfter & timeDifference >= 0){
# 
#       print(paste0("Time difference is within the range at ", "j = ", j, " k = ", k, " for i = ", i))
# 
#       ## Add all these rows in a temporary data frame
#       tempDataFrame <- rbind(tempDataFrame, countsPickedRow)
#       print("Get average counts")
# 
#       countsSum = sum(tempDataFrame$COUNTS_MAGNITUDE_WRIST)
#       print("Assign average as a new column")
# 
#       print(paste0("CountsAverage is: ", countsSum))
# 
#       combinedWristEMA$COUNTS_SUM_WRIST_AFTER[i] <- countsSum
#       #tempAverages[i,] <- i
#       k = j
# 
# 
#     } else if (timeDifference > timeAfter) {
#       print("Time difference exceeding the range ... exiting")
# 
#       break
#     }
# 
# 
#   }
# 
#   print(paste0("i is: ", i))
# 
# }

#tempMicroEMA$COUNTS_AVERAGE_ANKLE_BEFORE <- tempAverages

head(combinedWristEMA)
