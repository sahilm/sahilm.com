FROM ruby:2.4-stretch

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install nodejs \
  && rm -rf /var/lib/apt/lists/*

ENV PNGOUT_VERSION 20150319
RUN curl -sLO http://static.jonof.id.au/dl/kenutils/pngout-${PNGOUT_VERSION}-linux.tar.gz \
  && mkdir -p /tmp/pngout \
  && tar xf pngout-${PNGOUT_VERSION}-linux.tar.gz -C /tmp/pngout \
  && mv /tmp/pngout/pngout-${PNGOUT_VERSION}-linux/x86_64/pngout /usr/local/bin/ \
  && rm -rf /tmp/pngout

RUN npm install -g svgo

CMD ["/bin/bash"]
