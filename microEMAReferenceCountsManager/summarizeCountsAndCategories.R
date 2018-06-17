#### Include library

library(psych)
library(MASS)
library(ggplot2)
library(plotly)

#### Simple box plot for 60, 10, 30 s Ankle and wrist count

countsAnkle10sec <- plot_ly(AllLabCounts, x=~CATEGORY, y=~ANKLE_10, type = "box",name = "ANKLE_COUNTS_10s", 
                            legendgroup = "ANKLE")
countsAnkle30sec <- plot_ly(AllLabCounts, x=~CATEGORY, y=~ANKLE_30, type = "box",name = "ANKLE_COUNTS_30s", 
                            legendgroup = "ANKLE")
countsAnkle60sec <- plot_ly(AllLabCounts, x=~CATEGORY, y=~ANKLE_60, type = "box",name = "ANKLE_COUNTS_60s", 
                            legendgroup = "ANKLE")

# countsWrist10sec <- plot_ly(AllLabCounts, x=~CATEGORY, y=~WRIST_10, type = "box", name = "WRIST_COUNTS_10s", 
#                             legendgroup = "WRIST")
# countsWrist30sec <- plot_ly(AllLabCounts, x=~CATEGORY, y=~WRIST_30, type = "box", name = "WRIST_COUNTS_30s", 
#                             legendgroup = "WRIST")
# countsWrist60sec <- plot_ly(AllLabCounts, x=~CATEGORY, y=~WRIST_60, type = "box", name = "WRIST_COUNTS_60s", 
#                             legendgroup = "WRIST")

# subplot(style(countsAnkle10sec, showlegend = TRUE), style(countsAnkle30sec, showlegend = TRUE),
#         style(countsAnkle60sec, showlegend = TRUE),
#         style(countsWrist10sec, showlegend = TRUE),style(countsWrist30sec, showlegend = TRUE),
#         style(countsWrist60sec, showlegend = TRUE), nrows = 2, margin = 0.05, shareX = TRUE)





#### Ankle set 10
aovAnkle10 <- aov(ANKLE_10~CATEGORY, data = AllLabCounts)
summary(aovAnkle10)

postHocAnkle10 <- TukeyHSD(x=aovAnkle10, 'CATEGORY', conf.level = 0.95)
postHocAnkle10

#### Ankle set 30
aovAnkle30 <- aov(ANKLE_30~CATEGORY, data = AllLabCounts)
summary(aovAnkle30)

postHocAnkle30 <- TukeyHSD(x=aovAnkle30, 'CATEGORY', conf.level = 0.95)
postHocAnkle30

#### Ankle set 60
aovAnkle60 <- aov(ANKLE_60~CATEGORY, data = AllLabCounts)
summary(aovAnkle30)

postHocAnkle60 <- TukeyHSD(x=aovAnkle60, 'CATEGORY', conf.level = 0.95)
postHocAnkle60

#### Ankle set 150
aovAnkle150 <- aov(ANKLE_150~CATEGORY, data = AllLabCounts)
summary(aovAnkle150)

postHocAnkle150 <- TukeyHSD(x=aovAnkle150, 'CATEGORY', conf.level = 0.95)
postHocAnkle150

#### Ankle set 300
aovAnkle300 <- aov(ANKLE_300~CATEGORY, data = AllLabCounts)
summary(aovAnkle300)

postHocAnkle300 <- TukeyHSD(x=aovAnkle300, 'CATEGORY', conf.level = 0.95)
postHocAnkle300



#### Note: All cases are in order


# #### Wrist set 10
# aovWrist10 <- aov(WRIST_10~CATEGORY, data = AllLabCounts)
# summary(aovWrist10)
# 
# postHocWrist10 <- TukeyHSD(x=aovWrist10, 'CATEGORY', conf.level = 0.95)
# postHocWrist10
# 
# #### Wrist set 30
# aovWrist30 <- aov(WRIST_30~CATEGORY, data = AllLabCounts)
# summary(aovWrist30)
# 
# postHocWrist30 <- TukeyHSD(x=aovWrist30, 'CATEGORY', conf.level = 0.95)
# postHocWrist30
# 
# #### Wrist set 60
# aovWrist60 <- aov(WRIST_60~CATEGORY, data = AllLabCounts)
# summary(aovWrist60)
# 
# postHocWrist60 <- TukeyHSD(x=aovWrist60, 'CATEGORY', conf.level = 0.95)
# postHocWrist60

#### Note: All cases are in order


#### get the average counts for wrist and ankle 10, 30, 60 seconds
### Get average of sedentary for 60, 30, 10 s
sedentaryLab <- AllLabCounts[AllLabCounts$CATEGORY == "Sedentary",]
summary(sedentaryLab)

### ANKLE_10 = 446.16, ANKLE_30 = 1338.5, ANKLE_60 = 2677.0
### WRIST_10 = 793.3, WRIST_30 = 2379.8, WRIST_60 = 4759.6

### Get average of sedentary for 60, 30, 10 s
lightLab <- AllLabCounts[AllLabCounts$CATEGORY == "Light/Standing",]
summary(lightLab)

### ANKLE_10 = 505.75, ANKLE_30 = 1517.3, ANKLE_60 =  3035
### WRIST_10 = 1036.0, WRIST_30 = 3108.1, WRIST_60 = 6216

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


