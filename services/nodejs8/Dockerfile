FROM node:8

WORKDIR /data

# Create app directory
RUN mkdir -p /data/logs/nodejs /data/apps

# Install latest pm2 version
RUN npm install pm2 -g
# Save process list, exit old PM2 & restore all processes
RUN pm2 update

# CMD [ "npm", "run", "dev4docker"]
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3000

ENTRYPOINT ["docker-entrypoint.sh"]

