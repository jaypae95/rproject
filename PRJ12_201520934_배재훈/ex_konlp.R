## ----------------------------------------------
#
# PROJECT12. [EX]  한글 형태소 분석
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

install.packages(c("KoNLP", "stringr", "wordcloud2"))
library(KoNLP)
library(stringr)
library(wordcloud2)

t <- "우리는 정말 즐거운 마음으로 학교를 다닙니다."
#t <- "우리는 정말 즐거운 마음으로 학교를 다닙니다. 좋은 학교는 우리의 생활을 즐겁게 만들어 줍니다."

# 명사 추출하기
extractNoun(t)
# 한글 형태소 식별하기
SimplePos09(t)

# Step 1. 형태소 분석을 통해 명사, 용언(형용사, 동사) 추출하기
## 한글 형태소 식별하기
(d <- paste(SimplePos09(t)))
## Q1) 형태소 중 명사(N), 용언(형용사, 동사: NP)만 추출하기
(ex <- str_match(d, "([가-힣]+)/[NP]"))
(keyword <- ex[, 2])
## 결측값(NA) 정제하기
(keyword <- keyword[!is.na(keyword)])

# Step 2. 단어의 빈도수 분석을 통해 키워드 찾기
(keyword.df <- as.data.frame(table(keyword)))

# Step 3. 키워드를 워드클라우드로 시각화
wordcloud2(keyword.df)
