
library(RJDBC)
library(babynames)
library(rbenchmark)


drv <- JDBC("com.mysql.jdbc.Driver", "mysql-connector-java-5.1.36-bin.jar")
    conn <- dbConnect(drv, "jdbc:mysql://localhost:3306/bm", "root", "")


babynames_1m <- as.data.frame(babynames)[1:1e6,]
babynames_10k <- as.data.frame(babynames)[1:1e4,]
babynames_1 <- babynames_1m[1,]


benchmark(
  dbWriteTable(conn, "babynames_10k", babynames_10k, overwrite = TRUE, row.names = FALSE),
  dbWriteTable(conn, "babynames_10k", babynames_10k, overwrite = TRUE, row.names = FALSE),
  dbWriteTable(conn, "babynames_10k", babynames_10k, overwrite = TRUE, row.names = FALSE),
replications = 1, columns = c("test", "elapsed"), order = NULL)
##  elapsed
##1   8.590
##2   8.365
##3   8.188

benchmark(
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
  babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m"),
replications = 1, columns = c("test", "elapsed"), order = NULL)
##                                                                   test elapsed
##1 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   4.616
##2 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   4.124
##3 babynames_1m_fromdb <- dbGetQuery(conn, "select * from babynames_1m")   4.093

all.equal(babynames_1m, babynames_1m_fromdb)


benchmark(
   dbWriteTable(conn, "babynames_1", babynames_1, overwrite = TRUE, row.names = FALSE),
replications = 1000, columns = c("test", "elapsed"))
##  elapsed
##1    13.712

benchmark(
   babynames_1_fromdb <- dbGetQuery(conn, "select * from babynames_1"),
replications = 1000, columns = c("test", "elapsed"))
##                                                                 test elapsed
##1 babynames_1_fromdb <- dbGetQuery(conn, "select * from babynames_1")   3.464

all.equal(babynames_1, babynames_1_fromdb)


