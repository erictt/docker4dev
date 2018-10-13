#!/bin/bash

PREFIX="mydev"

docker pull phpmyadmin/phpmyadmin
docker pull mongo:3

docker build -t ${PREFIX}/data ./data
docker build -t ${PREFIX}/nginx ./services/nginx/
docker build -t ${PREFIX}/php7fpm ./services/php7fpm/
docker build -t ${PREFIX}/python3 ./services/python3/
docker build -t ${PREFIX}/nodejs8 ./services/nodejs8/
docker build -t ${PREFIX}/redis ./services/redis/
docker build -t ${PREFIX}/mariadb ./services/mariadb/

docker build -t ${PREFIX}/mysql-cli ./tools/mysql-cli/
docker build -t ${PREFIX}/elasticsearch ./services/elasticsearch/
docker build -t ${PREFIX}/kibana ./services/kibana/

docker volume create --driver local --name ${PREFIX}_mysql_data
docker volume create --driver local --name ${PREFIX}_redis_data
docker volume create --driver local --name ${PREFIX}_mongo_data
docker volume create --driver local --name ${PREFIX}_elasticsearch_data
