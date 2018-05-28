#### Include libraires

library(psych)
library(MASS)
library(ggplot2)
library(plotly)
library(reshape2)
library(dplyr)

#### Read summary file

uEMAResponseRate <- read.csv("C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA/ResponseSummary.csv", header = TRUE, sep = ",")

head(uEMAResponseRate)

### Remove NA entries
uEMAResponseRate <- na.omit(uEMAResponseRate)

names(uEMAResponseRate)

lapply(uEMAResponseRate, class)

#### Convert undo count to numeric
uEMAResponseRate$NO_UNDO <- as.numeric(uEMAResponseRate$NO_UNDO)
class(uEMAResponseRate$NO_UNDO)

describe(uEMAResponseRate)

#### Plot compliance boxplot
complianceSet <- c("USER_ID", "W1_COMPLIANCE", "TOTAL_COMPLIANCE")
subsetCompliance <- uEMAResponseRate[complianceSet]

#### Plot completion boxplot
completioneSet <- c("USER_ID", "W1_COMPLETION", "TOTAL_COMPLETION")
subsetCompletion <- uEMAResponseRate[completioneSet]

####Plot response time plot
responseRateSet <- c("USER_ID", "W1_RESPONSE_TIME", "TOTAL_RESPONSE_TIME")
subsetResponseTime <- uEMAResponseRate[responseRateSet]

### Melt the dataframes
meltCompliance <- melt(subsetCompliance, measure.vars=c("W1_COMPLIANCE","TOTAL_COMPLIANCE"))
meltCompletion <- melt(subsetCompletion, measure.vars=c("W1_COMPLETION","TOTAL_COMPLETION"))
meltResponseRate <- melt(subsetResponseTime, measure.vars=c("W1_RESPONSE_TIME","TOTAL_RESPONSE_TIME"))

compliancePlot <- ggplot(meltCompliance, aes(x=variable,y=value)) + 
  geom_boxplot()+
  ggtitle("Compliance rates (%)") +
  labs(x="Week 1 and four weeks",y="Response rate (%)")

completionPlot <- ggplot(meltCompletion, aes(x=variable,y=value)) + 
  geom_boxplot()+
  ggtitle("Completion rates (%)") +
  labs(x="Week 1 and four weeks",y="Response rate (%)")

responseTimePlot <- ggplot(meltResponseRate, aes(x=variable,y=value)) + 
  geom_boxplot()+
  ggtitle("Response time (sec)") +
  labs(x="Week 1 and four weeks",y="Time (s)")

### Get multiple plots

# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

multiplot(compliancePlot, completionPlot, responseTimePlot,cols=3)

