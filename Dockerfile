# Fetch URL of latest PHP-Alpine repo
# ===================================
FROM keinos/alpine AS src

COPY get-url-php-alpine-repo.sh /root/get-url-php-alpine-repo.sh

# Get PHP-Alpine project public key to trust their packages.
# See: https://github.com/codecasts/php-alpine
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN apk update \
    && apk add \
      curl tar jq \
    && /root/get-url-php-alpine-repo.sh \
    && cat '/etc_apk_repositories' >> /etc/apk/repositories

# Build Minimum PHP env
# =====================
FROM keinos/alpine

# Trust PHP-Alpine project public key to trust their packages.
COPY --from=src /etc/apk/keys/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub
# Copy the repository URL file of PHP-Alpine for apk.
# This file will be appended to /etc/apk/repositories file.
COPY --from=src /etc/apk/repositories /etc/apk/repositories

# Note: the @php is required to avoid getting default php packages from alpine instead.
RUN apk --update add ca-certificates \
    && apk add --update \
      php@php \
    && rm -rf /var/cache/apk/*
