FROM registry.fedoraproject.org/fedora-toolbox:39

ARG NAME=throneless-toolbox
ARG VERSION=39
LABEL com.github.containers.toolbox="true" \
      com.redhat.component="$NAME" \
      name="$NAME" \
      version="$VERSION" \
      usage="This image is meant to be used with the toolbox command" \
      summary="Custom image for Throneless developers" \
      maintainer="Josh King <josh@throneless.tech>"

COPY README.md /

RUN dnf -y upgrade

# Install necessary extra repos
RUN dnf config-manager --add-repo https://rtx.pub/rpm/rtx.repo
RUN dnf -y copr enable atim/starship
RUN dnf -y copr enable varlad/helix

# Install efm-langserver
RUN dnf -y install golang
RUN GOPATH=/usr/local go install github.com/mattn/efm-langserver@latest

# Install user defaults
COPY default.useradd /etc/default/useradd

# Install extra packages
COPY extra-packages /
RUN dnf -y install $(<extra-packages)
RUN rm /extra-packages

# Cleanup
RUN dnf clean all
