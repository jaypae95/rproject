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
url <- "http://movie.naver.com/movie/point/af/list.nhn?&page=1"

# Step 1. Read HTML 
text <- read_html(url, encoding="CP949")
  
# Step 2. Read <movie> nodes for movie title
nodes <- html_nodes(text, ".movie")
(title <- html_text(nodes))
    
# Step 3. Read <point> nodes for movie point
nodes <- html_nodes(text, ".point")
(point <- html_text(nodes))
    
# Step 4. Read <title> nodes for moview review
nodes <- html_nodes(text, ".title")
(review <- html_text(nodes, trim = T))
(review <- gsub("\t", "", review))
(review <- gsub("\r", "", review))
(review <- gsub("\n", "", review))
(review <- gsub("신고", "", review))
  
# Step 5. 행으로 합치기
(page <- cbind(title, point))
(page <- cbind(page, review))
  
# Step 6. 열로 합치기
contents <- rbind(contents, page)

# Step 7. 영화평 저장하기
write.csv(contents, "네이버영화평.csv")
write(contents[, 3], "네이버영화평.txt")

