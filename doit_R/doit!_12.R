setwd("C:\\big data class\\R_edu\\doit_R\\Data")

#인터랙티브 그래프란 마우스 움직임에 반응하며 실시간으로 형태가 변하는 그래프이다.
install.packages("plotly")
install.packages("dygraphs")
library(plotly)
library(ggplot2)
library(dygraphs)
library(xts)
#12-1 인터래티브 그래프 만들기
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()
ggplotly(p) # 인터랙티브 그래프 만들기!
#마우스 드래그로 확대도 가능하다 / 돌아오려면 더블클릭하면 된다.
q <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) + geom_bar(position = "dodge")
ggplotly(q)


#12-2 dygraphs 패키지로 인터랙티브 시계열 그래프 만들기
economics <- ggplot2::economics
head(economics)

eco <- xts(economics$unemploy, order.by = economics$date) 
#dygraph를 이용하려면 시간 순서 속성을 지니는 xts 데이터 타입으로 돼 있어야 한다.
#xts()를 이용해 xts데이터 타입으로 변경
head(eco)

dygraph(eco)
dygraph(eco) %>%  dyRangeSelector() # 날짜 범위를 선택할 수 있는 기능을 추가한다.

eco_a <- xts(economics$psavert, order.by = economics$date)
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)
eco2 <- cbind(eco_a, eco_b) #가로로 결합해준다.
colnames(eco2) <- c("psavert", "unemploy") #변수명 바꾸기기
head(eco2)
dygraph(eco2) %>% dyRangeSelector
