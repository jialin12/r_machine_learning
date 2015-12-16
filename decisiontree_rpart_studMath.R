#==============================================================================
#決策樹
#Date:2015/12/15
#rpart套件
#Data set:Student Performance Data Set 
#Source:UCI Machine Learning Repository
#Data set URL:https://archive.ics.uci.edu/ml/datasets/Student+Performance
#==============================================================================

setwd('C:/Users/Jialin/Desktop/BI_DATA')  #設定工作目錄(資料集存放的地方)
stud_math=read.csv("student-mat.csv")
head(stud_math)   #顯示前六筆資料
dim(stud_math)[1] #資料筆數
dim(stud_math)[2] #屬性數

library(rpart)

#下面改寫G3屬性值,給TAG(把原始G3的成績分類)
#16-20分為A，14-15分為B，12-13分為C，10-11分為D，0-9分為F
tmp=0
for(i in 1:395){
  if(stud_math[i,33]>15)tmp[i]="A"
  else if(stud_math[i,33]>13)tmp[i]="B"
  else if(stud_math[i,33]>11)tmp[i]="C"
  else if(stud_math[i,33]>9)tmp[i]="D"
  else tmp[i]="F"
}

stud_math[,33]=factor(tmp)
summary(stud_math$G3)

num_of_data=ceiling(0.1*nrow(stud_math)) #10%測試資料
num_of_data #資料筆數

test.index=sample(1:nrow(stud_math),num_of_data) #隨機抽取10%的測試資料

stud_math.testdata=stud_math[test.index,] #測試
stud_math.traindata=stud_math[-test.index,] #訓練

#下面建立訓練資料的決策樹
stud_math.tree= rpart(G3 ~.,method="class",data=stud_math.traindata)

#G3~.意思相當於G3之外的所有屬性，上面之"."逗點可替換成school + sex + age +	address +	famsize +	Pstatus +	Medu + Fedu +	Mjob + Fjob +	reason + guardian + traveltime +	studytime +	failures + schoolsup +	famsup +	paid + activities +	nursery +	higher + internet +	romantic + famrel +	freetime +	goout +	Dalc +	Walc +	health +	absences +	G1 + G2

stud_math.tree
plot(stud_math.tree);text(stud_math.tree)#畫出決策樹

summary(stud_math.tree)

#install.packages("gmodels")
library(gmodels)

cat("======訓練資料======","\n")
G3.traindata=stud_math$G3[-test.index]
train.predict=factor(predict(stud_math.tree, stud_math.traindata, type="class"), levels=levels(G3.traindata))
CrossTable(x = G3.traindata, y = train.predict, prop.chisq=FALSE) #畫出CrossTable
train.corrcet=sum(train.predict==G3.traindata)/length(train.predict)#訓練資料之正確率
cat("訓練資料正確率",train.corrcet*100,"%\n")

cat("======測試資料======","\n")
G3.testdata=stud_math$G3[test.index]
test.predict=factor(predict(stud_math.tree, stud_math.testdata, type="class"), levels=levels(G3.testdata))
CrossTable(x = G3.testdata, y = test.predict, prop.chisq=FALSE) #畫出CrossTable
test.correct=sum(test.predict==G3.testdata)/length(test.predict)#測試資料之正確率
cat("測試資料正確率",test.correct*100,"%\n")
