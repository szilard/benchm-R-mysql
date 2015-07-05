
### Benchmarking R MySQL Data Exchange


##### Insert 1 million rows:

RMySQL 11 sec, mysql CL 5 sec - diff: RMySQL writes a csv file first (what else?)

RJDBC runs 9 sec for 10K rows (about 100x slower!!) - must be inserting 1 row at a time??

RMySQL-dev also 100x slower!! (11 sec for 10K rows), see earlier github issue updated
https://github.com/rstats-db/RMySQL/issues/71


##### Read 1 mil rows:

RMySQL 1.8 sec, mysql CL 2.3 - diff: CL dumps the binary data to csv (vs unserialize into R for RMySQL)

RJDBC 4 sec (also `all.equal` show `1e-7` diff in floats!)

RMySQL-dev 0.6 sec



##### Write 1 row:

RMySQL: 15 ms (millisec) including overwrite table

RJDBC 13 ms 

RMySQL-dev 15 ms


##### Read 1 row:

RMySQL 0.4 ms

RJDBC 3 ms (10x slower)

RMySQL-dev 0.4 ms

