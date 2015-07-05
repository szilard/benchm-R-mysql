
library(RMySQL)
library(babynames)
library(rbenchmark)

conn <- dbConnect(MySQL(), host = "localhost", user = "root", password = "", dbname = "bm")

babynames_1m <- as.data.frame(babynames)[1:1e6,]
babynames_10k <- as.data.frame(babynames)[1:1e4,]
babynames_1 <- babynames_1m[1,]


benchmark(
  dbWriteTable(conn, "babynames_10k", babynames_10k, overwrite = TRUE, row.names = FALSE),
  dbWriteTable(conn, "babynames_10k", babynames_10k, overwrite = TRUE, row.names = FALSE),
  dbWriteTable(conn, "babynames_10k", babynames_10k, overwrite = TRUE, row.names = FALSE),
replications = 1, columns = c("test", "elapsed"), order = NULL)
##  elapsed
##1   11.73
##2   11.59
##3   11.42


benchmark(
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
replications = 1, columns = c("test", "elapsed"), order = NULL)
##                                                                   test elapsed
##1 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   0.601
##2 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   0.580
##3 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   0.570

all.equal(babynames_1m, babynames_1m_fromdb)



benchmark(
   dbWriteTable(conn, "babynames_1", babynames_1, overwrite = TRUE, row.names = FALSE),
replications = 1000, columns = c("test", "elapsed"))
##  elapsed
##1    14.752

benchmark(
   babynames_1_fromdb <- dbGetQuery(conn, "select * from babynames_1"),
replications = 10000, columns = c("test", "elapsed"))
##                                                                 test elapsed
##1 babynames_1_fromdb <- dbGetQuery(conn, "select * from babynames_1")   4.287

all.equal(babynames_1, babynames_1_fromdb)


