## load packages 
library(dplyr)
library(ggplot2)
require(NLP)
library(tm)
library(SnowballC)
source("C:/Users/linwa_000/Dropbox/Coursera_Data Science Specialization/Capstone Project/tokenization.R")
source("C:/Users/linwa_000/Dropbox/Coursera_Data Science Specialization/Capstone Project/sampling.R")

## number of lines
length(blog)
length(news)
length(twitter)

## combine data from three sources
tmdata <- c(blog, news, twitter)

## read profanity list
## source: http://www.freewebheaders.com/full-list-of-bad-words-banned-by-google/
profanity <- readLines("C:/Users/linwa_000/Dropbox/Coursera_Data Science Specialization/Capstone Project/badwords.txt")

## data transformation and tokenization
## ngrams() function returns a list, and we use vapply() to tranfer it back to a vector
sample1 <- mytokenizer(transtext(sampletext, profanity))
sample2 <- vapply(ngrams(sample1, 2), paste, "", collapse = " ")
sample3 <- vapply(ngrams(sample1, 3), paste, "", collapse = " ")

## frequency of n-grams (n = 1, 2, 3)
## count and record the frequency in a data frame
sample1df <- data.frame(table(sample1))
sample2df <- data.frame(table(sample2))
sample3df <- data.frame(table(sample3))

## sort based on frequency
onegram <- arrange(sample1df, desc(Freq))
twogram <- arrange(sample2df, desc(Freq))
thrgram <- arrange(sample3df, desc(Freq))

names(onegram) <- c("word", "frequency")
names(twogram) <- c("phrase", "frequency")
names(thrgram) <- c("phrase", "frequency")

## plot 1
ggplot(data = onegram[1:40, ], aes(x = reorder(word, order(frequency, decreasing = TRUE)), y = frequency)) + 
  geom_bar(stat = "identity") + labs(x = "word") + labs(title = "Word Frequency") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## plot 2
ggplot(data = twogram[1:40, ], aes(x = reorder(phrase, order(frequency, decreasing = TRUE)), y = frequency)) + 
  geom_bar(stat = "identity") + labs(x = "phrase") + labs(title = "2-gram Frequency") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## plot 3
ggplot(data = thrgram[1:40, ], aes(x = reorder(phrase, order(frequency, decreasing = TRUE)), y = frequency)) + 
  geom_bar(stat = "identity") + labs(x = "phrase") + labs(title = "3-gram Frequency") + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## coverage
