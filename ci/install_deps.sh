#!/usr/bin/env bash

set -e

export PATH=$PATH:$HOME/bin:$(npm bin)

if ! which pngout; then
  PNGOUT_VERSION="20150319"
  curl -sLO http://static.jonof.id.au/dl/kenutils/pngout-${PNGOUT_VERSION}-linux.tar.gz \
    && mkdir -p /tmp/pngout \
    && mkdir -p $HOME/bin \
    && tar xf pngout-${PNGOUT_VERSION}-linux.tar.gz -C /tmp/pngout \
    && mv /tmp/pngout/pngout-${PNGOUT_VERSION}-linux/x86_64/pngout $HOME/bin
fi

if ! which svgo; then
  npm install svgo
fi
