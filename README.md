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
- Note:
  - Update when: This image will be updated whenever the base image below is updated.
    - Base image: `keinos:alpine` [@ DockerHub](https://hub.docker.com/r/keinos/alpine) [@ GitHub](https://github.com/KEINOS/Dockerfile_of_Alpine)
  - Lighweight but useless: To keep the base image as light as possible, this image **only containes the latest stable PHP core and no modules** are installed. Therefore, **you need to `apk add` any PHP modules before use**.

    ```bash
    apk add php-[module name]@php
    ```

    - When `apk add` the `php-[module name]`, the `@php` is required to avoid getting default PHP packages from alpine instead. (Ex: In order to use `json_encode` or `json_decode` function in your PHP code, you need to install JSON module by `apk add php-json@php` and not `apk add php-json`)

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

The below YAML is an example of Dockerfile. It prepares a PHP7 image with `mbstring` `json` `ctype` `openssl` modules installed and copies the `src/` directory in local to `/app` directory on the image.

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

```shellsession
$ # Access container interactively via tty and setup
$ docker run -it -name my_sample_image keinos/php7-alpine /bin/sh
/ #
/ # apk update
...
/ # # Add mb-string module for latest PHP
/ # apk add php-mbstring@php
...
/ # # Add json module for latest PHP
/ # apk add php-json@php
...
...
/ # # Delete cache of apk
/ # rm -rf /var/cache/apk/*
...
/ # exit
$
```