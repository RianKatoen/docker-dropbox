#!/bin/bash
if [[ ! -d "/home/dropbox/.dropbox-dist" ]]
then
 cd /home/dropbox && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
fi

cd /home/dropbox
/home/dropbox/.dropbox-dist/dropboxd
