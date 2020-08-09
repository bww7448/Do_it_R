#15-1 R 내장 함수로 데이터 추출하기
exam <- read.csv("csv_exam.csv")
exam[] #조건 없이 데이터 전체 출력
exam[1,] #1행 추출
exam[2,] #2행 추출

exam[exam$class == 1,] #class가 1인 행 추출
exam[exam$math >= 80,]#수학 점수가 80점 이상인 행 추출

exam[exam$class == 1 & exam$math >= 50,]

exam[exam$english < 90 | exam$science < 50,]
###############################################
exam[,1] #1열 추출
exam[,2] #2열 추출
exam[, "class"] #class 변수 추출
exam[, "math"] #math 변수 추출출
exam[,c("class", "math", "english")] #class, math, english 변수 추출

exam[1,3]
exam[5, "english"]
exam[exam$math >= 50, "english"]
exam[exam$math >= 50, c("english", "science")]
