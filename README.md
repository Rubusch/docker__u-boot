# Docker: u-boot for patches


A docker image for patch development. A ``build.sh`` script will in a second step clone a staging tree. ``configs`` and ``staging`` tree will be setup outside the container, but shared with the container.  


## Build

The setup needs a gmail email address for patch delivery via ``git send-email``. Many other email providers are possible in general, too  

**NODE** Fix up missing email settings in provided git config at TODO   

```
$ cd docker

$ docker-compose up
```

## Usage

```
$ docker-compose -f ./docker-compose.yml run --rm u-boot_devel /bin/bash


TODO rm

**NOTE** Replace ``gmail user name``, ``email@gmail.com`` and ``gmail password`` with your gmail credentials  

**NOTE** For the gamil password escape ``<`` and ``>`` i.e. write ``\\\<`` and ``\\\>``, in any case don't use quotes.  

```
$ cd ./docker

$ docker build --no-cache --build-arg USER=$USER --build-arg GMAIL_USER="<gmail user name>" --build-arg GMAIL=<email@gmail.com> --build-arg GMAIL_PASSW=<gmail password> -t rubuschl/ubootpatches:$(date +%Y%m%d%H%M%S) .
    10m...
```

## Sources

Obtain the tag number from docker images as below  

```
$ docker images
    REPOSITORY               TAG                 IMAGE ID            CREATED             SIZE
    rubuschl/ubootpatches    20191203212934      70dce0bd5619        15 minutes ago      612MB
```

Obtain sources or update

```
$ time docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/configs:/home/$USER/configs -v $PWD/u-boot:/home/$USER/u-boot rubuschl/ubootpatches:20191203212934
```


## Usage

Login into the docker container  

```
$ docker run --rm -ti --user=$USER:$USER --workdir=/home/$USER -v $PWD/configs:/home/$USER/configs -v $PWD/u-boot:/home/$USER/u-boot rubuschl/ubootpatches:20191203212934 /bin/bash
```

Make sure to backup your work also outside the container.  
