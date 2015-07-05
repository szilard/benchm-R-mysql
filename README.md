
### Benchmarking R MySQL Data Exchange


Insert 1 million rows:

RMySQL 11 sec, mysql CL 5 sec - diff: RMySQL writes a csv file first (what else?)


Read 1 mil rows:

RMySQL 1.8 sec, mysql CL 2.3 - diff: CL dumps the binary data to csv (vs unserialize into R for RMySQL)



Write 1 row:

RMySQL: 15 ms (millisec) including overwrite table


Read 1 row:

RMySQL 0.4 ms

