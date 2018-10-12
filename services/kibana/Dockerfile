FROM kibana:6.4.1

MAINTAINER Eric Yang "ericyang879@gmail.com"

# Define mountable directories.
# VOLUME ["/data"]

# Define working directory.
# WORKDIR /usr/share/kibana

# Mount elasticsearch.yml config
ADD config /etc/kibana

CMD ["kibana"]

# Expose ports.
EXPOSE 5601

