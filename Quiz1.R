con1 <- file("C:/Users/linwa_000/Desktop/final/en_US/en_US.blogs.txt", "r")
con2 <- file("C:/Users/linwa_000/Desktop/final/en_US/en_US.news.txt", "r")
con3 <- file("C:/Users/linwa_000/Desktop/final/en_US/en_US.twitter.txt", "r")

## Question 1. The en_US.blogs.txt  file is how many megabytes?

## Question 2. The en_US.twitter.txt has how many lines of text?

length(readLines(con3))

## Question 3. What is the length of the longest line seen in any of the three en_US data sets?

blog <- readLines(con1)
news <- readLines(con2)
twitter <- readLines(con3)
max(nchar(blog)  ## 40835
max(nchar(news)) ## 5760
max(nchar(twitter)) ## 213

## Question 4. In the en_US twitter data set, if you divide the number of lines where the word "love" (all lowercase) 
## occurs by the number of lines the word "hate" (all lowercase) occurs, about what do you get?

sum(grepl("love", twitter))/sum(grepl("hate", twitter))  ## 4.108592

## Question 5. The one tweet in the en_US twitter data set that matches the word "biostats" says what?

twitter[grep("biostats", twitter)]  ##  "i know how you feel.. i have biostats on tuesday and i have yet to study =/"

## Question 6. How many tweets have the exact characters 
## "A computer once beat me at chess, but it was no match for me at kickboxing". 
## (I.e. the line matches those characters exactly.)

sum(grepl("A computer once beat me at chess, but it was no match for me at kickboxing", twitter))  ## 3

close(con1)
close(con2)
close(con3)