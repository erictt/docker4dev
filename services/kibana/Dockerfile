FROM kibana:5

MAINTAINER Eric Yang "ericyang879@gmail.com"

# Define mountable directories.
# VOLUME ["/data"]

# Define working directory.
# WORKDIR /usr/share/kibana

# Define default command.
RUN /usr/share/kibana/bin/kibana-plugin install x-pack

# Mount elasticsearch.yml config
ADD config /etc/kibana

CMD ["kibana"]

# Expose ports.
EXPOSE 5601

