FROM dougefresh/sshd-passwd-pot:902de1984c8ed1040ab9311e5be0f398e4ca9958

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
ENV PASSWD_POT_OPTS --bind 0.0.0.0 --all --dry-run --debug --syslog 172.17.0.1:514
ENV PASSWD_POT_SOCKET_OPTS --dry-run --debug  --syslog 172.17.0.1:514

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

EXPOSE 2222
EXPOSE 8000
EXPOSE 2121
EXPOSE 1110
EXPOSE 5432

COPY *wrapper.sh /docker-entrypoint.d/
COPY go-wrapper /usr/local/bin/
COPY passwd-pot /go/bin

