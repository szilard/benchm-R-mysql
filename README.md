
### Benchmarking R MySQL Data Exchange


Action                     |  RMySQL | RMySQL-dev | mysql CL | RJDBC | RODBC | dplyr
---------------------------|---------|------------|----------|-------|-------|------
Insert 1M rows [s]         |   12    |    800*    |    6     | 900*  |  800* | 10
Read 1M rows [s]           |   2.4   |     1      |    2.5   |  3.4  |  2.7  | 2.2
Insert 1 row [ms]          |    5    |     4      |          |  12** |   6   | 13**
Read 1 row [ms]            |   0.4   |    0.4     |          |   3.5 |   0.5 | 0.6

* CRAN RMySQL uses `LOAD DATA` for inserts and for 1M (million) rows is 100x faster than
RJDBC/RODBC and RMySQL-dev (the later ones probably inserting 1 row at a time)

** RJDBC bug? cannot do `append = TRUE`, while dplyr will create new (temporary) table


