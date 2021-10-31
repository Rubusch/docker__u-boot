################################################################################
## ATTENTION: multistage build
##
## based on current USER and TAG, DOCKER_BASE:
## https://github.com/Rubusch/docker__zephyr-base
##
################################################################################
## base image settings
ARG USER="${USER}"
ARG DOCKER_BASE="sandbox"
ARG DOCKER_BASE_TAG="20211028"


################################################################################
## base image
FROM ${USER}/${DOCKER_BASE}:${DOCKER_BASE_TAG} AS u-boot
MAINTAINER Lothar Rubusch <l.rubusch@gmail.com>
ENV DEBIAN_FRONTEND=noninteractive


################################################################################
## environment (applied ARG/ENV must come after FROM declaration)
ARG USER="${USER}"


################################################################################
## apt
USER root
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y --purge
RUN apt-get install -y latexmk
RUN apt-get install -y librsvg2-bin
RUN apt-get install -y virtualenv
RUN apt-get install -y python3-sphinx
RUN apt-get install -y python3-sphinx-rtd-theme
RUN apt-get install -y python3-ply
RUN apt-get install -y python3-git


################################################################################
## sources
USER root

## mountpoints
RUN mkdir -p /home/$USER/u-boot

## reset permissions
RUN chown $USER:$USER -R /home/$USER/


################################################################################
## set up tools
USER $USER

## codespell: dictionary fix
RUN sudo mkdir -p /usr/share/codespell
RUN sudo ln -s /usr/lib/python3/dist-packages/codespell_lib/data/dictionary.txt /usr/share/codespell/dictionary.txt


################################################################################
## command mode
USER ${USER}
WORKDIR /home/$USER
COPY *.sh /usr/local/bin/
CMD ["/bin/bash", "/usr/local/bin/build.sh"]
