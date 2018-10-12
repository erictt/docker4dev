FROM debian:jessie

MAINTAINER Eric Yang "ericyang879@gmail.com"

RUN apt-get update \
    && apt-get install -y mysql-client

ENTRYPOINT ["/usr/bin/mysql"]
