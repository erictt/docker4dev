FROM node:8

WORKDIR /data

# Create app directory
RUN mkdir -p /data/logs/nodejs /data/html

# CMD [ "npm", "run", "dev4docker"]
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["docker-entrypoint.sh"]

