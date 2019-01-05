## ----------------------------------------------
#
# PROJECT16. [EX]  텍스트 마이닝
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

#install.packages(c('KoNLP', 'stringr', 'wordcloud2', 'tm', 'qgraph', 'scales'))
library(tm)
library(KoNLP)  # 한글 자연어 처리(형태소 분석) 패키지
library(stringr)
library(wordcloud2)
library(qgraph)

options(mc.cores=1)

# Step 1. 한글 형태소 분석 함수
ko.words <- function(doc) {
  d <- as.character(doc)
  ## 형태소 중 명사만 추출하기    
  pos <- paste(SimplePos09(d))
  ex <- str_match(pos, '([가-힣]+)/[NP]')
  keyword <- ex[,2]
  ## 결측값(NA) 정제하기    
  keyword[!is.na(keyword)]
}

# Step 2. 텍스트 파일 읽어오기
#txt <- c("행복은 마음에", "착한 마음에는 행복이")
txt <- readLines("2017_마스터_네이버영화평.txt")
#txt <- readLines(file.choose())

# Step 3. 텍스트마이닝 분석하기
words <- lapply(txt, ko.words)
cps <- Corpus(VectorSource(words))
tdm <- TermDocumentMatrix(cps, control = list(removePunctuation=T, removeNumbers=T))
tdm.matrix <- as.matrix(tdm)

# Step 4. 단어의 빈도수 분석을 통해 키워드 찾기
word.count <- rowSums(tdm.matrix)
word.order <- order(word.count, decreasing = T)
freq.words <- tdm.matrix 
keyword.df <- data.frame(rownames(freq.words), rowSums(freq.words))

# Step 5. 키워드를 워드클라우드로 시각화
wordcloud2(keyword.df)

# Step 6. 단어사이의 관계를 네트워크로 시각화
co.matrix <- freq.words %*% t(freq.words)
qgraph(co.matrix, labels=rownames(co.matrix), diag=F, layout='spring', edge.color='blue')       

