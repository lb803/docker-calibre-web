**docker‑calibre‑web**  
A minimal Dockerfile for running [Calibre‑Web](https://github.com/janeczku/calibre-web).

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