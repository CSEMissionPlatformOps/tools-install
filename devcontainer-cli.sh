#!/bin/bash 
set -e

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" |
  grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/'
}

GITHUB="stuartleeks/devcontainer-cli"
VERSION=${1:-"$(get_latest_release $GITHUB)"}
INSTALL_DIR=${2:-"$HOME/.local/bin"}
CMD=devcontainer
NAME="devcontainer CLI"

echo -e "\e[34m»»» 📦 \e[32mInstalling \e[33m$NAME \e[35mv$VERSION\e[0m ..."

mkdir -p "$INSTALL_DIR"
curl -sSL "https://github.com/stuartleeks/devcontainer-cli/releases/download/v${VERSION}/devcontainer-cli_linux_amd64.tar.gz" | \
     tar -zx -C "$INSTALL_DIR" $CMD

echo -e "\n\e[34m»»» 💾 \e[32mInstalled to: \e[33m$(which $CMD)"
echo -e "\e[34m»»» 💡 \e[32mVersion details: \e[39m$($CMD version)"