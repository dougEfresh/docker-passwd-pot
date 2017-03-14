#!/bin/bash
set -x
nohup su -s /bin/bash nobody -c "/go/bin/http-passwd-pot $HTTP_PASSWD_POT_OPTS" > /http-passwd-pot.log &
