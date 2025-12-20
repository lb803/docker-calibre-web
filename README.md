# docker‑calibre‑web
Minimal Docker Image for [Calibre‑Web](https://github.com/janeczku/calibre-web).

A lightweight Dockerfile for Calibre-Web that focuses on core functionality and efficiency. Designed for straightforward book library management with essential features:

  - Simple book library management
  - Support for epub, pdf, and cbr file formats
  - Cover extraction from supported file types


---

## Build

Build a specific Calibre‑Web release:

```bash
docker build . -t lb803/calibre-web \
  --build-arg CALIBRE_WEB_VERSION=0.6.25
```

---

## Run

```bash
docker run -d \
  -p 8083:8083 \
  -e CALIBRE_DBPATH=/calibre-web/config/ \
  -v /path/to/calibre/library:/calibre-web/books \
  -v /path/to/config:/calibre-web/config \
  --name calibre-web lb803/calibre-web
```

### With Docker‑Compose

```yaml
version: "3.8"
services:
  calibre-web:
    image: lb803/calibre-web
    container_name: calibre-web
    ports:
      - "8083:8083"
    environment:
      - CALIBRE_DBPATH=/calibre-web/config/
    volumes:
      - /path/to/calibre/library:/calibre-web/books
      - /path/to/config:/calibre-web/config
```

Start the stack:

```bash
docker-compose up -d
```

## Dependencies
The Dockerfile installs system libraries required by the Python packages listed below:

| Python package   | System library dependencies |
|------------------|-----------------------------|
| **lxml**         | `libxml2`, `libxslt1.1`     |
| **python‑magic** | `libmagic1`                 |
