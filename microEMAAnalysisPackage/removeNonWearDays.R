#### remove non wear days for participant 2:

combinedFile <- combinedFile[!(combinedFile$USER_ID == "uema02@micropa_com" & ((combinedFile$PROMPT_TIME > as.POSIXct("2018-02-10 07:00:00") & combinedFile$PROMPT_TIME < as.POSIXct("2018-02-10 23:00:00")) | 
                                                                                 (combinedFile$PROMPT_TIME > as.POSIXct("2018-02-12 07:00:00") & combinedFile$PROMPT_TIME < as.POSIXct("2018-02-12 23:00:00")) |
                                                                                 (combinedFile$PROMPT_TIME > as.POSIXct("2018-02-22 07:00:00") & combinedFile$PROMPT_TIME < as.POSIXct("2018-02-22 23:00:00")))),]


combinedFile <- combinedFile[!(combinedFile$USER_ID == "uema06@micropa_com" & ((combinedFile$PROMPT_TIME > as.POSIXct("2018-02-24 00:00:00") & combinedFile$PROMPT_TIME < as.POSIXct("2018-02-24 10:00:00")))),]


