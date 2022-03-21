FROM alpine:3.11
WORKDIR /workdir
ENV PATH /usr/local/texlive/2021/bin/x86_64-linuxmusl:$PATH
RUN apk add --no-cache curl perl fontconfig-dev freetype-dev && \
    apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing pdf2svg && \
    apk add --no-cache --virtual .fetch-deps xz tar && \
    mkdir /tmp/install-tl-unx && \
    curl -L ftp://tug.org/historic/systems/texlive/2021/install-tl-unx.tar.gz | \
    tar -xz -C /tmp/install-tl-unx --strip-components=1 && \
    printf "%s\n" \
      "selected_scheme scheme-basic" \
      "tlpdbopt_install_docfiles 0" \
      "tlpdbopt_install_srcfiles 0" \
      > /tmp/install-tl-unx/texlive.profile && \
    /tmp/install-tl-unx/install-tl -profile=/tmp/install-tl-unx/texlive.profile && \
    rm -rf /tmp/install-tl-unx && \
    apk del .fetch-deps
