Docker for Dev
==============

## Description

This repository is used to set up a local development environment with docker. Support Python, Nodejs and PHP.

### Directory Structure

  ```
  data/
      conf/
      demos/ # includes PHP, Python and Nodejs demos for first launch
      logs/ # keep most of the logs out of the containers
      scripts/ # store all of the scripts files here will be able to accessed from all containers
  services/
      elasticsearch/
      kibana/ # data visualization plugin for Elasticsearch
      mariadb/
      nginx/
      nodejs8/
      php7fpm/
      python3/
      redis/
  tools/
      mysql-cli/
  docker-compose.yml
  NOTE.md # some useful commands
  ```

## GET START

### 0. PREPARES

* Install Docker.
* Pull this repo from github.
* `cd /path/to/docker4dev/`

### 1. SET UP PROJECT PATHS

* Please notice, all the projects will be under path `/data/html/` in containers, so please put all your repos in the same directory.
* copy file docker-compose.yml.sample to docker-compose.yml, then replace the keyword `LOCAL_REPO_PATH` to your local path, like mine is `/Users/eric/workspace` which will be mapping to `/data/html/` in all containers.

    PS `:%s/LOCAL_REPO_PATH/\/Users\/eric\/workspace/g`

* You can check nginx configurations which is under `/data/conf/nginx/` for more detail.

### 2. BUILD ALL IMAGES: (path to `docker4dev/`)

* Before you start to build, some informations you should know:

        mysql: hostname -> mysql, username -> root, password -> mydev
        php7fpm: port -> 9000
        mongo: port -> 27017, hostname -> mongo
        redis: port -> 6379, hostname -> redis
        elasticsearch: port -> 9200/9300, hostname -> elasticsearch
        kibana: port -> 5601
        python3: port -> 5000, 5001
        nodejs8: port -> 3000, 3001

    * `python` and `nodejs` have demos already occupied `3000/5000`, and `3001/5001` are free to use.

* Building list:

    * `./build.sh`
    * Alternative:

        docker pull phpmyadmin/phpmyadmin
        docker pull mongo:3

        docker build -t mydev/data ./data
        docker build -t mydev/nginx ./services/nginx/
        docker build -t mydev/php7fpm ./services/php7fpm/
        docker build -t mydev/python3 ./services/python3/
        docker build -t mydev/nodejs8 ./services/nodejs8/
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

    * NOTE: These commands already are included in `build.sh`.

### 5. START SERVICES YOU NEED

`./boot.sh all` : start nginx, php7fpm, mysql, mongo, redis

`./boot.sh python` : start python 3, mysql, mongo, redis, listen on 5000, 5001

`./boot.sh nodejs` : start nodejs 8, mysql, mongo, redis, listen on 3000, 3001

`./boot.sh elastic` : start elasticsearch and kibana, and the monitoring page: (`http://localhost:5601/app/monitoring`), the initialized username/password is: `elastic/changeme`

### ROADMAP

* [x] Initial the basic images of nginx, php7fpm, mariadb, mongodb, redis, elasticsearch.
* [x] Support Python and Nodejs development.
* [x] Add `build.sh` to build all images easily.
* [x] Add `boot.sh` to boot containers easily.
