# Dockerfile of PHP7-Alpine

Lightweight PHP7 Alpine docker image. (Only PHP core, no modules)

```bash
docker pull keinos/php7-alpine:latest
```

- PHP: This image uses the latest PHP Repositories for Alpine by [CODECASTS](https://github.com/codecasts)
  - https://github.com/codecasts/php-alpine @ GitHub
- Base image: `keinos:alpine`
- Repositories:
  - Image: https://hub.docker.com/r/keinos/php7-alpine @ Docker Hub
  - Source: https://github.com/KEINOS/Dockerfile_of_PHP7-Alpine @ GitHub
- Issues: https://github.com/KEINOS/Dockerfile_of_PHP7-Alpine/issues @ GitHub

## Usage

This is an example to prepare a PHP7 container with `mbstring` `json` `ctype` `openssl` modules installed.

```yaml
FROM keinos/php7-alpine

RUN apk --update \
    && apk add --update \
      php-mbstring@php \
      php-json@php \
      php-ctype@php \
      php-openssl@php \
    && rm -rf /var/cache/apk/*

COPY src/ /app/
WORKDIR /app
```

## Note

To keep the base image as light as possible, **this image only containes the PHP core** and no modules are installed.

Therefore, you need to `apk add` any PHP modules you need.

Also note that the `@php` is required to avoid getting default PHP packages from alpine instead.

```yaml
RUN apk add php-[module name]@php
```
