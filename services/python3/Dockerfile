FROM python:3

WORKDIR /data

COPY docker-entrypoint.sh /usr/local/bin/

RUN pip install virtualenv

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 5000 5001

ENTRYPOINT ["docker-entrypoint.sh"]

