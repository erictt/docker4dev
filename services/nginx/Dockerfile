FROM debian:jessie

MAINTAINER Eric Yang "ericyang879@gmail.com"

# Install Nginx
RUN apt-get update \
    && apt-get install -y nginx
RUN rm -rf /var/lib/apt/lists/*

# Nginx config
RUN rm /etc/nginx/sites-enabled/default

ADD etc /etc/

RUN mkdir -p /data/conf/nginx /data/http /data/logs/nginx
# VOLUME /data/logs/nginx /data/html /data/conf/nginx

EXPOSE 80 443

CMD ["nginx"]
