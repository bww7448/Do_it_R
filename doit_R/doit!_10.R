install.packages("wordcloud")

library(KoNLP)
library(rJava)
library(stringr)
library(dplyr)
library(wordcloud)
library(RColorBrewer)
library(ggplot2)
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다")
.libPaths()
buildDictionary(ext_dic = c("woorimalsam", "sejong"),
                replace_usr_dic = T)
useNIADic()
setwd('C:\\big data class\\R_edu\\doit_R\\Data')
###############################################################################
#10-1 힙합가사 분석
txt <- readLines("hiphop.txt")
txt <- str_replace_all(txt, "\\W", " ")
nouns <- extractNoun(txt)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
View(df_word)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word <- filter(df_word, nchar(word) >= 2)
top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)
top_20

pal <- brewer.pal(8, "Dark2") #색 지정
set.seed(1234) #난수고정
pal <- brewer.pal(9, "Blues")[5:9]
wordcloud(words = df_word$word, #단어
          freq = df_word$freq, #빈도
          min.freq = 2, #최소 단어 빈도
          max.words = 200, #표현 단어 수
          random.order = F, #고빈도 단어 중앙 배치
          rot.per = .1, #회전 단어 비율
          sclae = c(4, 0.3), #단어 크기 범위
          colors = pal ) #색상 목록

#10-2 국정원 트윗 텍스트 마이닝
twitter <- read.csv("twitter.csv",
                    header = T,
                    stringsAsFactors = F,
                    fileEncoding = "UTF-8")
twitter <- rename(twitter,
                  no = 번호,
                  id = 계정이름,
                  date = 작성일,
                  tw = 내용)
twitter$tw <- str_replace_all(twitter$tw, "\\W", " ")
head(twitter$tw)

nouns <- extractNoun(twitter$tw)
wordcount <- table(unlist(nouns))
df_word <- as.data.frame(wordcount, stringsAsFactors = F)
df_word <- rename(df_word,
                  word = Var1,
                  freq = Freq)
df_word <- filter(df_word, nchar(word) >= 2)
top_20 <- df_word %>% 
  arrange(desc(freq)) %>% 
  head(20)
top_20

order<- arrange(top_20, freq)$word #빈도 순서 변수 생성
order
ggplot(data = top_20, aes(x = word, y = freq)) +
  ylim(0, 2500) +
  geom_col() +
  coord_flip() +
  scale_x_discrete(limit = order) +          #빈도 순 막대 정렬
  geom_text(aes(label = freq), hjust = -0.3) #빈도 표시 hjust로 글자 위치 조정

pal <- brewer.pal(8, "Dark2")
set.seed(1234)
wordcloud(words = df_word$word,
          freq = df_word$freq,
          min.freq = 10,
          max.words = 200,
          random.order = F,
          rot.per = .1,
          scale = c(6, 0.2),
          colors = pal)
