## ----------------------------------------------
#
# PROJECT09. [EX] Cross-Tabulation Analysis
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

install.packages("gmodels")
library(gmodels)

# Step 1. 데이터 읽어오기
smoke <- read.csv("smoke.csv")

# Step 2. 교차표로 교차분석 수행
CrossTable(smoke$cancer, smoke$smoke, chisq=T)

chisq.test(smoke$cancer, smoke$smoke)
chisq.test(smoke$cancer, smoke$smoke, correct = F)  # 보정하지않겠다.
