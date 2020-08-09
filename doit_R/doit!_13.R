################################################################################
#13-2 t검정 - 두 집단의 평균 비교 t.test()
library(dplyr)
mpg <- as.data.frame(ggplot2::mpg)
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c("compact", "suv"))
head(mpg_diff)
table(mpg_diff$class)

t.test(data = mpg_diff, cty ~ class, var.equal = T)
#비교할값 : cty // 비교할 집단 : class
#var.equal = T : 두 집단의 분산이 같다.

mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c("r", "p")) #r:regular, p:premium
table(mpg_diff2$fl)

t.test(data = mpg_diff2, cty ~ fl, var.equal = T)

#13-3 상관분석 - 두 변수의 관계성 분석
economics <- as.data.frame(ggplot2::economics)
cor.test(economics$unemploy, economics$pce)

head(mtcars)
car_cor <- cor(mtcars)
round(car_cor,2)

install.packages("corrplot")
library(corrplot) #상관행렬을 heat map으로 나타낸다.
corrplot(car_cor)
corrplot(car_cor, method = "number")

col <- colorRampPalette(c("#BB4444", "Orange", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(car_cor,
         method = "color", #색으로 표현
         col = col(200), #색상 200개 선정
         type = "lower", #왼쪽 아래 행렬만 표시
         order = "hclust", #유사한 상관계수끼리 군집화
         addCoef.col = "black", #상관계수 색
         tl.col = "black", #변수명 색
         tl.srt = 45, #변수명 45도 기울임
         diag = F) #대각 행렬 제외
