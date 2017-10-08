FROM dougefresh/sshd-passwd-pot:6ccc8982cfb1394f0d6f60b50c466621118fdacf
ENV PASSWD_POT_OPTS --bind 0.0.0.0 --all --dry-run --debug --syslog 172.17.0.1:514
ENV PASSWD_POT_SOCKET_OPTS --dry-run --debug  --syslog 172.17.0.1:514
ENV SSHD_OPTS -o Audit=yes -o AuditSocket=/tmp/pot.socket -o AuditUrl=http://localhost/

EXPOSE 2222
EXPOSE 8000
EXPOSE 2121
EXPOSE 1110
EXPOSE 5432

COPY *wrapper.sh /docker-entrypoint.d/
COPY passwd-pot /bin

