#!/bin/bash
chown -R dropbox:dropbox /home/dropbox
chmod -R 755 /home/dropbox

gosu dropbox /entrypoint-dropbox.sh & export DROPBOX_PID="$!"
trap "/bin/kill -SIGQUIT ${DROPBOX_PID}" INT

# Wait a few seconds for the Dropbox daemon to start
sleep 60

# Dropbox likes to restart itself. In that case, the container will exit!
while kill -0 ${DROPBOX_PID} 2> /dev/null; do
  [ -d "/proc/${DROPBOX_PID}" ] && [ -f "/home/dropbox/.dropbox/info.json" ] && gosu dropbox /home/dropbox/.dropbox-dist/dropboxd status
  /usr/bin/find /tmp/ -maxdepth 1 -type d -mtime +1 ! -path /tmp/ -exec rm -rf {} \;
  /bin/sleep 60
done

