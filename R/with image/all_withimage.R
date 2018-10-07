library(readr)
library(tidyverse)
all_withimage <- read_csv("C:/Users/wolu0/Desktop/Documents/Allen/Pitt/Spring/BMIS2526 Practical Data Science with R/project/data/processsed/with image/all/all.csv", 
                             col_types = cols(status_published = col_datetime(format = "%Y-%m-%d %H:%M:%S")))
View(all_withimage)
summary(all_withimage)
names(all_withimage)

all_withimage <- all_withimage[which(all_withimage$tg>0 & all_withimage$tb>0 & all_withimage$tr>0 & all_withimage$fraction>0),]
dim(all_withimage)

# as.factor
all_withimage$faces <- as.factor(all_withimage$faces)
all_withimage$logo <- as.factor(all_withimage$logo)
#data visualization
#import
library(ggplot2)
c_image1 = c(9,23:26)
c_image2 = c(9,27:29)

pairs(all_withimage[,c_image1])
pairs(all_withimage[,c_image2])


ggplot(data = all_withimage) + 
  geom_histogram(mapping = aes(x = tr, fill = industry))
ggplot(data = all_withimage) + 
  geom_histogram(mapping = aes(x = tg, fill = industry))
ggplot(data = all_withimage) + 
  geom_histogram(mapping = aes(x = tb, fill = industry))
ggplot(data = all_withimage) + 
  geom_histogram(mapping = aes(x = fraction, fill = industry))

ggplot(data = all_withimage) + 
  geom_boxplot(mapping = aes(x = industry, y = tr))
ggplot(data = all_withimage) + 
  geom_boxplot(mapping = aes(x = industry, y = tb))
ggplot(data = all_withimage) + 
  geom_boxplot(mapping = aes(x = industry, y = tg))
ggplot(data = all_withimage) + 
  geom_boxplot(mapping = aes(x = industry, y = fraction))

###rnum_reaction
ggplot(data = all_withimage) + 
  geom_boxplot(mapping = aes(x = faces, y = num_reactions,color = industry))
ggplot(data = all_withimage) + 
  geom_boxplot(mapping = aes(x = logo, y = num_reactions,color = industry))

### angry
all_withimage_angry <- all_withimage[which(all_withimage$num_angrys>10),]
ggplot(data = all_withimage) + 
  geom_histogram(mapping = aes(x = num_angrys, fill = industry))
all_withimage_like <- all_withimage[which(all_withimage$num_likes>10),]
ggplot(data = all_withimage_like) + 
  geom_histogram(mapping = aes(x = num_likes, fill = industry))
all_withimage_haha <- all_withimage[which(all_withimage$num_hahas>10),]
ggplot(data = all_withimage_haha) + 
  geom_histogram(mapping = aes(x = num_hahas, fill = industry))






