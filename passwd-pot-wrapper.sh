#!/bin/bash
set -x
/usr/local/go/bin/go get -v  github.com/dougEfresh/passwd-pot
/usr/local/go/bin/go install github.com/dougEfresh/passwd-pot
nohup su -s /bin/bash nobody -c "/go/bin/passwd-pot potter $PASSWD_POT_OPTS" > /passwd-pot.log &

nohup su -s /bin/bash nobody -c "/go/bin/passwd-pot socket $PASSWD_POT_SOCKET_OPTS" > /passwd-pot-socket.log &
