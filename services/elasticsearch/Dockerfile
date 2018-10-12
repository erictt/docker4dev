FROM elasticsearch:5

MAINTAINER Eric Yang "ericyang879@gmail.com"

# Define working directory.
WORKDIR /tmp

# Define default command.
# CMD ["/elasticsearch/bin/elasticsearch"]
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install x-pack

ENV IK_VERSION 5.2.0
RUN wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v$IK_VERSION/elasticsearch-analysis-ik-$IK_VERSION.zip
RUN unzip elasticsearch-analysis-ik-$IK_VERSION.zip -d /usr/share/elasticsearch/plugins/ik/
RUN rm -f elasticsearch-analysis-ik-$IK_VERSION.zip

# Mount elasticsearch.yml config
# This is a tricky problem, x-pack configuration path is /etc/elasticsearch/ which follow the offical document,
# but elasticsearch configuration path is /usr/share/elasticsearch/config. I've asked this issue in Github, still waiting for the answer.
# for now, just put them under both paths.
ADD config /usr/share/elasticsearch/config
ADD config /etc/elasticsearch

RUN set -ex \
	&& for path in \
		# /data/elasticsearch \
        /etc/elasticsearch \
        /data/logs/elasticsearch \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done

CMD ["elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

