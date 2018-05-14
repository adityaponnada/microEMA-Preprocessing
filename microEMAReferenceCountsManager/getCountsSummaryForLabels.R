#### Include library

library(psych)
library(MASS)
library(ggplot2)
library(plotly)

countsInWindows = 0
annotationFile$ANKLE_COUNTS_ADDED <- NA
annotationFile$TOTAL_ROWS_TEMP <- NA
flag = 0



for (i in 1:nrow(annotationFile)){
  print(paste0("At the annotation number: ", i))
  
  tempSpadesFrame <- spadesAnkle[spadesAnkle$DATE_TIME_ANKLE >= annotationFile$HEADER_START_TIME[i] & 
                                   spadesAnkle$DATE_TIME_ANKLE <= annotationFile$HEADER_STOP_TIME[i],]
  
  countsInWindows = sum(tempSpadesFrame$Vector.Magnitude)
  
  print(paste0("Total counts found: ", countsInWindows))
  
  annotationFile$ANKLE_COUNTS_ADDED[i] <- countsInWindows
  annotationFile$TOTAL_ROWS_TEMP[i] <- nrow(tempSpadesFrame)
  
  print("Counts have been added")
  
}


head(annotationFile)

outPathSummary = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/SPADES_ACTIVITY_COUNT/SPADES_1/LabCountsCombined.csv"

write.csv(file = outPathSummary, x = annotationFile, quote = FALSE, row.names = FALSE, col.names = TRUE, sep = ",")
