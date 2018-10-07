### all_withoutimage
#raw data
all_withoutimage_raw <- read_csv("C:/Users/wolu0/Desktop/Documents/Allen/Pitt/Spring/BMIS2526 Practical Data Science with R/project/data/processsed/without image/all/all.csv", 
                                 col_types = cols(status_published = col_datetime(format = "%Y-%m-%d %H:%M:%S")))
dim(all_withoutimage_raw)

summary(all_withoutimage_raw)

#data exploration
library(readr)
library(tidyverse)
all_withoutimage <- read_csv("C:/Users/wolu0/Desktop/Documents/Allen/Pitt/Spring/BMIS2526 Practical Data Science with R/project/data/processsed/without image/all/all.csv", 
                             col_types = cols(status_published = col_datetime(format = "%Y-%m-%d %H:%M:%S")))
names(all_withoutimage) <- make.names(names(all_withoutimage))
all_withoutimage$X.U.FEFF.name

View(all_withoutimage)
dim(all_withoutimage)
names(all_withoutimage)
summary(all_withoutimage)
#null value
dim(na.omit(all_withoutimage))
nrow(all_withoutimage)-nrow(na.omit(all_withoutimage))

#datatime check
install.packages('lubridate')
library(lubridate)

all_withoutimage$mydate = as.POSIXlt(all_withoutimage$status_published)
all_withoutimage$year = year(all_withoutimage$mydate)
all_withoutimage$month = month(all_withoutimage$mydate)
all_withoutimage$day = day(all_withoutimage$mydate)
all_withoutimage$weekday = weekdays(all_withoutimage$status_published)
all_withoutimage$hour = all_withoutimage$mydate$hour
all_withoutimage$min = all_withoutimage$mydate$min
all_withoutimage$sec = all_withoutimage$mydate$sec
all_withoutimage$yday = all_withoutimage$mydate$yday

#############3clean data
summary(all_withoutimage)
#sentiment score<1 >-1
all_withoutimage <- all_withoutimage[which(all_withoutimage$sentiment_score>=-1 & all_withoutimage$sentiment_score <=1),]
#sentiment only postive and negtive
all_withoutimage <- subset(all_withoutimage, sentiment %in% c('positive','negative'))
#numerb of text
all_withoutimage <- all_withoutimage[which(all_withoutimage$text_characters> 0 & all_withoutimage$text_characters <=500),]
# num of special
all_withoutimage <- all_withoutimage[which(all_withoutimage$num_special>=0),]
#as. factor
all_withoutimage$sentiment <- as.factor(all_withoutimage$sentiment)
all_withoutimage$industry <- as.factor(all_withoutimage$industry)
all_withoutimage$year <- as.factor(all_withoutimage$year)
all_withoutimage$month <- as.factor(all_withoutimage$month)
all_withoutimage$day <- as.factor(all_withoutimage$day)
all_withoutimage$hour <- as.factor(all_withoutimage$hour)
all_withoutimage$min <- as.factor(all_withoutimage$min)
all_withoutimage$sec <- as.factor(all_withoutimage$sec)
all_withoutimage$yday <- as.factor(all_withoutimage$yday)
all_withoutimage$weekday <- as.factor(all_withoutimage$weekday)
all_withoutimage$X.U.FEFF.name <- as.factor(all_withoutimage$X.U.FEFF.name)


all_withoutimage_car <- filter(all_withoutimage, industry == 'car')
all_withoutimage_car
all_withoutimage_cosmetic <- subset(all_withoutimage, industry == 'cosmetic')
all_withoutimage_celebrity <- subset(all_withoutimage, industry == 'celebrity')
all_withoutimage_celebrity
all_withoutimage_bmw <- subset(all_withoutimage, X.U.FEFF.name == 'bmw')
all_withoutimage_bmw
all_withoutimage_adele <- subset(all_withoutimage, X.U.FEFF.name == 'adele')
all_withoutimage_ladygaga <- subset(all_withoutimage, X.U.FEFF.name == 'ladygaga')
all_withoutimage_lamer <- subset(all_withoutimage, X.U.FEFF.name == 'lamer')

all_withoutimage_ladygaga

summary(all_withoutimage)
levels(all_withoutimage$X.U.FEFF.name)


#data visualization
#import
library(ggplot2)
#   all_industry
c1 = c(9:11)
c2 = c(9,12:15)
c3 = c(9,16:18)
c4 = c(9,19,21)

pairs(all_withoutimage[,c1])
pairs(all_withoutimage[,c2])
pairs(all_withoutimage[,c3])
pairs(all_withoutimage[,c4])

# geo_point
ggplot(data = all_withoutimage,mapping = aes(x = num_reactions, y = num_shares,color = industry)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")
ggplot(data = all_withoutimage,mapping = aes(x = text_characters, y = num_reactions,color = industry)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")

#car
ggplot(data = all_withoutimage_car,mapping = aes(x = text_characters, y = num_reactions)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")
#cosmetic
ggplot(data = all_withoutimage_cosmetic,mapping = aes(x = text_characters, y = num_reactions)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")
ggplot(data = all_withoutimage_celebrity,mapping = aes(x = text_characters, y = num_reactions)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")
# bmw

ggplot(data = all_withoutimage_bmw,mapping = aes(x = num_reactions, y = num_shares)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")

ggplot(data = all_withoutimage_bmw,mapping = aes(x = num_reactions, y = num_comments)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")


# ladygaga
ggplot(data = all_withoutimage_ladygaga,mapping = aes(x = num_reactions, y = num_shares)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")

ggplot(data = all_withoutimage_ladygaga,mapping = aes(x = num_reactions, y = num_comments)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")

# lamer
ggplot(data = all_withoutimage_lamer,mapping = aes(x = num_reactions, y = num_shares)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")

ggplot(data = all_withoutimage_lamer,mapping = aes(x = num_reactions, y = num_comments)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")


############################################################################################################

ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = num_reactions, y = num_comments,color = industry))
ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = num_reactions, y = num_shares,color = industry))
ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = num_reactions, y = num_likes,color = industry))
ggplot(data = all_withoutimage,mapping = aes(x = num_reactions, y = num_angrys,color = industry)) + 
  geom_point()+
  geom_smooth(se = FALSE,method = "lm")+
  geom_smooth(se = FALSE,method = "glm")+
  geom_smooth(se = FALSE,method = "loess")
ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = num_reactions, y = num_special,color = industry))
ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = num_reactions, y = num_special,color = industry))
ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = num_reactions, y = text_characters,color = industry))
ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = sentiment, y = num_reactions,color = industry))
ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = sentiment_score, y =num_reactions ,color = industry))

ggplot(data = all_withoutimage) + 
  geom_point(mapping = aes(x = status_type, y = num_reactions,color = industry))

# select album to see
dim(subset(all_withoutimage,status_type == 'album'))

#bar
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x = industry, fill = status_type))
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x = status_type, fill = industry))
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x = text_characters, fill = industry))
ggplot(data = all_withoutimage) + 
  geom_histogram(mapping = aes(x = text_characters, fill = industry))
###text<500
ggplot(data = all_withoutimage[which(all_withoutimage$text_characters<=500),]) + 
  geom_histogram(mapping = aes(x = text_characters, fill = industry))
ggplot(data = all_withoutimage) + 
  geom_histogram(mapping = aes(x = num_reactions, fill = industry))
###reaction < 200000 >10
ggplot(data = all_withoutimage[which(all_withoutimage$num_reactions<=200000 & all_withoutimage$num_reactions>=1000),]) + 
  geom_histogram(mapping = aes(x = num_reactions, fill = industry))
ggplot(data = all_withoutimage[which(all_withoutimage$num_reactions<=200000 & all_withoutimage$num_reactions>=10000),]) + 
  geom_histogram(mapping = aes(x = num_reactions, fill = industry))

ggplot(data = all_withoutimage) + 
  geom_histogram(mapping = aes(x = sentiment_score, fill = industry,bins = 5))
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x = sentiment, fill = industry,bins = 5))
#### inddustry
# average
industry_summ_mean = summarise(group_by(all_withoutimage[,c(1:16)],industry),mean(num_reactions))
industry_summ_mean
ggplot(industry_summ_mean) +
  geom_col(mapping = aes(x = industry, y = `mean(num_reactions)` ), fill = 'orange')
#median
industry_summ_median = summarise(group_by(all_withoutimage[,c(1:16)],industry),median(num_reactions))
industry_summ_median
ggplot(industry_summ_median) +
  geom_col(mapping = aes(x = industry, y = `median(num_reactions)` ), fill = 'orange')

#status_type
#mean
status_type_summ_mean = summarise(group_by(all_withoutimage[,c(1:16)],status_type),mean(num_reactions))
ggplot(status_type_summ_mean) +
  geom_col(mapping = aes(x = status_type, y = `mean(num_reactions)` ), fill = 'orange')
# median
status_type_summ_median = summarise(group_by(all_withoutimage[,c(1:16)],status_type),median(num_reactions))
ggplot(status_type_summ_median) +
  geom_col(mapping = aes(x = status_type, y = `median(num_reactions)` ), fill = 'orange')
# sd
status_type_summ_sd = summarise(group_by(all_withoutimage[,c(1:16)],status_type),sd(num_reactions))
ggplot(status_type_summ_sd) +
  geom_col(mapping = aes(x = status_type, y = `sd(num_reactions)` ), fill = 'orange')




#box_plot
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = industry, y = num_reactions))
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = industry, y = text_characters))
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = industry, y = sentiment_score))
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = status_type, y = num_reactions))
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = status_type, y = text_characters))
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = status_type, y = sentiment_score))

ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = sentiment, y = num_reactions, color = industry))
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = sentiment, y = num_likes, color = industry))
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = sentiment, y = num_angrys, color = industry))

#pie
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x = industry, fill = status_type))+
  coord_polar(theta = "y")
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x = industry, fill = sentiment))+
  coord_polar(theta = "y")
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x = '', fill = industry))+
  coord_polar(theta = "y")
  


##########################time_series

#week days
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = weekday, y = num_reactions,color = industry))
#mean
weekday_summ_mean = summarise(group_by(all_withoutimage[,c(1:21,23:30)],weekday),mean(num_reactions))
ggplot(weekday_summ_mean) +
  geom_col(mapping = aes(x= reorder(weekday, -`mean(num_reactions)` ),y = `mean(num_reactions)`), fill = 'orange')
#median
weekday_summ_median = summarise(group_by(all_withoutimage[,c(1:21,23:30)],weekday),median(num_reactions))
ggplot(weekday_summ_median) +
  geom_col(mapping = aes(x= reorder(weekday, -`median(num_reactions)` ),y = `median(num_reactions)`), fill = 'orange')
#count
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x= reorder(weekday, rep(1,length(weekday)),sum),fill = industry))

#year
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = year, y = num_reactions,color = industry))
#mean
weekday_summ_mean = summarise(group_by(all_withoutimage[,c(1:21,23:30)],year),mean(num_reactions))
ggplot(weekday_summ_mean) +
  geom_col(mapping = aes(x= reorder(year, -`mean(num_reactions)` ),y = `mean(num_reactions)`), fill = 'orange')
#median
weekday_summ_median = summarise(group_by(all_withoutimage[,c(1:21,23:30)],year),median(num_reactions))
ggplot(weekday_summ_median) +
  geom_col(mapping = aes(x= reorder(year, -`median(num_reactions)` ),y = `median(num_reactions)`), fill = 'orange')
#count
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x= reorder(year, rep(1,length(year)),sum),fill = industry))

#month
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = month, y = num_reactions, color = industry))
#mean
weekday_summ_mean = summarise(group_by(all_withoutimage[,c(1:21,23:30)],month),mean(num_reactions))
ggplot(weekday_summ_mean) +
  geom_col(mapping = aes(x= reorder(month, -`mean(num_reactions)` ),y = `mean(num_reactions)`), fill = 'orange')
#median
weekday_summ_median = summarise(group_by(all_withoutimage[,c(1:21,23:30)],month),median(num_reactions))
ggplot(weekday_summ_median) +
  geom_col(mapping = aes(x= reorder(month, -`median(num_reactions)` ),y = `median(num_reactions)`), fill = 'orange')
#count
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x= reorder(month, rep(1,length(month)),sum),fill = industry))

#day
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = day, y = num_reactions))
#mean
weekday_summ_mean = summarise(group_by(all_withoutimage[,c(1:21,23:30)],day),mean(num_reactions))
ggplot(weekday_summ_mean) +
  geom_col(mapping = aes(x= day,y = `mean(num_reactions)`), fill = 'orange')
#median
weekday_summ_median = summarise(group_by(all_withoutimage[,c(1:21,23:30)],day),median(num_reactions))
ggplot(weekday_summ_median) +
  geom_col(mapping = aes(x= day,y = `median(num_reactions)`), fill = 'orange')
#count
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x= day,fill = industry))

#yday
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = yday, y = num_reactions))
#mean
weekday_summ_mean = summarise(group_by(all_withoutimage[,c(1:21,23:30)],yday),mean(num_reactions))
ggplot(weekday_summ_mean) +
  geom_col(mapping = aes(x= yday,y = `mean(num_reactions)`), fill = 'orange')
#median
weekday_summ_median = summarise(group_by(all_withoutimage[,c(1:21,23:30)],yday),median(num_reactions))
ggplot(weekday_summ_median) +
  geom_col(mapping = aes(x= yday,y = `median(num_reactions)`), fill = 'orange')
#count
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x= yday,fill = industry))

#hour
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = hour, y = num_reactions))
#mean
weekday_summ_mean = summarise(group_by(all_withoutimage[,c(1:21,23:30)],hour),mean(num_reactions))
ggplot(weekday_summ_mean) +
  geom_col(mapping = aes(x= hour,y = `mean(num_reactions)`), fill = 'orange')
#median
weekday_summ_median = summarise(group_by(all_withoutimage[,c(1:21,23:30)],hour),median(num_reactions))
ggplot(weekday_summ_median) +
  geom_col(mapping = aes(x= hour,y = `median(num_reactions)`), fill = 'orange')
#count
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x= hour,fill = industry))

#min
ggplot(data = all_withoutimage) + 
  geom_boxplot(mapping = aes(x = min, y = num_reactions))
#mean
weekday_summ_mean = summarise(group_by(all_withoutimage[,c(1:21,23:30)],min),mean(num_reactions))
ggplot(weekday_summ_mean) +
  geom_col(mapping = aes(x= min,y = `mean(num_reactions)`), fill = 'orange')
#median
weekday_summ_median = summarise(group_by(all_withoutimage[,c(1:21,23:30)],min),median(num_reactions))
ggplot(weekday_summ_median) +
  geom_col(mapping = aes(x= min,y = `median(num_reactions)`), fill = 'orange')
#count
ggplot(data = all_withoutimage) + 
  geom_bar(mapping = aes(x= min,fill = industry))


#####lm-time
lm.fit.time= lm(num_reactions~., data = all_withoutimage[,c(9,23:30)])
summary(lm.fit.time)
mse_time = mean((all_withoutimage$num_reactions-predict(lm.fit.time,all_withoutimage))^2)
plot(all_withoutimage$num_reactions, predict(lm.fit.time))
par(mfrow=c(2,2))
plot(lm.fit.time)
####lm-num stuff
lm.fit.num= lm(num_reactions~., data = all_withoutimage[,c(9:18)])
summary(lm.fit.num)
mse_num = mean((all_withoutimage$num_reactions-predict(lm.fit.num,all_withoutimage))^2)
plot(all_withoutimage$num_reactions, predict(lm.fit.num))
plot(lm.fit.num)

####lm-text-content
lm.fit.text= lm(num_reactions~., data = all_withoutimage[,c(9,19:21)])
summary(lm.fit.text)
mse_text = mean((all_withoutimage$num_reactions-predict(lm.fit.text,all_withoutimage))^2)
plot(all_withoutimage$num_reactions, predict(lm.fit.text))
plot(lm.fit.text)

####lm-type and industry
lm.fit.type= lm(num_reactions~., data = all_withoutimage[,c(9,1,6)])
summary(lm.fit.type)
mse_type = mean((all_withoutimage$num_reactions-predict(lm.fit.type,all_withoutimage))^2)
plot(all_withoutimage$num_reactions, predict(lm.fit.type))
plot(lm.fit.type)

####lm-all
lm.fit.all= lm(num_reactions~., data = all_withoutimage[,c(9,1:2,6,10:21,23:30)])
summary(lm.fit.all)
mse_all = mean((all_withoutimage$num_reactions-predict(lm.fit.all,all_withoutimage))^2)
plot(all_withoutimage$num_reactions, predict(lm.fit.all))
par(mfrow=c(2,2))
plot(lm.fit.all)

?data.frame
td = data.frame(name= c('time','num','text','type and industry','all'), mse =c(mse_time,mse_num,mse_text,mse_type,mse_all))

ggplot(data = td) + 
  geom_col(mapping = aes(x= name,y = mse),fill = 'light green')

           