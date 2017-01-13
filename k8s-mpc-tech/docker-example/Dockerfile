FROM alpine:3.4
MAINTAINER Daniel Menet <daniel.menet@swisstxt.ch>

RUN apk add --no-cache openssh-client tar curl
RUN curl --silent --show-error --fail --location \
	--header "Accept: application/tar+gzip, application/x-gzip, \ 
application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64" \
| tar --no-same-owner -C /usr/bin/ -xz caddy \
 	&& chmod 0755 /usr/bin/caddy


COPY Caddyfile /etc/Caddyfile
COPY index.html /srv/index.html

EXPOSE 8008
WORKDIR /srv

ENTRYPOINT ["/usr/bin/caddy", "--conf", "/etc/Caddyfile", "--log", "stdout"]
