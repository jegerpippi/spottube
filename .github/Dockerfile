# Use the aarch64 Ubuntu 22.04 as the base image
FROM arm64v8/ubuntu:22.04

ARG BUILD_VERSION


# Set the working directory to /app
WORKDIR /app

# Update and install necessary dependencies
RUN apt-get update && \
  apt-get install -y wget curl git unzip tar clang cmake ninja-build pkg-config libgtk-3-dev libglu1-mesa-dev make python3-pip python3-setuptools desktop-file-utils libgdk-pixbuf2.0-dev fakeroot strace fuse libunwind-dev locate patchelf gir1.2-appindicator3-0.1 libappindicator3-1 libappindicator3-dev libsecret-1-0 libjsoncpp25 libsecret-1-dev libjsoncpp-dev libnotify-bin libnotify-dev mpv libmpv-dev rpm

# Define the Flutter SDK paths
ENV PATH="${PATH}:/opt/flutter/bin:${HOME}/.pub-cache/bin"

# Install Flutter (latest stable version) with Linux support
RUN git clone https://github.com/flutter/flutter.git --single-branch --branch=stable --depth=1 /opt/flutter && \
  flutter precache && \
  flutter config --enable-linux-desktop && \
  dart pub global activate flutter_distributor

RUN wget -O appimagetool "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-aarch64.AppImage" &&\
  chmod +x appimagetool &&\
  mv appimagetool /usr/local/bin


# Copy over all the repository files from the host into the container
COPY .. .

# Run flutter build for Linux ARM
RUN alias dpkg-deb="dpkg-deb --Zxz" &&\
  flutter_distributor package --platform=linux --targets=deb &&\
  flutter_distributor package --platform=linux --targets=appimage &&\
  flutter_distributor package --platform=linux --targets=rpm &&\
  make tar VERSION=${BUILD_VERSION} ARCH=arm64 PKG_ARCH=aarch64

# Move artifacts
RUN mkdir bundle &&\
  mv build/spotube-linux-*-aarch64.tar.xz bundle/ &&\
  mv dist/**/spotube-*-linux.deb bundle/Spotube-linux-aarch64.deb &&\
  mv dist/**/spotube-*-linux.rpm bundle/Spotube-linux-aarch64.rpm &&\
  mv dist/**/spotube-*-linux.AppImage bundle/Spotube-linux-aarch64.AppImag

RUN mkdir -p /host/app/bundle && \
  cp -r bundle/* /host/app/bundle

# Set the working directory to /host/app
WORKDIR /host/app

# Finish the Dockerfile
CMD ["echo", "Done!"]
