## ----------------------------------------------
#
# PROJECT19. [EX]  텍스트 분석
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

install.packages(c('KoNLP', 'stringr', 'wordcloud2', 'tm', 'qgraph', 'scales', 'ggplot2'))
library(tm)
library(KoNLP)
library(stringr)
library(wordcloud2)
library(qgraph)
library(ggplot2)

options(mc.cores=1)

# Step 1. 필요한 단어 추가해서 사전 보완하기
## 세종, 우리말쌈 사전 선택 후 사용자 사전 보완
## 예: 마스터 영화에 대한 사용자 사전 보완 
dics <- c('sejong','woorimalsam')
buildDictionary(ext_dic = dics)
#buildDictionary(ext_dic = dics, user_dic=data.frame("이병헌", "nq"), replace_usr_dic=T)
#buildDictionary(ext_dic = dics, user_dic=data.frame("강동원", "nq"))
#buildDictionary(ext_dic = dics, user_dic=data.frame("김우빈", "nq"))

# Step 2. 한글 형태소 분석 함수
ko.words <- function(doc) {
  d <- as.character(doc)
  ## 형태소 중 명사만 추출하기    
  pos <- paste(SimplePos09(d)) #, autoSpacing = T))
  ex <- str_match(pos, '([가-힣]+)/[NP]')
  keyword <- ex[,2]
  ## 불필요한 단어 정제하기
  ## 예: 마스터 영화에 대한 동의어 통일 및, 불필요한 단어 무시
  #keyword <- gsub("강동원님", "강동원", keyword)
  #keyword <- gsub("강동원빨", "강동원", keyword)
  #keyword <- gsub("강동원짱", "강동원", keyword)
  #keyword <- gsub("크으", NA, keyword)
  #keyword <- gsub("니네", NA, keyword)
  ## 결측값(NA) 정제하기    
  keyword[!is.na(keyword)]
}

# Step 3. 텍스트 파일 읽어오기
#txt <- readLines("2017_마스터_네이버영화평.txt")

## Q1) 영화평 CSV 파일 읽어오기
contents <- read.csv("네이버영화평.csv")

## Q2) 관심 영화에 대한 영화정보 추출하기
target <- readline("분석하고 싶은 영화 제목을 입력하세요: ")
movie <- subset(contents, title==target)
## Q3) 평점 분포를 박스플롯으로 시각화하기
ggplot(movie, aes(x=title, y=point, color = "pink")) + geom_boxplot()

## Q4) 전체 영화정보(제목, 평점, 영화평) 중 영화평만 텍스트 분석하기 위해 txt에 저장하기
txt<-movie$review


# Step 4. 텍스트마이닝 분석하기
words <- lapply(txt, ko.words)
cps <- Corpus(VectorSource(words))
tdm <- TermDocumentMatrix(cps, control = list(removePunctuation=T, removeNumbers=T))
tdm.matrix <- as.matrix(tdm)

# Step 5. 단어의 빈도수 분석을 통해 키워드 찾기
word.count <- rowSums(tdm.matrix)
word.order <- order(word.count, decreasing = T)
freq.words <- tdm.matrix[word.order[1:30],] 
keyword.df <- data.frame(rownames(freq.words), rowSums(freq.words))

# Step 6. 키워드를 워드클라우드로 시각화
wordcloud2(keyword.df)

# Step 7. 단어사이의 관계를 네트워크로 시각화
co.matrix <- freq.words %*% t(freq.words)
qgraph(co.matrix, labels=rownames(co.matrix), diag=F, layout='spring', edge.color='blue')       

