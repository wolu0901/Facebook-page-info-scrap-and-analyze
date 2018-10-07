# -*- coding: utf-8 -*-
"""
Created on Sun Apr  1 14:05:35 2018

@author: wolu0
"""
import csv
import os
import time
import json
from watson_developer_cloud import NaturalLanguageUnderstandingV1
from watson_developer_cloud.natural_language_understanding_v1 \
import Features, EntitiesOptions, KeywordsOptions,CategoriesOptions,ConceptsOptions,SentimentOptions,EmotionOptions

addition_title = ['text_characters','sentiment','sentiment_score']
path = r'C:\Users\wolu0\Desktop\Documents\Allen\Pitt\Spring\BMIS2526 Practical Data Science with R\project\爬虫\python\data - Copy'
filenames = ['bmw_facebook_statuses.csv','cadillac_facebook_statuses.csv','hyundai_facebook_statuses.csv']

if path!='':
    files= os.listdir(path)
    filenames = []
    for file in files:
        file = path + '\\' + file    
        for i in os.listdir(file):
            filenames.append(file+'\\'+i)

def read_csv(file):
    global results
    results = []
    global raw_csv_texts
    raw_csv_texts = []
    global raw_csv_information
    raw_csv_information = []
    with open(file,'r',encoding='utf_8',newline='') as file:
        r = csv.reader(file)
        title = next(r)+addition_title
        results.append(title)
        for row in r:
            raw_csv_texts.append(row[1])
            raw_csv_information.append(row)
    return raw_csv_texts


def nlp_ibm(text):
    natural_language_understanding = NaturalLanguageUnderstandingV1(
      username='*',
      password='*',
      version='2018-03-16')

    if text:
        try:
            responses = natural_language_understanding.analyze( 
                      text=text,
                      return_analyzed_text = False,
                      features=Features(
                          categories=CategoriesOptions(),
                          concepts=ConceptsOptions(
                           limit=1),
                          emotion=EmotionOptions(
                             ),
                      sentiment=SentimentOptions(
                             )
                          )
                        )
            response = [responses["usage"]["text_characters"],responses["sentiment"]["document"]["label"],responses["sentiment"]["document"]["score"]]
        except Exception as e:
              print(e)
              response = []
    else:
        response = []
    return response

    
    
if __name__ == '__main__':
    #test_texts = ['hello, world','abc abc abc abc','i will be back home at ten']
    start0 = time.time()
    for filename in filenames:
        start1 = time.time()
        print('start woring on',filename)
    
        raw_csv_texts = read_csv(filename)
        
        with open(filename,'r+',encoding='utf_8',newline='') as file:
            w = csv.writer(file)
            w.writerow(results[0])
            for i in range(len(raw_csv_texts)):
                ibm_processed = nlp_ibm(raw_csv_texts[i])
                result =  raw_csv_information[i]+ibm_processed
                #print(result)
                w.writerow(result)
        t = time.time()-start1
        print('working on',filename,'for %0.2f'%t)
    t_total = time.time()-start0
    print('total time = ',t_total)
        

    
    
        

    
    

    

        
        
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

