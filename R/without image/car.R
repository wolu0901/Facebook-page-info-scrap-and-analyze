##########3for industries

###car
library(readr)
library(tidyverse)
all_withoutimage_car <- read_csv("C:/Users/wolu0/Desktop/Documents/Allen/Pitt/Spring/BMIS2526 Practical Data Science with R/project/data/processsed/without image/all/car.csv", 
                                 col_types = cols(status_published = col_datetime(format = "%Y-%m-%d %H:%M:%S")))
names(all_withoutimage_car) <- make.names(names(all_withoutimage_car))
#############3clean data

#sentiment score<1 >-1
all_withoutimage_car <- all_withoutimage_car[which(all_withoutimage_car$sentiment_score>=-1 & all_withoutimage_car$sentiment_score <=1),]
#sentiment only postive and negtive
all_withoutimage_car <- subset(all_withoutimage_car, sentiment %in% c('positive','negative'))
# num of special
all_withoutimage_car <- all_withoutimage_car[which(all_withoutimage_car$num_special>=0),]
all_withoutimage_car$sentiment <- as.factor(all_withoutimage_car$sentiment)
names(all_withoutimage_car)
library(ggplot2)
#   all_industry
c1 = c(8:10)
c2 = c(8,11:14)
c3 = c(8,15:17)
c4 = c(8,18:20)

pairs(all_withoutimage_car[,c1])
pairs(all_withoutimage_car[,c2])
pairs(all_withoutimage_car[,c3])
pairs(all_withoutimage_car[,c4])
