
### Benchmarking R MySQL Data Exchange


#### Time

Action                     |  RMySQL | RMySQL-dev | mysql CL | RJDBC | RODBC | dplyr
---------------------------|---------|------------|----------|-------|-------|------
Insert 1M rows [s]         |   12    |    800*    |    6     | 900*  |  800* | 10
Read 1M rows [s]           |   2.4   |     1      |    2.5   |  3.4  |  2.7  | 2.2
Insert 1 row [ms]          |    5    |     4      |          |  12** |   6   | 13**
Read 1 row [ms]            |   0.4   |    0.4     |          |   3.5 |   0.5 | 0.6

[*] CRAN RMySQL uses `LOAD DATA` for inserts and for 1M (million) rows is 100x faster than
RJDBC/RODBC and RMySQL-dev (the later ones probably inserting 1 row at a time)

[**] RJDBC bug? cannot do `append = TRUE`, while dplyr will create new (temporary) table
by design

#### RAM usage

While reading the 1M rows dataset RAM goes up to a max value (RAM_max), then goes down
and finally after a `gc()` call reaches RAM_after. Here is RAM/object.size:

Tool     |  RAM_max |   RAM_after
---------|----------|------------
RMySQL   |     2    |     1
RJDBC    |     8    |     7.5
RODBC    |     5    |     3.5


#### Versions

```
2015-07-04
R 3.2.1
mysql-server 5.5.43
DBI 0.3.1
RMySQL 0.10.3
RMySQL-dev 9fb0f8685a3 (with corresponding DBI)
RJBC 0.2-5 / mysql-connector-java-5.1.36
RODBC 1.3-12 / libmyodbc 5.1.10-3 / unixodbc-dev 2.2.14p2
dplyr 0.4.2
```

