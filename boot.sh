#!/bin/bash

if [ "$1" == "all" ]; then
    docker-compose run --rm --service-ports all
elif [ "$1" == "python" ]; then
    docker-compose run --rm --service-ports python3
elif [ "$1" == "nodejs" ]; then
    docker-compose run --rm --service-ports nodejs
elif [ "$1" == "elastic" ]; then
    docker-compose run --rm --service-ports kibana
else
    echo "Invalid Parameter -> $1, Only support all|python|nodejs|elastic"
fi
