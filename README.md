[![CircleCI](https://circleci.com/gh/Rubusch/docker__u-boot.svg?style=shield)](https://circleci.com/gh/Rubusch/docker__u-boot)
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)


# Docker: U-boot Environment for Patch Development

A docker image for patch development.  


## Tools Needed

```
$ sudo apt-get install -y libffi-dev libssl-dev
$ sudo apt-get install -y python3-dev
$ sudo apt-get install -y python3 python3-pip
$ pip3 install docker-compose
```

Make sure, ``~/.local`` is within ``$PATH`` or re-link e.g. it to ``/usr/local``.  


## Build

The setup needs a gmail email address for patch delivery via ``git send-email``. Many other email providers are possible in general, too  

```
$ ./setup.sh
```

**NOTE** After first run, go to ``docker/secrets/.gitconfig`` or in the container ``/home/USER/.gitconfig`` (same file), and fill out what is missing.  


## Usage

```
$ cd ./docker
$ docker-compose -f ./docker-compose.yml run --rm u-boot_devel /bin/bash
```
