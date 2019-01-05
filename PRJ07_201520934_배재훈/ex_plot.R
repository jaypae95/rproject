## ----------------------------------------------
#
# PROJECT07. [EX] Plot
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Seo, Jooyoung
# History : 2018/09/01
#
## ----------------------------------------------

#install.packages(c("gcookbook", "ggplot2"))
library(gcookbook)
library(ggplot2)

View(uspopchange)

# scatter-plot
ggplot(uspopchange, aes(x=Region, y=Change, color=State)) + geom_point(size=5)

# bar plot
ggplot(uspopchange, aes(x=Region, y=Change, fill=State)) + geom_col()

# box-plot
ggplot(uspopchange, aes(x=Region, y=Change, color=Region)) + geom_boxplot()
