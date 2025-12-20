FROM python:3.13-slim-bookworm

ARG CALIBRE_WEB_VERSION

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libxml2 \
        libxslt1.1 \
        libmagic1 \
        unar \
        ghostscript \
        imagemagick && \
    rm -rf /var/lib/apt/lists/*

# Adjust ImageMagick policy to allow PDF handling
RUN sed -i '/<policy.*pattern="PDF".*\/>/d' /etc/ImageMagick-6/policy.xml && \
    sed -i '/<\/policymap>/i \
            <policy domain="coder" rights="read" pattern="PDF" />' /etc/ImageMagick-6/policy.xml

RUN groupadd -g 1000 calibre && \
    useradd -m -u 1000 -g calibre -s /bin/bash calibre

RUN mkdir -p /calibre-web && chown -R calibre:calibre /calibre-web

USER calibre

WORKDIR /calibre-web

RUN python -m venv venv && \
    . venv/bin/activate && \
    pip install --no-cache-dir \
    "calibreweb==${CALIBRE_WEB_VERSION}" \
    rarfile==4.2 \
    natsort==8.4.0

EXPOSE 8083

CMD ["venv/bin/cps"]
