#!/usr/bin/env sh

# stop script when an error occurs
set -e

#Set default values for testing
CHANNEL=${CHANNEL:-"stable"}
VERSION=${VERSION:-""} #Valid versions: https://mirror.cs.uchicago.edu/google-chrome/pool/main/g/

export DEBIAN_FRONTEND=noninteractive

if [ "$CHANNEL" = "dev" ]; then
    export CHANNEL="unstable"
fi

# When no version is specified, the latest version from the chosen channel is set to be downloaded.
if [ -z "$VERSION" ]; then
    DEBPACKAGE_URL="https://dl.google.com/linux/direct/google-chrome-${CHANNEL}_current_amd64.deb"
else
# When a specific version is specified, this version is set to be download from the chosen channel.
    DEBPACKAGE_URL="https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-$CHANNEL/google-chrome-${CHANNEL}_$VERSION-1_amd64.deb"
fi

# Download debpackage
# --no-clobber = ignore downloading when file exists. Useful for testing
# --directory-prefix = directory to download in
DOWNLOAD_DIR="/tmp"
DEBPACKAGE_LOCAL_PATH="${DOWNLOAD_DIR}/$(basename "$DEBPACKAGE_URL")"
wget --no-verbose --no-clobber --directory-prefix "$DOWNLOAD_DIR" "$DEBPACKAGE_URL"

# Install
apt-get -qq update
apt-get install -y "$DEBPACKAGE_LOCAL_PATH"

# cleanup
rm "$DEBPACKAGE_LOCAL_PATH"