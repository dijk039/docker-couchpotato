FROM alpine:edge
MAINTAINER Tim van Dijk

ENV LANG='en_US.UTF-8' \
    LANGUAGE='en_US.UTF-8' \
    TERM='xterm'

RUN apk -U upgrade && \
    apk -U add \
        ca-certificates git python py-libxml2 py-lxml py2-pip  \
        make gcc g++ python-dev openssl-dev libffi-dev \
    && \
    pip --no-cache-dir install --upgrade setuptools && \
    pip --no-cache-dir install --upgrade pyopenssl  && \
    git clone --depth 1 https://github.com/RuudBurger/CouchPotatoServer.git /CouchPotatoServer && \
    apk del make gcc g++ python-dev && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

VOLUME ["/config", "/data"]

ADD ./start.sh /tmp/start.sh
RUN chmod u+x /tmp/start.sh
RUN cp /tmp/start.sh / && rm -f start.sh

EXPOSE 5050

CMD ["/start.sh"]
