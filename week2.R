#mySQL

install.packages("RMySQL")
library(RMySQL)
ucscDB <- dbConnect(MySQL(), user="genome",
                    host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDB, "show databases;"); dbDisconnect(ucscDB);

hg19 <- dbConnect(MySQL(), user="genome", db="hg19",
                    host="genome-mysql.cse.ucsc.edu"); 
allTables <- dbListTables(hg19)
length(allTables)
dbListFields(hg19, "affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")
affydata <- dbReadTable(hg19, "affyU133Plus2")
head(affydata)

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affymiss <- fetch(query)
quantile(affymiss$misMatches)

#clears the query on the server
dbClearResult(query)
dbDisconnect(hg19)

# R HDF5
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")

A = matrix(1:10, nr=5, nc=2)
h5write(A, "example.h5", "foo/foobaa/A")
B = array(seq(0.1, 2.0, by = 0.1), dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")







