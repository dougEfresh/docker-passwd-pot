FROM dougefresh/sshd-passwd-pot:185e52b81f8dffcba7333e296a3fab16738dc6a4

ENV PASSWD_POT_OPTS --bind 0.0.0.0 --all --dry-run --debug --syslog 172.17.0.1:514
ENV PASSWD_POT_SOCKET_OPTS --debug --bind localhost:8889 --dry-run  --syslog 172.17.0.1:514
ENV SSHD_OPTS -o Audit=yes -o AuditUrl=http://localhost:8889/

EXPOSE 2222
EXPOSE 8000
EXPOSE 2121
EXPOSE 1110
EXPOSE 5432

COPY *wrapper.sh /docker-entrypoint.d/
COPY passwd-pot /bin

