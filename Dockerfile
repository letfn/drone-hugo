FROM letfn/container AS download

WORKDIR /tmp

RUN curl -sSL -O https://github.com/gohugoio/hugo/releases/download/v0.64.0/hugo_0.64.0_Linux-64bit.tar.gz \
  && tar xvfz hugo_0.64.0_Linux-64bit.tar.gz hugo \
  && rm -f hugo_0.64.0_Linux-64bit.tar.gz \
  && chmod 755 hugo

RUN mkdir themes && git clone https://github.com/defn/drone-hugo-theme themes/drone-hugo-theme

FROM letfn/container

COPY --from=download /tmp/hugo /usr/local/bin/hugo
COPY --from=download /tmp/themes /drone/themes
COPY config.yaml.template /drone/

COPY plugin /plugin

ENTRYPOINT [ "/tini", "--", "/plugin" ]
