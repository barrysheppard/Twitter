

# Working from https://sites.google.com/site/miningtwitter/questions/talking-about/wordclouds/wordcloud1

library(twitteR)
library(tm)
library(wordcloud)
library(RColorBrewer)

# Need to also check out https://sites.google.com/site/miningtwitter/questions/sentiment/sentiment


#consumer_key <- 'XXXXXX'
#consumer_secret <- 'XXXXXX'
#access_token <- 'XXXXXX-XXXXXX'
#access_secret <- 'XXXXXX'
#setup_twitter_oauth(consumer_key,
#                    consumer_secret,
#                    access_token,
#                    access_secret)

mach_tweets = searchTwitter("netrunner", n=500, lang="en")

mach_text = sapply(mach_tweets, function(x) x$getText())

# create a corpus
mach_corpus = Corpus(VectorSource(mach_text))

# create document term matrix applying some transformations
tdm = TermDocumentMatrix(mach_corpus,
                         control = list(removePunctuation = TRUE,
                                        stopwords = c(stopwords("english"),"netrunner"),
                                        removeNumbers = TRUE, tolower = TRUE))


# define tdm as matrix
m = as.matrix(tdm)
# get word counts in decreasing order
word_freqs = sort(rowSums(m), decreasing=TRUE) 
# create a data frame with words and their frequencies
dm = data.frame(word=names(word_freqs), freq=word_freqs)


# plot wordcloud
wordcloud(dm$word, dm$freq, max.words=100, min.freq=5, random.order=FALSE, rot.per=0.35, colors=brewer.pal(8, "Dark2"))


# save the image in png format
# png("TwitterCloud.png", width=12, height=8, units="in", res=300)
# wordcloud(dm$word, dm$freq, random.order=FALSE, colors=brewer.pal(8, "Dark2"))
# dev.off()


