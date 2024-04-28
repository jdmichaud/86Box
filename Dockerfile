# BUILDKIT_COLORS="run=123,20,245:error=yellow:cancel=blue:warning=white" docker build --build-arg UID=$(id -u) --build-arg GID=$(id -g) --build-arg UNAME=$(id -un) -t 86box .
# docker run --rm -it -v .:/86Box 86box bash
# cd /86Box && mkdir cmake-build && cd cmake-build && cmake -DQT=0 ../ && make
# Outside of docker:
# cd cmake-build/src/
# ln -s ../../../roms # This is assuming the roms repo was cloned next to the 86Box repo
# ./86Box
FROM ubuntu:noble

ARG UNAME=testuser
ARG UID=1000
ARG GID=1000

#RUN useradd $UNAME --create-home --password $UNAME && echo "$UNAME:$UNAME" | chpasswd
RUN groupadd --gid $GID --non-unique $UNAME
RUN useradd --create-home --uid $UID --gid $GID --non-unique --shell /bin/bash $UNAME

RUN apt update
RUN apt install -y \
  build-essential \
  sudo \
  vim \
  curl \
  libfluidsynth-dev \
  libfreetype-dev \
  libpng-dev \
  libslirp-dev \
  librtmidi-dev \
  libsdl2-dev \
  libopenal-dev  \
  qt6-base-dev \
  cmake \
  libatomic1 \
  pkg-config

RUN apt install -y gdb
USER $UNAME

