FROM debian:10
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## the USER is needed to make it available as --build-arg
## in case docker complains for a not set USER, perhaps you forgot to use --build-arg USER=$USER
ARG USER=""

WORKDIR /home/$USER

################################################################################
## set up apt fully functional
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge
RUN apt-get install -y  \
    zlib1g-dev \
    g++ \
    build-essential \
    rsync \
    binutils \
    unzip \
    python \
    bzip2 \
    locales \
    libc6-dev \
    fakeroot \
    bin86 \
    udev \
    hdparm \
    xmlto \
    tree \
    colordiff \
    sudo

## for building documentation targets
RUN apt-get install -y  \
    imagemagick \
    graphviz \
    dvipng \
    fonts-noto-cjk \
    latexmk \
    librsvg2-bin \
    virtualenv \
    python3-sphinx \
    python3-sphinx-rtd-theme \
    texlive-xetex \
    libsdl1.2-dev \
    libsdl2-dev \
    python3-pytest \
    swig \
    python3-dev \
    qemu-system \
    vim \
    libncurses5-dev \
    gcc \
    make \
    git-all \
    exuberant-ctags \
    libssl-dev \
    bison \
    flex \
    libelf-dev \
    bc \
    aptitude \
    tig \
    emacs-nox \
    codespell \
    python-ply \
    python-git


################################################################################
## locale settings
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

## locale-hack, needed for debian since locale-gen <arg> seems not to work
RUN sed -i '/^#.* en_US.UTF-8.* /s/^#//' /etc/locale.gen
RUN locale-gen


################################################################################
## setup user and run stuff under user
RUN useradd "$USER" -m --password "$USER"
RUN usermod -a -G sudo "$USER"
RUN sed -i '/%sudo/s/.*/%sudo   ALL=NOPASSWD: ALL/' /etc/sudoers

## in case it already exists (workdir)
RUN chown $USER.$USER -R /home/$USER


################################################################################
## get sources
## NOTE: this container will obtain sources in manually executed script (later), sources shall be shared between container and outside

## prepare paths
RUN mkdir -p /home/$USER/u-boot
RUN mkdir -p /home/$USER/configs

## reset permissions
RUN chown $USER:$USER -R /home/$USER/u-boot
RUN chown $USER:$USER -R /home/$USER/configs


################################################################################
## set up tools
USER $USER

## bash config
RUN cd /home/$USER && rm -f /home/$USER/.bashrc && ln -s /home/$USER/configs/.bashrc /home/$USER/

## vim config
RUN cd /home/$USER && rm -f /home/$USER/.vimrc && ln -s /home/$USER/configs/.vimrc /home/$USER/

## emacs config
RUN cd /home/$USER && rm -f /home/$USER/.emacs && ln -s /home/$USER/configs/.emacs /home/$USER/

## gitconfig (contains secrets)
RUN cd /home/$USER && rm -f /home/$USER/.gitconfig && ln -s /home/$USER/secrets/.gitconfig /home/$USER/

## codespell: dictionary fix
RUN sudo mkdir -p /usr/share/codespell
RUN sudo ln -s /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt /usr/share/codespell/dictionary.txt


################################################################################
## command mode
COPY build.sh /usr/local/bin/build.sh
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
