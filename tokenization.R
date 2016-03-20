## Functions 1 and 2: text data transformation
## Function 3: change corpus of documents into character vector
## Function 4: number of words/phases needed to cover a certain percentage of all instances

## load packages
require(NLP)
library(tm)
library(dplyr)

## read sample data
## con <- file("C:/Users/linwa_000/Dropbox/Coursera_Data Science Specialization/Capstone Project/sample.txt", "rb")
## sampletext <- readLines(con)
## close(con)
## rm(con)

## read profanity list
## source: http://www.freewebheaders.com/full-list-of-bad-words-banned-by-google/
## profanity <- readLines("C:/Users/linwa_000/Dropbox/Coursera_Data Science Specialization/Capstone Project/badwords.txt")


## FUNCTION I
## without removing stopwords
## Whether to remove stopwords is dependent on the purpose of text mining
## I don't think we need this for this project because we are trying to predict most common phrase

transtext1 <- function(text, filterword) {
  ## build a corpus, which is a collection of text documents
  myCorpus <- Corpus(VectorSource(text))
  ## transfer to lower cases
  myCorpus <- tm_map(myCorpus, tolower)
  ## remove profanity
  myCorpus <- tm_map(myCorpus, removeWords, filterword)
  ## remove punctuation
  myCorpus <- tm_map(myCorpus, removePunctuation)
  ## remove numbers
  myCorpus <- tm_map(myCorpus, removeNumbers)
  ## stemming
  myCorpus <- tm_map(myCorpus, stemDocument)
  
  ## the next step is to correct the data type. See details at:
  ## http://stackoverflow.com/questions/24771165/r-project-no-applicable-method-for-meta-applied-to-an-object-of-class-charact
  myCorpus <- tm_map(myCorpus, PlainTextDocument)
  return(myCorpus)
}

## FUNCTION II
## removing stopwords
transtext <- function(text, filterword) {
  ## build a corpus, which is a collection of text documents
  myCorpus <- Corpus(VectorSource(text))
  ## transfer to lower cases
  myCorpus <- tm_map(myCorpus, tolower)
  ## remove stopwords 
  myCorpus <- tm_map(myCorpus, removeWords, stopwords("en"))
  ## remove profanity
  myCorpus <- tm_map(myCorpus, removeWords, filterword)
  ## remove punctuation
  myCorpus <- tm_map(myCorpus, removePunctuation)
  ## remove numbers
  myCorpus <- tm_map(myCorpus, removeNumbers)
  ## stemming
  myCorpus <- tm_map(myCorpus, stemDocument)
  
  ## the next step is to correct the data type. See details at:
  ## http://stackoverflow.com/questions/24771165/r-project-no-applicable-method-for-meta-applied-to-an-object-of-class-charact
  myCorpus <- tm_map(myCorpus, PlainTextDocument)
  return(myCorpus)
}

## function to transfer corpus back to character vector
mytokenizer <- function(x) {
  y <- sapply(x[1:length(x)], as.character)
  z <- scan_tokenizer(y)
  return(z)
}

## function to find out coverage
cover <- function(token, coverage) {
  freq <- data.frame(table(token))
  names(freq) <- c("phrase", "frequency")
  freq <- arrange(freq, desc(frequency))
  m <- length(token)*coverage
  j <- 1
  counts <- 0
  while (counts < m) {
    counts <- counts + freq$frequency[j]
    j <- j+1
  }
  return(j-1)
}