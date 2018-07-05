library(psych)
library(MASS)
library(reshape2)
library(dplyr)
library(plyr)


labelPath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/SPADES_ACTIVITY_COUNT/AllLabCountsCombined.csv"


AllLabCounts <- read.csv(labelPath, sep = ",", header = TRUE)


#### Get counts per second
AllLabCounts$COUNTS_PER_SECOND <- AllLabCounts$ANKLE_COUNTS_ADDED/AllLabCounts$DURATION

AllLabCounts <- AllLabCounts[!AllLabCounts$DURATION == 0, ]

#### Club sedentary and light into one category
AllLabCounts$CATEGORY[AllLabCounts$CATEGORY == "Light/Standing"] <- "Sedentary"


#### get the average counts for wrist and ankle 10, 30, 60 seconds
### Get average of sedentary for 60, 30, 10 s
sedentaryLab <- AllLabCounts[AllLabCounts$CATEGORY == "Sedentary",]
summary(sedentaryLab)

### ANKLE_10 = 446.16, ANKLE_30 = 1338.5, ANKLE_60 = 2677.0
### WRIST_10 = 793.3, WRIST_30 = 2379.8, WRIST_60 = 4759.6

### Get average of sedentary for 60, 30, 10 s
# lightLab <- AllLabCounts[AllLabCounts$CATEGORY == "Light/Standing",]
# summary(lightLab)
# 
# ### ANKLE_10 = 505.75, ANKLE_30 = 1517.3, ANKLE_60 =  3035
# ### WRIST_10 = 1036.0, WRIST_30 = 3108.1, WRIST_60 = 6216

### Get average of sedentary for 60, 30, 10 s
modWalkLab <- AllLabCounts[AllLabCounts$CATEGORY == "Moderate/Walking",]
summary(modWalkLab)

### ANKLE_10 = 2390, ANKLE_30 = 7171, ANKLE_60 =  14341
### WRIST_10 = 1189.7, WRIST_30 = 3569, WRIST_60 = 7138

### Get average of sedentary for 60, 30, 10 s
vigorousLab <- AllLabCounts[AllLabCounts$CATEGORY == "Vigorous",]
summary(vigorousLab)

### ANKLE_10 = 2602, ANKLE_30 = 7805, ANKLE_60 =  15611
### WRIST_10 = 2975.8, WRIST_30 = 8927.3 , WRIST_60 = 17855