install.packages("mapproj")
install.packages("ggiraphExtra")
install.packages('maps')
library(ggiraphExtra)
library(tibble)
library(ggplot2)
###############################################################################
#11-1 미국 주별 강력 범죄율 단계 구분도 만들기

str(USArrests)
head(USArrests)

crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state) #다 소문자로 바꿔준다.
str(crime)

states_map <- map_data("state")
str(states_map)
View(states_map)

ggChoropleth(data = crime,           #지도 표시하기
             aes(fill = Murder,      #Murder 수치로 채우기
                 map_id = state),    #map 나누는 기준 정하기
             map = states_map)

ggChoropleth(data = crime,        #지도에 표현할 데이터
             aes(fill = Murder,   #색으로 표현할 변수
                 map_id = state), #지역 기준 변수
             map = states_map,    #지도 데이터
             interactive = T)     #인터랙티브 -> 마우스 움직임에 반응한다!

##Save as Web Page를 이용해 HTML 파일로도 저장 가능하다!

################################################################################
install.packages("stringi")
install.packages("devtools")
devtools :: install_github("cardiomoon/kormaps2014")
library(kormaps2014)
library(dplyr)
#11-2 대한민국 시도별 인구, 결핵 환자 수 단계 구분도 만들기!
str(changeCode(korpop1)) #changeCode를 이용해 인코딩 변경이 가능하다.
korpop1 <- rename(korpop1, pop = 총인구_명, name = 행정구역별_읍면동)
korpop1$name <- iconv(korpop1$name, "UTF-8", "CP949") #인코딩을 UTF-8에서 CP949로 바꾼다.
str(changeCode(kormap1))
View(korpop1)
#kormap1 : 2014년 한국 행정 지도(시도별)
#kormap2 : 2014년 한국 행정 지도(시군구별)
#kormap3 : 2014년 한국 행정 지도(읍면동별)

ggChoropleth(data = korpop1,     #지도에 표현할 데이터
             aes(fill = pop,     #색으로 표현할 변수
                 map_id = code,  #지역 기준 변수
                 tooltip = name),#지도 위에 표시할 지역명
             map = kormap1,      #지도 데이터
             interactive = T)    #인터랙티브

str(changeCode(tbc))
tbc$name <- iconv(tbc$name, "UTF-8", "CP949")
ggChoropleth(data = tbc,
            aes(fill = NewPts,
                map_id = code,
                tooltip = name),
            map = kormap1,
            interactive = T)

setwd("C:\\big data class\\R_edu\\doit_R")
