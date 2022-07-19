FROM debian:11

# It's A Me!
LABEL maintainer "Rian Katoen <riankatoen@gmail.com>"

# Create user and group
RUN useradd --comment "Dropbox Docker Account" --create-home --user-group --shell /bin/bash dropbox

# Volume baby.
VOLUME /home/dropbox

# Create dependencies
RUN  apt-get update \
  && apt-get install -f -y wget gosu \
  && rm -rf /var/lib/apt/lists/*

# Install init script and dropbox command line wrapper
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

# Commands for the dropbox user and daemon 
COPY entrypoint-dropbox.sh /
RUN chown dropbox:dropbox /entrypoint-dropbox.sh
RUN chmod 755 /entrypoint-dropbox.sh

# Let's A Go!
ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
