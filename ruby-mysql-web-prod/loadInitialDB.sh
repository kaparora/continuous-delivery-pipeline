#! /bin/bash
source database.config
MYSQL_HOST=`docker inspect --format '{{ .NetworkSettings.IPAddress }}' rubymysqlwebprod_mysql_db_prod_1`
git clone https://github.com/datacharmer/test_db.git
cd test_db
mysql -h $MYSQL_HOST --user=root --password=$PASSWORD  < employees.sql
cd ..
rm -rf test_db


