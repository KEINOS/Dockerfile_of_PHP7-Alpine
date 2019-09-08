# Build Minimum PHP env
# =====================
FROM keinos/alpine

# Get latest version of php-alpine release and trust the repo
COPY get-url-php-alpine-repo.sh /root/get-url-php-alpine-repo.sh

# install php and some extensions
RUN apk add --update \
      ca-certificates \
      php \
      php-mbstring \
# Remove cache to ensure
      && rm -rf /var/cache/apk/* \
# Set time zone to Tokyo/Japan
      && sed -i -e 's/;date.timezone =/date.timezone = "Asia\/Tokyo"/' /etc/php7/php.ini
