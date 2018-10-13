Docker for Dev
==============

## Description

* This repository is used to set up a local development environment with docker. Support Python, Nodejs and PHP.
* I assume, there will be lots of projects with different languages. And I want to separate the code with configurations and log files, and take all of the runtime envs as individual services.
* First of all, all of my projects are under the same directory, and i mounted the directory into a common container named `data` and the projects path in the container is `/data/apps/`. And the other mappings are:

  ```
  ./data/scripts:/data/scripts # all of the useful scripts
  ./data/logs:/data/logs # all of the logs should go here
  ./data/demos:/data/demos # there are three demos for PHP/Nodejs/Python
  ./data/conf:/data/conf # the config files for all services
  ```

How to mamange the projects:

  * PHP: every project has an nginx config file under `data/conf/nginx/`. I already wrote a common php7-fpm conf file: `includes/php.conf`. Check `demo.conf` for how to add another project.
  * NodeJS: every nodejs project ocuppys a port, so i use `pm2` to manage the start script. You can check `/data/conf/nodejs8/` for how to add a start script. Please notice that, the script's name should start with `run-`, unless it won't be executed. You can check `services/nodejs8/docker-entrypoint.sh` to see how it works.
  * Python: same as NodeJS, so i use `pm2` to manage the start script. You can check `/data/conf/python3/` for how to add a start script.

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

* Please notice, all the projects will be under path `/data/apps/` in containers, so please put all your repos in the same directory.
* copy file docker-compose.yml.sample to docker-compose.yml, then replace the keyword `LOCAL_REPO_PATH` to your local path, like mine is `/Users/eric/workspace` which will be mapping to `/data/apps/` in all containers.

    PS `:%s/LOCAL_REPO_PATH/\/Users\/eric\/workspace/g`

* You can check nginx configurations which is under `/data/conf/nginx/` for more detail.

### 2. BUILD ALL IMAGES: (path to `docker4dev/`)

* Before you start to build, some informations you should know:

    ```
    mysql: hostname -> mysql, username -> root, password -> mydev
    php7fpm: port -> 9000
    mongo: port -> 27017, hostname -> mongo
    redis: port -> 6379, hostname -> redis
    elasticsearch: port -> 9200/9300, hostname -> elasticsearch
    kibana: port -> 5601
    python3: port -> 5000, 5001
    nodejs8: port -> 3000, 3001
    ```

    * The demos of `python` and `nodejs` already occupied `3000/5000`, but `3001/5001` are free to use.

* Building list:

    * `./build.sh`
    * Alternative:

        ```
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
        ```

### 3. SET ALL THE HOSTNAME IN HOST MACHINE

```
127.0.0.1   dev.local
```

### 4. CREATE VOLUMES

* We are using external volumes, which make it easier to backup and restore data.

    ```
    docker volume create --driver local --name mydev_mysql_data
    docker volume create --driver local --name mydev_redis_data
    docker volume create --driver local --name mydev_mongo_data
    docker volume create --driver local --name mydev_elasticsearch_data
    ```

    * NOTE: These commands are already included in `build.sh`.

### 5. START SERVICES YOU NEED

`./boot.sh nginx` : start nginx, php7-fpm, mysql, mongo, redis. Nginx is listening on 80, and PHP is 9000

`./boot.sh python` : start python 3, mysql, mongo, redis. Listening on 5000, 5001

`./boot.sh nodejs` : start nodejs 8, mysql, mongo, redis, Listening on 3000, 3001

`./boot.sh elastic` : start elasticsearch and kibana, and the monitoring page: (`http://localhost:5601/app/monitoring`), the initialized username/password is: `elastic/changeme`

## ROADMAP

* [x] Initial the basic images of nginx, php7fpm, mariadb, mongodb, redis, elasticsearch.
* [x] Support Python and Nodejs development.
* [x] Add `build.sh` to build all images easily.
* [x] Add `boot.sh` to boot containers easily.
