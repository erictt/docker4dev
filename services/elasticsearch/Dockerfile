FROM elasticsearch:6.4.1

MAINTAINER Eric Yang "ericyang879@gmail.com"

# Define working directory.
WORKDIR /tmp

# Define default command.
# CMD ["/elasticsearch/bin/elasticsearch"]

ENV IK_VERSION 6.4.1
RUN wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v$IK_VERSION/elasticsearch-analysis-ik-$IK_VERSION.zip
RUN unzip elasticsearch-analysis-ik-$IK_VERSION.zip -d /usr/share/elasticsearch/plugins/ik/
RUN rm -f elasticsearch-analysis-ik-$IK_VERSION.zip

# Mount elasticsearch.yml config
ADD config /usr/share/elasticsearch/config

RUN set -ex \
	&& for path in \
		# /data/elasticsearch \
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

