
time mysql -u root bm -e "delete from babynames_1m"
time mysql --local-infile -u root bm -e "load data local infile '/tmp/babynames_1m.csv' into table babynames_1m fields terminated by ',' enclosed by '\"'"
#real    0m5.803s

time mysql -u root bm -N -e "select * from babynames_1m" > /tmp/babynames_1m_fromdb.csv
#real    0m2.551s

wc -l /tmp/baby*csv
head /tmp/baby*csv

