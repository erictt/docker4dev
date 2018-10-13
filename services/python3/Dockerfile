FROM python:3

WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/

# Install pm2
RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs npm
RUN apt-get install -y build-essential
RUN rm -rf /var/lib/apt/lists/*
RUN npm install pm2 -g
RUN pm2 update

RUN pip install virtualenv

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 5000 5001

ENTRYPOINT ["docker-entrypoint.sh"]

