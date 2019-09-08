#!/bin/sh

# Create URL file of PHP-Alpine project to add in APK repository list.
# --------------------------------------------------------------------
# This script fetches the latest released version of PHP-Alpine and
# saves the repository path.

# User name of the repository
name_subject='php-alpine'

# Get Repository name (target Alpine version)
name_repo=$(curl -s "https://api.bintray.com/repos/${name_subject}/" | jq -r '.[1].name')

# Get Package name (target PHP version)
name_package=$(curl -s "https://api.bintray.com/repos/${name_subject}/${name_repo}/packages" | jq -r '.[].name' | grep php | head -1)

# Generate URL of the php-alpine repository
# Format: @php https://dl.bintray.com/:subject/:repo/:package
# Sample: @php https://dl.bintray.com/php-alpine/v3.9/php-7.3
url_repo_apk_add="@php https://dl.bintray.com/${name_subject}/${name_repo}/${name_package}"
echo $url_repo_apk_add > /etc_apk_repositories

echo '- List of apk repositories:'
cat /etc_apk_repositories

# Get PHP-Alpine project public key to trust their packages.
#   See: https://github.com/codecasts/php-alpine
curl -O https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub  && \
cp php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub && \
echo '- rsa.pub key of php-alpine:' && \
cat /etc/apk/keys/php-alpine.rsa.pub

echo '- Finished running:' $0
