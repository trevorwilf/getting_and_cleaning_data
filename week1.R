library(tidyr)
library(dplyr)
library(xlsx)
library(XML)
setwd("C:\\github\\getting_and_cleaning_data\\data")
# Question 1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "idahohousing.csv")
IdahoData <- read.csv("idahohousing.csv")
idahotbl <- tbl_df(IdahoData)
overmill <- select(idahotbl, VACS:VAL)
filter(overmill, VAL == 24) %>% summarize(n())

#answer 53

#Question 3
#need to set mode or else it fails
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx", "natgas.xlsx", mode='wb')
colIndex=7:15
rowIndex=18:23
dat <- read.xlsx("natgas.xlsx", sheetIndex = 1, colIndex=colIndex, rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T)

#answer 36534720

#question 4
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml", "baltrest.xml")
doc <- xmlTreeParse("baltrest.xml", useInternalNodes = TRUE)
#rootnode <- xmlRoot(doc)
zips <- xpathSApply(doc, "//zipcode", xmlValue)
zipstbl <- tbl_df(as.data.frame(zips))
filter(overmill, zips == 21231) %>% summarize(n())

#question 5
#using RROL may have skewed results
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", "idahohousing_2.csv")
IdahoData <- read.csv("idahohousing_2.csv")
require(data.table)
DT <- fread("idahohousing_2.csv", sep = ",", header = TRUE)
#having a problem generating time on this
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))

library(rbenchmark)
#benchmark(mean(DT$pwgtp15,by=DT$SEX))
benchmark(sapply(split(DT$pwgtp15,DT$SEX),mean), replications = 1000)
benchmark(DT[,mean(pwgtp15),by=SEX], replications = 1000)
benchmark(tapply(DT$pwgtp15,DT$SEX,mean), replications = 1000)

library(microbenchmark)
microbenchmark(sapply(split(DT$pwgtp15,DT$SEX),mean))
microbenchmark(DT[,mean(pwgtp15),by=SEX])
microbenchmark(tapply(DT$pwgtp15,DT$SEX,mean), unit = microseconds)



