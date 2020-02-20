FROM letfn/container AS download

ARG _HUGO_VERSION=0.64.1

WORKDIR /tmp

RUN curl -sSL -O https://github.com/gohugoio/hugo/releases/download/v${_HUGO_VERSION}/hugo_${_HUGO_VERSION}_Linux-64bit.tar.gz \
  && tar xvfz hugo_${_HUGO_VERSION}_Linux-64bit.tar.gz hugo \
  && rm -f hugo_${_HUGO_VERSION}_Linux-64bit.tar.gz \
  && chmod 755 hugo

RUN echo 1

RUN mkdir themes && git clone https://github.com/defn/drone-hugo-theme themes/drone-hugo-theme

FROM letfn/container

COPY --from=download /tmp/hugo /usr/local/bin/hugo
COPY --from=download /tmp/themes /drone/themes
COPY config.yaml.template /drone/

COPY plugin /plugin

ENTRYPOINT [ "/tini", "--", "/plugin" ]
