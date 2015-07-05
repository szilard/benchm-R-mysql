
library(RODBC)
library(babynames)
library(rbenchmark)

conn <- odbcDriverConnect("DSN=mysql")


babynames_1m <- as.data.frame(babynames)[1:1e6,]
babynames_10k <- as.data.frame(babynames)[1:1e4,]
babynames_1 <- babynames_1m[1,]


benchmark(
  {sqlDrop(conn, "babynames_10k"); sqlSave(conn, babynames_10k, "babynames_10k", rownames = FALSE)},
  {sqlDrop(conn, "babynames_10k"); sqlSave(conn, babynames_10k, "babynames_10k", rownames = FALSE)},
  {sqlDrop(conn, "babynames_10k"); sqlSave(conn, babynames_10k, "babynames_10k", rownames = FALSE)},
replications = 1, columns = c("test", "elapsed"), order = NULL)
#  elapsed
#1  11.547
#2  11.656
#3  12.787

benchmark(
  babynames_1m_fromdb <- sqlQuery(conn, "select * from babynames_1m"),
  babynames_1m_fromdb <- sqlQuery(conn, "select * from babynames_1m"),
  babynames_1m_fromdb <- sqlQuery(conn, "select * from babynames_1m"),
replications = 1, columns = c("test", "elapsed"), order = NULL)
##                                                                 test elapsed
##1 babynames_1m_fromdb <- sqlQuery(conn, "select * from babynames_1m")   3.424
##2 babynames_1m_fromdb <- sqlQuery(conn, "select * from babynames_1m")   3.431
##3 babynames_1m_fromdb <- sqlQuery(conn, "select * from babynames_1m")   3.447

all.equal(babynames_1m, babynames_1m_fromdb)
#[1] "Component “sex”: Modes: character, numeric"                       
#[2] "Component “sex”: Attributes: < target is NULL, current is list >" 
#[3] "Component “sex”: target is character, current is factor"          
#[4] "Component “name”: Modes: character, numeric"                      
#[5] "Component “name”: Attributes: < target is NULL, current is list >"
#[6] "Component “name”: target is character, current is factor"  
sapply(babynames_1m, class)
#       year         sex        name           n        prop 
#  "numeric" "character" "character"   "integer"   "numeric" 
sapply(babynames_1m_fromdb, class)
#     year       sex      name         n      prop 
#"numeric"  "factor"  "factor" "integer" "numeric" 


benchmark(
   {sqlDrop(conn, "babynames_1"); sqlSave(conn, babynames_1, "babynames_1", rownames = FALSE)},
   {sqlDrop(conn, "babynames_1"); sqlSave(conn, babynames_1, "babynames_1", rownames = FALSE)},
   {sqlDrop(conn, "babynames_1"); sqlSave(conn, babynames_1, "babynames_1", rownames = FALSE)},
replications = 1000, columns = c("test", "elapsed"))
#  elapsed
#1  14.641
#2  14.912
#3  14.706

benchmark(
   babynames_1_fromdb <- sqlQuery(conn, "select * from babynames_1"),
replications = 10000, columns = c("test", "elapsed"))
#                                                               test elapsed
#1 babynames_1_fromdb <- sqlQuery(conn, "select * from babynames_1")  13.051

all.equal(babynames_1, babynames_1_fromdb)


