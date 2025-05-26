export DEBIAN_FRONTEND=noninteractive

if [ "$CHANNEL" == "dev" ]; then
    export $CHANNEL = "unstable"
    fi

if [ "$VERSION" == "" ]; then
    URL=https://dl.google.com/linux/direct/google-chrome-$CHANNEL_current_amd64.deb
else 
    URL=https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-beta/google-chrome-stable_136.0.7103.113-1_amd64.deb
    fi

apt-get update
apt-get -y $URL