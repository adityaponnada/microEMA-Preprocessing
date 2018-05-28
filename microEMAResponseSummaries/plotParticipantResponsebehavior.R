#### Include libraires

library(psych)
library(MASS)
library(ggplot2)
library(plotly)
library(reshape2)
library(dplyr)

#### Plot stacked histograms of response rates

RRSet <- c("USER_ID", "W1_COMPLIANCE", "TOTAL_COMPLIANCE", "W1_COMPLETION", "TOTAL_COMPLETION")
uEMARRSubset <- uEMAResponseRate[RRSet]

meltRRDataFrame <- melt(uEMARRSubset)

ggplot(meltRRDataFrame, aes(x = USER_ID, y = value, fill = variable)) +
  geom_bar(stat = "identity", position = "dodge")+ 
  ggtitle("Response summary of all participants") +
  labs(x="Participants",y="Response rate (%)")
