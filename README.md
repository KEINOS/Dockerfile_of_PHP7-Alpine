[![](https://images.microbadger.com/badges/image/keinos/php7-alpine.svg)](https://microbadger.com/images/keinos/php7-alpine "View image details on microbadger.com") [![](https://img.shields.io/docker/cloud/automated/keinos/php7-alpine.svg)](https://hub.docker.com/r/keinos/php7-alpine "View on Docker Hub") [![](https://img.shields.io/docker/cloud/build/keinos/php7-alpine.svg)](https://hub.docker.com/r/keinos/php7-alpine/builds "View Build Status on Docker Hub")

# Dockerfile of PHP7-Alpine

Lightweight PHP7 Alpine docker image. (Only PHP core, no modules)

```bash
docker pull keinos/php7-alpine:latest
```

- PHP: This image uses the latest PHP Repositories for Alpine by [CODECASTS](https://github.com/codecasts)
  - https://github.com/codecasts/php-alpine @ GitHub
- Repositories:
  - Image: https://hub.docker.com/r/keinos/php7-alpine @ Docker Hub
  - Source: https://github.com/KEINOS/Dockerfile_of_PHP7-Alpine @ GitHub
- Issues: https://github.com/KEINOS/Dockerfile_of_PHP7-Alpine/issues @ GitHub
- Note: This image will be updated whenever the base image below is updated.
  - Base image: `keinos:alpine` [@ DockerHub](https://hub.docker.com/r/keinos/alpine) [@ GitHub](https://github.com/KEINOS/Dockerfile_of_Alpine)

## Usage

```shellsession
$ docker pull keinos/php7-alpine
...
$ # Sample of running `php --version` command
$ docker run --rm -it keinos/php7-alpine php --version
PHP 7.2.18 (cli) (built: May  4 2019 16:25:12) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.2.0, Copyright (c) 1998-2018 Zend Technologies
```

The below YAML is an example of Dockerfile to prepare a PHP7 container with `mbstring` `json` `ctype` `openssl` modules installed.

```yaml
FROM keinos/php7-alpine

RUN apk update \
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

```bash
apk add php-[module name]@php
```

```shellsession
$ apk update
...
$ # Add mb-string module for latest PHP
$ apk add php-mbstring@php
...
$ # Add json module for latest PHP
$ apk add php-json@php
...
```