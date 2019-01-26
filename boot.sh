#!/bin/bash

if [ "$1" == "nginx" ]; then
    docker-compose run --rm --service-ports nginx
elif [ "$1" == "python" ]; then
    docker-compose run --rm --service-ports python3
elif [ "$1" == "nodejs" ]; then
    docker-compose run --rm --service-ports nodejs
elif [ "$1" == "elastic" ]; then
    docker-compose run --rm --service-ports kibana
elif [ "$1" == "db" ]; then
    docker-compose run -d --rm --service-ports mongo
    docker-compose run -d --rm --service-ports redis
    docker-compose run -d --rm --service-ports mysql
    echo "Mysql, MongoDB, and MongoDB are runing in daemon mode."
else
    echo "Invalid Parameter -> $1, Only support nginx|python|nodejs|elastic"
fi
