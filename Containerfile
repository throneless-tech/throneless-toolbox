FROM registry.fedoraproject.org/fedora-toolbox:44

ARG NAME=throneless-toolbox
ARG VERSION=44
LABEL com.github.containers.toolbox="true" \
      com.redhat.component="$NAME" \
      name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Custom image for Throneless developers" \
      maintainer="Josh King <josh@throneless.tech>"

COPY README.md /

RUN dnf -y upgrade

# Install microsandbox
RUN dnf -y install wget protobuf-compiler cmake clang-devel
RUN wget https://github.com/superradcompany/microsandbox/releases/latest/download/microsandbox-linux-x86_64.tar.gz && \
      tar -zxvf microsandbox-linux-x86_64.tar.gz && \
      mv msb /usr/local/bin/ && \
      mv libkrunfw.so* /usr/local/lib/ && \
      chmod +x /usr/local/bin/msb && \
      rm microsandbox-linux-x86_64.tar.gz

# Install necessary extra repos
RUN dnf config-manager addrepo --from-repofile=https://mise.jdx.dev/rpm/mise.repo
RUN dnf -y copr enable atim/starship
RUN dnf -y copr enable wezfurlong/wezterm-nightly

# Install user defaults
COPY default.useradd /etc/default/useradd

# Install extra packages
COPY extra-packages /
RUN dnf -y install $(<extra-packages)
RUN rm /extra-packages

# Cleanup
RUN dnf clean all
