#!/bin/sh

# Create URL file of PHP-Alpine project to add in APK repository list.
# --------------------------------------------------------------------
# This script fetches the latest released version of PHP-Alpine and
# saves the repository path.

# User name of the repository
name_subject='php-alpine'

# Get Repositories
name_repo=$(curl -s "https://api.bintray.com/repos/${name_subject}/" | jq -r '.[].name' | tail -1)

# Get Packages
name_package=$(curl -s "https://api.bintray.com/repos/${name_subject}/${name_repo}/packages" | jq -r '.[].name' | tail -1)

# Generate URL and file
# Format: @php https://dl.bintray.com/:subject/:repo/:package
# Sample: @php https://dl.bintray.com/php-alpine/v3.9/php-7.3
url_repo_apk_add="@php https://dl.bintray.com/${name_subject}/${name_repo}/${name_package}"

echo $url_repo_apk_add > /etc_apk_repositories
