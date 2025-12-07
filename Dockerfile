FROM python:3.13-slim-bookworm

ARG CALIBRE_WEB_VERSION

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3-lxml \
        imagemagick && \
    rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 calibre && \
    useradd -m -u 1000 -g calibre -s /bin/bash calibre

RUN mkdir -p /calibre-web && chown -R calibre:calibre /calibre-web

USER calibre

WORKDIR /calibre-web

RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir "calibreweb==${CALIBRE_WEB_VERSION}"

EXPOSE 8083

CMD ["venv/bin/cps"]
