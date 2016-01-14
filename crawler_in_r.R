#==============================================================================
#Facebook
# 用token取得自己fb的名字、居住地
# 用token取得某粉絲團的po文、like、share、comment數
# Rfacebook套件
# wordcloud套件
#Date:2016/01/14
#==============================================================================

library(Rfacebook)
#從此取得token: https://developers.facebook.com/tools/explorer 
token <- "這裡輸入取得之token"

my <- getUsers("me", token, private_info = TRUE)
my$name #顯示自己FB上的名字

my$hometown #顯示自己FB上的家鄉

my_like <- getLikes(user="me",token=token)
fix(my_like) #顯示自己按讚之粉絲團

#以下是有關粉絲專頁的部分
fanpage <- getPage("humansofnewyork", token, n = 100)
#""符號裡面輸入粉絲專頁之名稱，此範例為Humans of New York，n為取得之貼文數

fanpage[which.max(fanpage$likes_count), ]
#取得上述n中，按攢數最多之貼文

#install.packages("wordcloud")
library(wordcloud)

#取得某一段時間（從since到until），某粉絲專頁之貼文
#從此取得某一粉絲專頁的id：https://lookup-id.com/
fb_page1 <- getPage(page="148395741852581", token , since='2016/01/01', until='2016/01/05')

fb_page1 #顯示期間內之貼文：按讚數、留言數、分享數

wordcloud(fb_page1$message , fb_page1$likes_count)#文字雲，以按讚數之大小顯示期間內之貼文

#wordcloud(fb_page1$message , fb_page1$comments_count)#文字雲，以留言數之大小顯示期間內之貼文

write.table(fb_page1, file = "fanpage_results.CSV", sep = ",") #把結果輸出成csv檔，檔名為fanpage_results

getwd()#用此找到當前的工作目錄，可找到上面輸出的fanpage_result.CSV檔案存在哪裡

