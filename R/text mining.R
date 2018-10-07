### text minging for R final project

library(readr)
library(tidyverse)
all_withimage_raw <- read_csv("C:/Users/wolu0/Desktop/Documents/Allen/Pitt/Spring/BMIS2526 Practical Data Science with R/project/data/processsed/with image/all/car.csv", 
                          col_types = cols(status_published = col_datetime(format = "%Y-%m-%d %H:%M:%S")))
all_withoutimage_raw <- read_csv("C:/Users/wolu0/Desktop/Documents/Allen/Pitt/Spring/BMIS2526 Practical Data Science with R/project/data/processsed/without image/all/all.csv", 
                                 col_types = cols(status_published = col_datetime(format = "%Y-%m-%d %H:%M:%S")))
all_withimage_cosmetic <- read_csv("C:/Users/wolu0/Desktop/Documents/Allen/Pitt/Spring/BMIS2526 Practical Data Science with R/project/data/processsed/with image/all/cosmetic.csv", 
                              col_types = cols(status_published = col_datetime(format = "%Y-%m-%d %H:%M:%S")))
text = all_withimage_raw$lables
text
all_withimage_raw
text_pro = all_withimage_raw %>%
  unnest_tokens(word, lables)
text_pro$word
text_pro %>%
  count(word, sort = TRUE)

text_pro_rank <-  text_pro%>%
  count(word, sort = TRUE) 

text_pro_rank%>%
  filter(n > 500) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = 'identity') +
  xlab(NULL) +
  coord_flip()

text_pro_rank %>% with(wordcloud(word, n, max.words = 100))
summary(all_withimage_raw)


all_withimage_reaction <- all_withimage_raw[which(all_withimage_raw$num_reactions>3845),]
all_withimage_reaction

text_pro_reaction = all_withimage_reaction %>%
  unnest_tokens(word, lables)
text_pro_reaction$word
text_pro_reaction %>%
  count(word, sort = TRUE)

text_pro_reaction_rank <-  text_pro_reaction%>%
  count(word, sort = TRUE) 


text_pro_reaction_rank%>%
  filter(n > 500) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = 'identity') +
  xlab(NULL) +
  coord_flip()

text_pro_reaction_rank %>% with(wordcloud(word, n, max.words = 100))
###cosmetic
all_withimage_cosmetic <- read_csv("C:/Users/wolu0/Desktop/Documents/Allen/Pitt/Spring/BMIS2526 Practical Data Science with R/project/data/processsed/with image/all/cosmetic.csv", 
                                   col_types = cols(status_published = col_datetime(format = "%Y-%m-%d %H:%M:%S")))

text_pro_cosmetic = all_withimage_cosmetic %>%
  unnest_tokens(word, lables)
text_pro_cosmetic$word
text_pro_cosmetic %>%
  count(word, sort = TRUE)



word_rank <- text_pro_cosmetic %>%
  count(word, sort = TRUE) %>%
  filter(n > 500) %>%
  mutate(word = reorder(word, n)) 


word_rank %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = 'identity') +
  xlab(NULL) +
  coord_flip() 


install.packages("wordcloud")
library(wordcloud)

word_rank %>% with(wordcloud(word, n, max.words = 100))
###cosmetic which (reaction>3rd q (548))

summary(all_withimage_cosmetic)
text_pro_cosmetic_reaction = all_withimage_cosmetic[which(all_withimage_cosmetic$num_reactions>548),] %>%
  unnest_tokens(word, lables)
text_pro_cosmetic_reaction$word
text_pro_cosmetic_reaction %>%
  count(word, sort = TRUE)
text_pro_cosmetic_reaction

word_rank_reaction <- text_pro_cosmetic_reaction %>%
  count(word, sort = TRUE) %>%
  filter(n > 50) %>%
  mutate(word = reorder(word, n))


word_rank_reaction


word_rank_reaction%>%
  ggplot(aes(word, n)) +
  geom_bar(stat = 'identity') +
  xlab(NULL) +
  coord_flip()

#wordcloud
install.packages("wordcloud")
library(wordcloud)

word_rank_reaction %>% with(wordcloud(word, n, max.words = 100))



########################################################################################################
#content text   anti_join(stop_words)
#############################
all_withoutimage_car <- all_withoutimage_raw[which(all_withoutimage_raw$industry == 'car'),]
all_withoutimage_cosmetic <- all_withoutimage_raw[which(all_withoutimage_raw$industry == 'cosmetic'),]
all_withoutimage_car

##### car
text_car = all_withoutimage_car %>%
  unnest_tokens(word, status_message) %>%
  anti_join(stop_words)

text_car$word

text_car_pro <-  text_car%>%
  count(word, sort = TRUE)
  
text_car_pro %>%
  filter(n > 1500) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = 'identity') +
  xlab(NULL) +
  coord_flip()
#wordcloud
text_car_pro %>% with(wordcloud(word, n, max.words = 100))

#########3reaction > 3rd 6739
summary(all_withoutimage_car)
all_withoutimage_car_reaction <- all_withoutimage_car[which(all_withoutimage_car$num_reactions>6739),]
text_car_reaction = all_withoutimage_car_reaction %>%
  unnest_tokens(word, status_message) %>%
  anti_join(stop_words)

text_car_pro_reaction <-  text_car_reaction%>%
  count(word, sort = TRUE)

text_car_pro_reaction %>%
  filter(n > 500) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = 'identity') +
  xlab(NULL) +
  coord_flip()
#wordcloud
text_car_pro_reaction %>% with(wordcloud(word, n, max.words = 100))


#cosmetic:
text_cosmetic = all_withoutimage_cosmetic %>%
  unnest_tokens(word, status_message) %>%
  anti_join(stop_words)
all_withoutimage_cosmetic
text_cosmetic$word

text_cosmetic_pro <-  text_cosmetic%>%
  count(word, sort = TRUE)

text_cosmetic_pro %>%
  filter(n > 1000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = 'identity') +
  xlab(NULL) +
  coord_flip()
#wordcloud
text_cosmetic_pro %>% with(wordcloud(word, n, max.words = 100))

#########3reaction > 3rd 548
summary(all_withoutimage_cosmetic)
all_withoutimage_cosmetic_reaction <- all_withoutimage_cosmetic[which(all_withoutimage_cosmetic$num_reactions>548),]
text_cosmetic_reaction = all_withoutimage_cosmetic_reaction %>%
  unnest_tokens(word, status_message) %>%
  anti_join(stop_words)

text_cosmetic_pro_reaction <-  text_cosmetic_reaction%>%
  count(word, sort = TRUE)

text_cosmetic_pro_reaction %>%
  filter(n > 300) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_bar(stat = 'identity') +
  xlab(NULL) +
  coord_flip()
#wordcloud
text_cosmetic_pro_reaction %>% with(wordcloud(word, n, max.words = 100))








