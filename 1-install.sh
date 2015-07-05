
Ubuntu Server 14.04 LTS (HVM), SSD Volume Type - ami-5189a661

m4.xlarge



sudo apt-get update
sudo apt-get install mysql-server libmysqlclient-dev htop
## Setting up mysql-server-5.5 (5.5.43-0ubuntu0.14.04.1) 

mysql -u root -e "create database bm"



sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu trusty/" > /etc/apt/sources.list.d/r.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo apt-get update 
sudo apt-get install r-base-dev libcurl4-openssl-dev libxml2-dev
## Setting up r-base-core (3.2.1-3trusty0) 

sudo R --vanilla << EOF
install.packages(c("RMySQL","devtools","rbenchmark","readr"), repos = "http://cran.rstudio.com")
devtools::install_github("hadley/babynames")
EOF
## trying URL 'http://cran.rstudio.com/src/contrib/RMySQL_0.10.3.tar.gz'



sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java7-installer

sudo R CMD javareconf 

sudo R --vanilla << EOF
install.packages(c("RJDBC"), repos = "http://cran.rstudio.com")
EOF

wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.36.tar.gz
tar xzf mysql-connector-java-5.1.36.tar.gz 
cp mysql-connector-java-5.1.36/mysql-connector-java-5.1.36-bin.jar .



devtools::install_github("rstats-db/DBI")
devtools::install_github("rstats-db/RMySQL")





