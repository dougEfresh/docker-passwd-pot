#!/bin/bash
set -x
nohup su -s /bin/bash nobody -c "/bin/passwd-pot potter $PASSWD_POT_OPTS" > /var/log/passwd-pot/pot.log &
nohup su -s /bin/bash nobody -c "/bin/passwd-pot proxy $PASSWD_POT_PROXY_OPTS" > /var/log/passwd-pot/proxy.log &
