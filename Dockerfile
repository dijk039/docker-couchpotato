FROM alpine:edge
MAINTAINER Tim van Dijk

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

RUN apk -U upgrade && \
    apk -U add \
        ca-certificates \
        git \
        python \
        py2-pip py2-openssl py-libxml2 py2-lxml \
    && \
    git clone --depth 1 https://github.com/RuudBurger/CouchPotatoServer.git /CouchPotatoServer && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

VOLUME ["/config", "/data"]

ADD ./start.sh /start.sh
RUN chmod u+x /start.sh

EXPOSE 5050

CMD ["/start.sh"]
