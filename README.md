# Docker: u-boot for patches


A docker image for patch development. A ``build.sh`` script will in a second step clone a staging tree. ``configs`` and ``staging`` tree will be setup outside the container, but shared with the container.  


## Build

The setup needs a gmail email address for patch delivery via ``git send-email``. Many other email providers are possible in general, too  

*NOTE* Replace _gmail user name_, _email@gmail.com_ and _gmail password_ with your gmail credentials  

*NOTE* For the gamil password escape ``<`` and ``>`` i.e. write ``\\\<`` and ``\\\>``, in any case don't use quotes.  

```
$ cd ./docker

$ time docker build --no-cache --build-arg USER=$USER --build-arg GMAIL_USER="<gmail user name>" --build-arg GMAIL=<email@gmail.com> --build-arg GMAIL_PASSW=<gmail password> -t rubuschl/ubootpatches:$(date +%Y%m%d%H%M%S) .
    10m...
```

## Sources

Obtain the tag number from docker images as below  

```
$ docker images
    REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/ubootpatches    20191203212934      70dce0bd5619        15 minutes ago      612MB
```

Obtain kernel sources or update

```
$ time docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/configs:/home/$USER/configs -v $PWD/u-boot:/home/$USER/u-boot rubuschl/ubootpatches:20191203212934
```


## Usage

Login into the docker container  

```
$ docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/configs:/home/$USER/configs -v $PWD/u-boot:/home/$USER/u-boot rubuschl/ubootpatches:20191203212934 /bin/bash
```

Obtain the current config as a starting point  

```
$ zcat /proc/config.gz > .config
```

Generate _TAGS_ file  

```
$ make tags
```

Build the kernel for debian as follows  

```
$ make -j8 deb-pkg all
```

Make sure to backup your work also outside the container.  

