#!/bin/bash

cd /data/demos/python3

mkdir -p /tmp/python-env/demoenv
virtualenv /tmp/python-env/demoenv

pip install --no-cache-dir -r requirements.txt

FLASK_ENV=development FLASK_APP=run.py flask run -h 0.0.0.0 -p 5000
