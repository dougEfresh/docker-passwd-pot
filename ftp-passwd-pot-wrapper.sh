#!/bin/bash
set -x
nohup su -s /bin/bash nobody -c "/go/bin/ftp-passwd-pot $FTP_PASSWD_POT_OPTS" > /ftp-passwd-pot.log &
