FROM letfn/container

WORKDIR /drone/src

RUN apt-get update && apt-get upgrade -y

RUN curl -sSL -O https://github.com/gohugoio/hugo/releases/download/v0.64.0/hugo_0.64.0_Linux-64bit.tar.gz \
  && tar xvfz hugo_0.64.0_Linux-64bit.tar.gz hugo \
  && rm -f hugo_0.64.0_Linux-64bit.tar.gz \
  && chmod 755 hugo \
  && mv hugo /usr/local/bin/

RUN mkdir -p /drone/themes && git clone https://github.com/defn/drone-hugo-theme /drone/themes/drone-hugo-theme

COPY config.yaml.template /drone/

COPY plugin /plugin

ENTRYPOINT [ "/plugin" ]
