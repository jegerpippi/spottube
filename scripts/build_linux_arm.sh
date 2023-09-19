#!/bin/env bash

alias dpkg-deb="dpkg-deb --Zxz"

flutter_distributor package --platform=linux --targets=deb
flutter_distributor package --platform=linux --targets=rpm
make tar VERSION=$BUILD_VERSION ARCH=arm64 PKG_ARCH=aarch64

# Move artifacts
mkdir bundle
mv build/spotube-linux-*-aarch64.tar.xz bundle/
mv dist/**/spotube-*-linux.deb bundle/Spotube-linux-aarch64.deb
mv dist/**/spotube-*-linux.rpm bundle/Spotube-linux-aarch64.rpm

mkdir -p /host/app/bundle
cp -r bundle/* /host/app/bundle
