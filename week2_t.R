library(tidyr)
library(dplyr)
library(xlsx)
library(XML)
setwd("C:\\github\\getting_and_cleaning_data\\data")

#question 1
install.packages("httpuv")
library(httpuv)
library(httr)

# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at at
#    https://github.com/settings/applications. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("github",
                   key = "87a0ddeb3b412b13977d",
                   secret = "4d30075da74ba6d522adccc58306d5cc933886a5")

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
test <- content(req)
list(test[[6]]$name, test[[6]]$created_at)

#will bring it up in browser
BROWSE("https://api.github.com/users/jtleek/repos")

# OR:
req <- with_config(gtoken, GET("https://api.github.com/users/jtleek/repos"))
stop_for_status(req)
content(req)



#Question 2
install.packages("sqldf")
library(sqldf)
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "ACS.csv")
acs <- read.csv("acs.csv")
sqldf("select pwgtp1 from acs where AGEP < 50")

#questio 3
sqldf("select distinct AGEP from acs")

# question 4
library(httr)
download.file("http://biostat.jhsph.edu/~jleek/contact.html", "contact.txt")
tenline <- scan("contact.txt", '', skip = 9, nlines = 1, sep = '\n')
twentyline <- scan("contact.txt", '', skip = 19, nlines = 1, sep = '\n')
thirtyline <- scan("contact.txt", '', skip = 29, nlines = 1, sep = '\n')
hundredline <- scan("contact.txt", '', skip = 99, nlines = 1, sep = '\n')
nchar(tenline)
nchar(twentyline)
nchar(thirtyline)
nchar(hundredline)

#question 5
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for", "quiz2.quest5.txt")
a <- read.fwf("quiz2.quest5.txt", skip = 4, widths = c(12, 7, 4, 9,4,9,4,9,4))
sum(a$V4) + sum(a$V9)
