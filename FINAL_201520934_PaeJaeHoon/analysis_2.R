## ----------------------------------------------
#
# PROJECT_FINAL. 데이터 분석(텍스트, 연관)
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Pae, Jaehoon
# History : 2018/11/16
#
## ----------------------------------------------
#install.packages(c("wordcloud2", "arules"))
library(wordcloud2)
library(arules)

#자살충동이유 텍스트 분석
wc <- subset(survey, !is.na(자살충동이유))
wc <- data.frame(table(wc$자살충동이유))
wordcloud2((wc))

#교육정도 텍스트 분석
wc2 <- subset(survey, !is.na(교육정도))
wc2 <- data.frame(table(survey$교육정도))
wordcloud2(wc2)


#일상스트레스에 영향을 끼지는 요소 연관분석 준비단계(사용할 column정하기, 전처리)
check <- subset(survey, select=c("성별", "교육정도", "혼인상태", "금연어려운이유", 
                                 "직장스트레스", "일상스트레스", "자살충동이유",
                                 "교육비부담인식", "이혼에대한견해", "가족관계", "가구소득"))
check$가족관계 <- factor(check$가족관계, levels=c(1:6),
                     labels=c('매우만족', '약간만족', '보통', '약간불만족', '매우불만족', '해당없음'))
check$직장스트레스 <- factor(check$직장스트레스, levels=c(1:5), 
                         labels=c('매우많이느꼈다', '느끼는편이다', '느끼지않는편이다', '전혀느끼지않았다', '해당없음'))
check$일상스트레스 <- factor(check$일상스트레스, levels=c(1:5), 
                         labels=c('매우많이느꼈다', '느끼는편이다', '느끼지않는편이다', '전혀느끼지않았다', '해당없음'))
check$교육비부담인식 <- factor(check$교육비부담인식, levels=c(1:5),
                        labels=c('매우부담스럽다', '약간부담스럽다', '보통이다', '별로부담스럽지않다', '전혀부담스럽지않다'))

#연관분석(신뢰도가 60퍼센트 이상인 것)
rule <- apriori(check, parameter=list(support=0.3, confidence=0.6, minlen=2))
summary(rule)

#일상스트레스에 영향을 끼치는 요소 연관분석
rule.df<-as(rule, "data.frame")
inspect(subset(rule, subset=rhs %in% c("일상스트레스=매우많이느꼈다", "일상스트레스=느끼는편이다")))
