## create connections
con1 <- file("C:/Users/linwa_000/Desktop/final/en_US/en_US.blogs.txt", "rb")
con2 <- file("C:/Users/linwa_000/Desktop/final/en_US/en_US.news.txt", "rb")
con3 <- file("C:/Users/linwa_000/Desktop/final/en_US/en_US.twitter.txt", "rb")

## read files
blog <- readLines(con1)
news <- readLines(con2)
twitter <- readLines(con3)

## close connections
close(con1, con2, con3)
rm(con1, con2, con3)

## sampling (1%)
set.seed(1122)
sample.index1 <- as.logical(rbinom(n = length(blog), size = 1, prob = 0.01))
sample.index2 <- as.logical(rbinom(n = length(news), size = 1, prob = 0.01))
sample.index3 <- as.logical(rbinom(n = length(twitter), size = 1, prob = 0.01))

sampletext <- c(blog[sample.index1], news[sample.index2], twitter[sample.index3])
writeLines(sampletext, con = "C:/Users/linwa_000/Dropbox/Coursera_Data Science Specialization/Capstone Project/sample.txt")

## remove unused sample indices
rm(sample.index1, sample.index2, sample.index3)