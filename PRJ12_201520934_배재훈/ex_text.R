## ----------------------------------------------
#
# PROJECT12. [EX]  텍스트 분석
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

install.packages(c("KoNLP", "stringr", "wordcloud", "wordcloud2"))
library(KoNLP)
library(stringr)
library(wordcloud)
library(wordcloud2)

# Step 1. 형태소 분석 함수
ko.words <- function(doc) {
    d <- as.character(doc)
## 한글 형태소 식별하기    
    pos <- paste(SimplePos09(d))
## 형태소 중 명사(N), 용언(형용사, 동사: NP)만 추출하기    
    ex <- str_match(pos, '([가-힣]+)/[NP]')
    keyword <- ex[,2]
## 결측값(NA) 정제하기    
    keyword[!is.na(keyword)]
}

# Step 2. 텍스트 파일 읽어오기
#txt <- readLines("2017_마스터_네이버영화평.txt")
## [참고] file.choose()
## 파일이름이 들어가야 하는 곳에 file.choose()를 적으면 파일선택 대화창이 뜨면서 파일을 자유롭게 선택할 수 있음
txt <- readLines(file.choose())

# Step 3. 형태소 분석하기
(keyword <- lapply(txt, extractNoun))
#(keyword <- lapply(txt, ko.words))
(keyword <- unlist(keyword))

# Step 4. 단어의 빈도수 분석을 통해 키워드 찾기
(keyword.df <- as.data.frame(table(keyword)))

# Step 5. 키워드를 워드클라우드로 시각화
wordcloud2(keyword.df)
## [참고] wordclound()
### brewer.pal() 색상팔렛트 지정 함수, colors 옵션에 지정 (colors 옵션을 생략하면 흑백으로 출력)
pal <- brewer.pal(8, "Set2")
wordcloud(keyword.df$keyword, keyword.df$Freq, min.freq = 2, colors = pal)
wordcloud(keyword.df$keyword, keyword.df$Freq, max.words = 5, colors = pal)

