## ----------------------------------------------
#
# PROJECT01. 단위 변환기
#
# COPYRIGHT (c) 2018 AJOU University
# Author	: Pae, Jaehoon
# History : 2018/09/13
#
## ----------------------------------------------

message("\n***cm를 inch로 변환해주는 변환기 입니다.***\n")
# Step 1. cm 입력
cat("cm 입력: ")
cm <- scan(n=1)

# Step 2. 변환
inch <- cm / 2.54

# Step 3. inch 출력
cat("[", cm, "]cm는", "[", round(inch, digits=6), "]inch입니다\n")