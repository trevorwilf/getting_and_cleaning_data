library(tidyr)
library(dplyr)
library(xlsx)
library(XML)
library(httpuv)
library(httr)
setwd("C:\\github\\getting_and_cleaning_data\\data")

#question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "idahohousing_4.csv")
IdahoData <- read.csv("idahohousing_4.csv")
strsplit(names(IdahoData), "wgtp")[123]

#question 2
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "gdp_country_1.csv")
gdpcountry1 <- read.csv("gdp_country_1.csv", skip = 4, skipNul = TRUE, nrow = 216)
gdpcountry <- select(gdpcountry1, X, X.1, X.3, X.4) %>% filter(X.1 != "NA")
gdp <- select(gdpcountry, X.4)
gdp <- gsub(",", "", gdp$X.4)
mean(as.numeric(gdp))

#question 3
grep("^United", gdpcountry$X.3)
#returns 3 rows

#question 4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "gdp_country_5.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "education_country_2.csv")
gdpcountry1 <- read.csv("gdp_country_5.csv", skip = 4, skipNul = TRUE, nrow = 216)
educationcountry <- read.csv("education_country_2.csv")
gdpcountry <- select(gdpcountry1, X, X.1, X.3, X.4) %>% filter(X.1 != "NA")
mergedcountryData <- merge(gdpcountry, educationcountry, by.x = "X", by.y = "CountryCode")
june <- grep("Fiscal year end: June", mergedcountryData$Special.Notes, ignore.case = TRUE)
sum(!is.na(june))
#13

#question 5
install.packages("quantmod")
library(quantmod)
library(lubridate)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes <- index(amzn)
datetable <- data.frame(year = year(sampleTimes), day = weekdays(sampleTimes, abbreviate = FALSE))
y2012 <- filter(datetable, year == "2012")
monday2012 <- filter(y2012, day == "Monday")
sum(!is.na(y2012$year))
sum(!is.na(monday2012$day))
#250, 47


head(2012)



















