library(tidyr)
library(dplyr)
library(xlsx)
library(XML)
library(httpuv)
library(httr)

setwd("C:\\github\\getting_and_cleaning_data\\data")


# question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "idahohousing_3.csv")
IdahoData <- read.csv("idahohousing_3.csv")
crit <- select(IdahoData, ACR:AGS)
which(crit$ACR == 3 & crit$AGS == 6)
# 125,238,262

# question 2
install.packages("jpeg")
library(jpeg)
# have to specify wb for binary 
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "instructor.jpg", mode = "wb")
instructor <- readJPEG("instructor.jpg", native = TRUE)
quantile(instructor, probs = seq(.3, .8, .1))
#-15259150 -10575416


# question 3
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv ", "gdp_country.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv ", "education_country.csv")
gdpcountry1 <- read.csv("gdp_country.csv", skip = 4, skipNul = TRUE, nrow = 216)
educationcountry <- read.csv("education_country.csv")
gdpcountry <- select(gdpcountry1, X, X.1, X.3, X.4) %>% filter(X.1 != "NA")
mergedcountryData <- merge(gdpcountry, educationcountry, by.x = "X", by.y = "CountryCode")
select(mergedcountryData, X, Short.Name, X.1) %>% arrange(desc(X.1))

#question 4
#using the same data from question 3
#4.1
nonOECD <- select(mergedcountryData, X, Short.Name, X.1, Income.Group) %>% arrange(X.1) %>% filter(Income.Group == "High income: nonOECD")
OECD <- select(mergedcountryData, X, Short.Name, X.1, Income.Group) %>% arrange(X.1) %>% filter(Income.Group == "High income: OECD")
sum(nonOECD$X.1)/nrow(nonOECD)
sum(OECD$X.1)/nrow(OECD)
#4.2
mean(nonOECD$X.1)
mean(OECD$X.1)
#4.3 easiest way
group_by(mergedcountryData, Income.Group) %>% summarize(mean(X.1))
#32.96667, 91.91304


#question 5

group_by(mergedcountryData, Income.Group) %>% filter(X.1 <= 38) %>% summarise(sum(!is.na(X.1)))
#5











