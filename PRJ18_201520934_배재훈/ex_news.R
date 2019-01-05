## ----------------------------------------------
#
# PROJECT18. [EX] 네이버 영화평 사이트 크롤링
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

install.packages("rvest")
library(rvest)

contents <- NULL

# Naver Movie Site URL
url <- "https://news.naver.com/main/list.nhn?mode=LSD&mid=sec&sid1=001&date=20181206&page=1"

# Step 1. Read HTML 
text <- read_html(url, encoding="CP949")

# Step 2. Read <movie> nodes for news content
nodes <- html_nodes(text, ".lede")
(content <- html_text(nodes))

# Step 3. Read <point> nodes for movie point
nodes <- html_nodes(text, ".writing")
(publish <- html_text(nodes))

# Step 4. Read <title> nodes for moview review
# nodes <- html_nodes(text, ".title")
# (review <- html_text(nodes, trim = T))
# (review <- gsub("\t", "", review))
# (review <- gsub("\r", "", review))
# (review <- gsub("\n", "", review))
# (review <- gsub("신고", "", review))

# Step 5. 행으로 합치기
(page <- cbind(publish, content))

# Step 6. 열로 합치기
# contents <- rbind(contents, page)

# Step 7. 영화평 저장하기
write.csv(page, "네이버뉴스속보.csv")
write(page[, 2], "네이버뉴스속보.txt")
