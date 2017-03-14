FROM dougefresh/sshd-passwd-pot:94d4ffcaac02290b8c47f5b3f1128c7dbbc23935

ENV GOLANG_VERSION 1.8
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 53ab94104ee3923e228a2cb2116e5e462ad3ebaeea06ff04463479d7f12d27ca

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

EXPOSE 2222
EXPOSE 8000
EXPOSE 2121

# just picking a random non root user across systems
RUN /usr/local/go/bin/go get -v  github.com/dougEfresh/ftp-passwd-pot
RUN /usr/local/go/bin/go get -v  github.com/dougEfresh/http-passwd-pot

RUN /usr/local/go/bin/go install github.com/dougEfresh/ftp-passwd-pot
RUN /usr/local/go/bin/go install github.com/dougEfresh/http-passwd-pot

COPY *wrapper.sh /docker-entrypoint.d/
COPY go-wrapper /usr/local/bin/
