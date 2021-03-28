[![CircleCI](https://circleci.com/gh/Rubusch/docker__u-boot.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__u-boot)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)


# Docker: U-boot Environment for Patch Development


A docker image for patch development. A ``build.sh`` script will in a second step clone a staging tree. ``configs`` and ``staging`` tree will be setup outside the container, but shared with the container.  


## Tools Needed

```
$ sudo curl -L "https://github.com/docker/compose/releases/download/1.28.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
$ sudo chmod a+x /usr/local/bin/docker-compose
```

NB: Where 1.28.6 is the latest version (currently not supported by devian/ubuntu package management)  


## Build

The setup needs a gmail email address for patch delivery via ``git send-email``. Many other email providers are possible in general, too  

```
$ cd docker
$ docker-compose up
```

**NOTE** After first run, go to ``docker/secrets/.gitconfig`` or in the container ``/home/USER/.gitconfig`` (same file), and fill out what is missing.  


## Usage

```
$ docker-compose -f ./docker-compose.yml run --rm u-boot_devel /bin/bash
```
