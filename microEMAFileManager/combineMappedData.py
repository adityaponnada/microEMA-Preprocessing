import pandas as pd
# from datetime import datetime
import datetime
import numpy as np
import glob,os
from copy import deepcopy


def mhealth_timestamp_parser(str):
    MHEALTH_TIMESTAMP_FORMAT = "%m/%d/%Y %H:%M:%S.%f"
    return datetime.datetime.strptime(str, MHEALTH_TIMESTAMP_FORMAT)

inPathLab = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/"

tenSecFile = "combinedData_10sec.csv" ## Use it when concatinating uEMA responses
thirtySecFile = "combinedData_30sec.csv" ## Use it when concatinating UndoResponse Files
sixtySecFile = "combinedData_60sec.csv" ## Use it when concatinating UndoResponse Files
##uEMAOutFile = "uEMAPromptResponses.csv" ## Use it when concatinating uEMA responses

outPathLab = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/CombinedData/"

count = 0

first = True
for path in glob.glob(os.path.join(inPathLab,"uema*/combinedData_10sec.csv")):
    #subNow=os.path.basename(path)
    #print(subNow)
    print('Reading ...' + path)

    # df = pd.read_csv(path, header=None, sep=',', compression="infer", quotechar='"', parse_dates=[3,4], date_parser=mhealth_timestamp_parser)
    try:
        print('before reading')
        df = pd.read_csv(path, header=0, sep=',', compression="infer", quotechar='"')
        print('done reading')
        if first:
            first = False
            relevant_df = df
        else:
            relevant_df = pd.concat([relevant_df, df], axis=0, join='outer', ignore_index=True)

    except:
        continue

relevant_df.columns = ['USER_ID','PROMPT_TIME','ANSWER_TIME','RESPONSE_TIME','ACTIVITY_TYPE','ACTIVITY_CODED','ACTIVITY_NUMERIC','COUNTS_SUM_ANKLE_BEFORE','COUNTS_SUM_ANKLE_AFTER','COUNTS_SUM_WRIST_BEFORE','COUNTS_SUM_WRIST_AFTER','TOTAL_ANKLE_COUNTS','TOTAL_WRIST_COUNTS']
relevant_df = relevant_df[['USER_ID','PROMPT_TIME','ANSWER_TIME','RESPONSE_TIME','ACTIVITY_TYPE','ACTIVITY_CODED','ACTIVITY_NUMERIC','COUNTS_SUM_ANKLE_BEFORE','COUNTS_SUM_ANKLE_AFTER','COUNTS_SUM_WRIST_BEFORE','COUNTS_SUM_WRIST_AFTER','TOTAL_ANKLE_COUNTS','TOTAL_WRIST_COUNTS']]
relevant_df.to_csv(os.path.join(outPathLab,"tenSecMappedData.csv"),index=False)


