#==============================================================================
#Facebook
# ��token���o�ۤvfb���W�r�B�~���a
# ��token���o�Y�����Ϊ�po��Blike�Bshare�Bcomment��
# Rfacebook�M��
# wordcloud�M��
#Date:2016/01/14
#==============================================================================

library(Rfacebook)
#�q�����otoken: https://developers.facebook.com/tools/explorer 
token <- "�o�̿�J���o��token"

my <- getUsers("me", token, private_info = TRUE)
my$name #��ܦۤvFB�W���W�r

my$hometown #��ܦۤvFB�W���a�m

my_like <- getLikes(user="me",token=token)
fix(my_like) #��ܦۤv���g��������

#�H�U�O���������M��������
fanpage <- getPage("humansofnewyork", token, n = 100)
#""�Ÿ��̭���J�����M�����W�١A���d�Ҭ�Humans of New York�An�����o���K���

fanpage[which.max(fanpage$likes_count), ]
#���o�W�zn���A����Ƴ̦h���K��

#install.packages("wordcloud")
library(wordcloud)

#���o�Y�@�q�ɶ��]�qsince��until�^�A�Y�����M�����K��
#�q�����o�Y�@�����M����id�Ghttps://lookup-id.com/
fb_page1 <- getPage(page="148395741852581", token , since='2016/01/01', until='2016/01/05')

fb_page1 #��ܴ��������K��G���g�ơB�d���ơB���ɼ�

wordcloud(fb_page1$message , fb_page1$likes_count)#��r���A�H���g�Ƥ��j�p��ܴ��������K��

#wordcloud(fb_page1$message , fb_page1$comments_count)#��r���A�H�d���Ƥ��j�p��ܴ��������K��

write.table(fb_page1, file = "fanpage_results.CSV", sep = ",") #�⵲�G��X��csv�ɡA�ɦW��fanpage_results

getwd()#�Φ������e���u�@�ؿ��A�i���W����X��fanpage_result.CSV�ɮצs�b����
