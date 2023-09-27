# Use the aarch64 Ubuntu 22.04 as the base image
FROM --platform=linux/arm64 fischerscode/flutter:stable

# Set the working directory to /app
WORKDIR /app

USER root

# Update and install necessary dependencies
RUN apt-get update
RUN apt-get install -y wget curl git unzip tar clang cmake ninja-build pkg-config libgtk-3-dev libglu1-mesa-dev make python3-pip python3-setuptools desktop-file-utils libgdk-pixbuf2.0-dev fakeroot strace fuse libunwind-dev locate patchelf gir1.2-appindicator3-0.1 libappindicator3-1 libappindicator3-dev libsecret-1-0 libjsoncpp1 libsecret-1-dev libjsoncpp-dev libnotify-bin libnotify-dev mpv libmpv-dev rpm

# Define the Flutter SDK paths
ENV PATH="${PATH}:/root/.pub-cache/bin"

# Copy over all the repository files from the host into the container
COPY ./ ./

ARG BUILD_VERSION
ENV BUILD_VERSION=${BUILD_VERSION}

# Finish the Dockerfile
CMD ["bash", "scripts/build_linux_arm.sh"]
