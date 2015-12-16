#==============================================================================
#�M����
#Date:2015/12/15
#rpart�M��
#Data set:Student Performance Data Set 
#Source:UCI Machine Learning Repository
#Data set URL:https://archive.ics.uci.edu/ml/datasets/Student+Performance
#==============================================================================

setwd('C:/Users/Jialin/Desktop/BI_DATA')  #�]�w�u�@�ؿ�(��ƶ��s�񪺦a��)
stud_math=read.csv("student-mat.csv")
head(stud_math)   #��ܫe�������
dim(stud_math)[1] #��Ƶ���
dim(stud_math)[2] #�ݩʼ�

library(rpart)

#�U����gG3�ݩʭ�,��TAG(���lG3�����Z����)
#16-20����A�A14-15����B�A12-13����C�A10-11����D�A0-9����F
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

num_of_data=ceiling(0.1*nrow(stud_math)) #10%���ո��
num_of_data #��Ƶ���

test.index=sample(1:nrow(stud_math),num_of_data) #�H�����10%�����ո��

stud_math.testdata=stud_math[test.index,] #����
stud_math.traindata=stud_math[-test.index,] #�V�m

#�U���إ߰V�m��ƪ��M����
stud_math.tree= rpart(G3 ~.,method="class",data=stud_math.traindata)

#G3~.�N��۷���G3���~���Ҧ��ݩʡA�W����"."�r�I�i������school + sex + age +	address +	famsize +	Pstatus +	Medu + Fedu +	Mjob + Fjob +	reason + guardian + traveltime +	studytime +	failures + schoolsup +	famsup +	paid + activities +	nursery +	higher + internet +	romantic + famrel +	freetime +	goout +	Dalc +	Walc +	health +	absences +	G1 + G2

stud_math.tree
plot(stud_math.tree);text(stud_math.tree)#�e�X�M����

summary(stud_math.tree)

#install.packages("gmodels")
library(gmodels)

cat("======�V�m���======","\n")
G3.traindata=stud_math$G3[-test.index]
train.predict=factor(predict(stud_math.tree, stud_math.traindata, type="class"), levels=levels(G3.traindata))
CrossTable(x = G3.traindata, y = train.predict, prop.chisq=FALSE) #�e�XCrossTable
train.corrcet=sum(train.predict==G3.traindata)/length(train.predict)#�V�m��Ƥ����T�v
cat("�V�m��ƥ��T�v",train.corrcet*100,"%\n")

cat("======���ո��======","\n")
G3.testdata=stud_math$G3[test.index]
test.predict=factor(predict(stud_math.tree, stud_math.testdata, type="class"), levels=levels(G3.testdata))
CrossTable(x = G3.testdata, y = test.predict, prop.chisq=FALSE) #�e�XCrossTable
test.correct=sum(test.predict==G3.testdata)/length(test.predict)#���ո�Ƥ����T�v
cat("���ո�ƥ��T�v",test.correct*100,"%\n")