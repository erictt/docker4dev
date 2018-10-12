Docker for Dev
==============

## Description

This repository is used to set up a local development environment with docker.

### Directory Structure

  ```
  data/
      conf/
      elasticsearch/
      logs/ // keep most of the logs out of the containers
      storage/ // database files
  services/
      elasticsearch/
      kibana/ interface for elasticsearch
      mariadb/
      nginx/
      php7fpm/
      redis/
  tools/
      mysql-cli/
  ```

## GET START

### 0. PREPARES

* Install Docker.
* Pull this repo from github.
* `cd /path/to/docker4dev/`

### 1. SET UP PROJECT PATHS

* All the projects will be under path `/data/html/nytimes/` in containers, so please put all your nytimes repos in the same directory.
* copy file docker-compose.yml.sample to docker-compose.yml, then replace the keyword `LOCAL_REPO_PATH` to your local path, like mine is `/Users/eric/mydev/apps`.

    PS `:%s/LOCAL_REPO_PATH/\/Users\/eric\/workspace/g`

* You can check nginx configurations which is under `/data/conf/nginx/` for more detail.

### 2. BUILD ALL IMAGES: (path to `docker4dev/`)

* Before you start to build, some informations you should know:

        mysql: hostname -> mysql, username -> root, password -> mydev
        php5fpm: port -> 9000
        mongo: port -> 27017, hostname -> mongo
        redis: port -> 6379, hostname -> redis
        elasticsearch: port -> 9200/9300, hostname -> elasticsearch
        kibana: port -> 5601

* Building list:

        docker pull phpmyadmin/phpmyadmin
        docker pull mongo:3

        docker build -t mydev/data ./data
        docker build -t mydev/nginx ./services/nginx/
        docker build -t mydev/php5fpm ./services/php5fpm/
        docker build -t mydev/redis ./services/redis/
        docker build -t mydev/mariadb ./services/mariadb/

        docker build -t mydev/mysql-cli ./tools/mysql-cli/
        docker build -t mydev/elasticsearch ./services/elasticsearch/
        docker build -t mydev/kibana ./services/kibana/

### 3. SET ALL THE HOSTNAME IN HOST MACHINE

        127.0.0.1   dev.local

### 4. CREATE VOLUMES

* We are using external volumes, which make it easier to backup and restore data.

        docker volume create --driver local --name mydev_mysql_data
        docker volume create --driver local --name mydev_redis_data
        docker volume create --driver local --name mydev_mongo_data
        docker volume create --driver local --name mydev_elasticsearch_data

### 5. IMPORT MYSQL DATABSES

* There are two ways to import mysql database.

1. restore from tar file. plase check [NOTE.md#restore-volumes](https://github.com/erictt/docker4dev/blob/master/NOTE.md#restore-volumes) to continue.

2. manually

    1. login database

        bash$ cd path/to/this/repo
        bash$ `docker-compose run --rm mysql`

    2. import database

        bash$ `docker exec -it [db_container_id] /bin/bash`
        bash# `/data/scripts/mysql/import_db.sh -c db_name /path/to/sqlfile.sql` // `-c` means it will create database automatically

    3. exist bash

### 6. START SERVICES YOU NEED

`docker-compose run --service-ports all` : start nginx, php5fpm, mysql, mongo, redis

`docker-compose run --rm --service-ports kibana` : start elasticsearch and kibana, and the monitoring page: (`http://localhost:5601/app/monitoring`), the initialized username/password is: `elastic/changeme`

### ROADMAP

* [x] Initial the basic images of nginx, php7fpm, mariadb, mongodb, redis, elasticsearch.
* [ ] Use [`baseimage-docker`](https://github.com/phusion/baseimage-docker) to rebuild all the  the base docker image
* [ ] Add `boot.sh` to boot containers easily.
* [ ] Add `build.sh` to build all images easily.
