import pandas as pd
# from datetime import datetime
import datetime
import numpy as np
import glob,os
from copy import deepcopy


def mhealth_timestamp_parser(str):
    MHEALTH_TIMESTAMP_FORMAT = "%m/%d/%Y %H:%M:%S.%f"
    return datetime.datetime.strptime(str, MHEALTH_TIMESTAMP_FORMAT)

inPath = "C:/Users/Dharam/Downloads/Wockets-win32-x64_updated_v1/Wockets-win32-x64/resources/app/src/srv/MICROPA/"

uEMAInFile = "Watch-PromptActivity.log.csv" ## Use it when concatinating uEMA responses
undoInFile = "Watch-UndoActionLogs.log.csv" ## Use it when concatinating UndoResponse Files
undoOutFile = "uEMAUndoResponses.csv" ## Use it when concatinating UndoResponse Files
uEMAOutFile = "uEMAPromptResponses.csv" ## Use it when concatinating uEMA responses

outPath = "C:/Users/Dharam/Downloads/microEMA/StudyFiles/Responses_uEMA"

count = 0

first = True
for path in glob.glob(os.path.join(inPath,"uema*@micropa_com/logs-watch/*/*/Watch-UndoActionLogs.log.csv")):
    #subNow=os.path.basename(path)
    #print(subNow)
    print('Reading ...' + path)

    # df = pd.read_csv(path, header=None, sep=',', compression="infer", quotechar='"', parse_dates=[3,4], date_parser=mhealth_timestamp_parser)
    try:
        df = pd.read_csv(path, header=None, sep=',', compression="infer", quotechar='"')
        if first:
            first = False
            relevant_df = df
        else:
            relevant_df = pd.concat([relevant_df, df], axis=0, join='outer', ignore_index=True)

    except:
        continue

relevant_df.columns = ['LOG_TIME','TYPE','USER_ID','PROMPT_TIME','ANSWER_TIME','RESPONSE_TIME','ACTIVITY_TYPE','PROMPT']
relevant_df = relevant_df[['LOG_TIME','TYPE','USER_ID','PROMPT_TIME','ANSWER_TIME','RESPONSE_TIME','ACTIVITY_TYPE','PROMPT']]
relevant_df.to_csv(os.path.join(outPath,"uEMAUndoResponses.csv"),index=False)


