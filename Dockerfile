FROM imoize/alpine-s6:3.19

ARG TARGETARCH
ARG TARGETVARIANT

# install packages
RUN \
apk add --no-cache \
    redis \
# cleanup
    rm -rf \
    /tmp/* \
    /var/cache/apk/*

# add local files
COPY src/ /

# ports and workdir
WORKDIR /config
EXPOSE 6379