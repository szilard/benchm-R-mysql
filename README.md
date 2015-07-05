
### Benchmarking R MySQL Data Exchange


Action                     |  RMySQL | RMySQL-dev | mysql CL | RJDBC | RODBC
---------------------------|---------|------------|----------|-------|-------
Insert 1 mil rows [sec]    |   11    |    1100    |    5     |   900 |  1100
Read 1 mil rows [sec]      |   1.8   |     0.6    |    2.3   |    4  |   3.4
Insert 1 row [ms]          |    15   |    15      |          |  13   |   14
Read 1 row [ms]            |   0.4   |    0.4     |          |   3   |   1.3

Insert 1 mil rows uses `LOAD DATA` for CRAN RMySQL and is 100x faster than
RJDBC/RODBC and RMySQL-dev!


