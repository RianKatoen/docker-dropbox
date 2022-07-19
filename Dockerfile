FROM debian:11

LABEL maintainer "Rian Katoen <riankatoen@gmail.com>"

# Create user and group
RUN useradd --comment "Dropbox Docker Account" --create-home --user-group --shell /bin/bash dropbox

# Volume baby.
VOLUME /home/dropbox

# Create dependencies
RUN  apt-get update \
  && apt-get install -f -y wget gosu \
  && rm -rf /var/lib/apt/lists/*

# Download dropbox Daemon
#USER dropbox
#RUN cd /home/dropbox && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#USER root

# Install init script and dropbox command line wrapper
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

COPY handle-watchman-trigger.sh /
RUN chmod +x /handle-watchman-trigger.sh

COPY watchman-trigger-to-volume.sh /
RUN chmod +x /watchman-trigger-to-volume.sh

# Let's A go!
COPY entrypoint-dropbox.sh /
RUN chown dropbox:dropbox /entrypoint-dropbox.sh
RUN chmod 755 /entrypoint-dropbox.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
