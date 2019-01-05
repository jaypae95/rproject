## ----------------------------------------------
#
# PROJECT17. [EX]  텍스트 분석
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

#install.packages(c('KoNLP', 'stringr', 'wordcloud2', 'tm', 'qgraph', 'scales'))
library(tm)
library(KoNLP)
library(stringr)
library(wordcloud2)
library(qgraph)

options(mc.cores=1)

# Step 1. 필요한 단어 추가해서 사전 보완하기
## Q1) 세종, 우리말쌈 사전 선택 후 사용자 사전 보완
## 예: 마스터 영화에 대한 사용자 사전 보완 
dics <- c('sejong','woorimalsam')
buildDictionary(ext_dic = dics, user_dic=data.frame("트럼프", "nq"), replace_usr_dic=T) #nq는 고유명사
buildDictionary(ext_dic = dics, user_dic=data.frame("도널드", "nq"))
buildDictionary(ext_dic = dics, user_dic=data.frame("도날드", "nq"))
buildDictionary(ext_dic = dics, user_dic=data.frame("김정은", "nq"))


# Step 2. 한글 형태소 분석 함수
ko.words <- function(doc) {
  d <- as.character(doc)
  ## 형태소 중 명사만 추출하기    
  pos <- paste(SimplePos09(d))
  ex <- str_match(pos, '([가-힣]+)/[NP]')
  keyword <- ex[,2]
  ## Q2) 불필요한 단어 정제하기
  ### 예: 마스터 영화에 대한 동의어 통일 및, 불필요한 단어 무시
  keyword <- gsub("도널드", "트럼프", keyword)
  keyword <- gsub("도날드", "트럼프", keyword)
  
  keyword <- gsub("위원장", "국무위원장", keyword)
  
  keyword <- gsub("마이크", "폼페이오", keyword)
  
  keyword <- gsub("싱가포르에서", "싱가포르", keyword)
  keyword <- gsub("싱가폴", "싱가포르", keyword)
  
  keyword <- gsub("탄도미사일", "미사일", keyword)
  
  keyword <- gsub("조미", "북미", keyword)
  
  keyword <- gsub("조선", "북한", keyword)
  
  keyword <- gsub("위하", NA, keyword)
  keyword <- gsub("대하", NA, keyword)
  keyword <- gsub("따르", NA, keyword)
  keyword <- gsub("밝히", NA, keyword)
  keyword <- gsub("우리", NA, keyword)
  keyword <- gsub("열리", NA, keyword)
  keyword <- gsub("지나", NA, keyword)
  keyword <- gsub("만나", NA, keyword)
  keyword <- gsub("통하", NA, keyword)
  
  
  
  ## 결측값(NA) 정제하기    
  keyword[!is.na(keyword)]
}

# Step 3. 텍스트 파일 읽어오기
#txt <- readLines("2017_마스터_네이버영화평.txt")
txt <- readLines("20180525_헤드라인뉴스.txt")

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

