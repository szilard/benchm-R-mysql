
library(RMySQL)
library(babynames)
library(rbenchmark)

conn <- dbConnect(MySQL(), host = "localhost", user = "root", password = "", dbname = "bm")

babynames_1m <- as.data.frame(babynames)[1:1e6,]

benchmark(
  dbWriteTable(conn, "babynames_1m", babynames_1m, overwrite = TRUE, row.names = FALSE),
  dbWriteTable(conn, "babynames_1m", babynames_1m, overwrite = TRUE, row.names = FALSE),
  dbWriteTable(conn, "babynames_1m", babynames_1m, overwrite = TRUE, row.names = FALSE),
replications = 1, columns = c("test", "elapsed"), order = NULL)
##  elapsed
##1  10.992
##2  11.057
##3  11.126

benchmark(
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
replications = 1, columns = c("test", "elapsed"), order = NULL)
##                                                                   test elapsed
##1 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   1.785
##2 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   1.785
##3 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   1.784

all.equal(babynames_1m, babynames_1m_fromdb)

benchmark(
   dbWriteTable(conn, "mtcars", mtcars, overwrite = TRUE, row.names = FALSE),
replications = 1000, columns = c("test", "elapsed"))
##  elapsed
##1    16.2

benchmark(
   mtcars_fromdb <- dbGetQuery(conn, "select * from mtcars"),
replications = 10000, columns = c("test", "elapsed"))
##                                                       test elapsed
##1 mtcars_fromdb <- dbGetQuery(conn, "select * from mtcars")   4.774


