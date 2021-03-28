#!/bin/bash -e
HOME="/home/$(whoami)"
BRANCH="master"
SOURCES_DIR="${HOME}/u-boot"
CONFIGS_DIR="${HOME}/configs"
SECRETS_DIR="${HOME}/secrets"
SHARES=( ${SOURCES_DIR} ${CONFIGS_DIR} ${SECRETS_DIR} )

## fix permissions
for item in ${SHARES[*]}; do
    test -e ${item} && sudo chown $(whoami).$(whoami) -R ${item}
done

if [[ ! -f ${SECRETS_DIR}/.gitconfig ]]; then
    cp ${CONFIGS_DIR}/.gitconfig ${SECRETS_DIR}/.gitconfig
    echo "!!! FIRST TIME INSTALLATION !!!"
    echo "!!!"
    echo "!!! PLEASE FILL SECRET INFORMATION (NOT GIT TRACKED) IN"
    echo "!!! '${SECRETS_DIR}/.gitconfig'"
    echo "!!! THEN LOGIN AGAIN"
    echo "!!!"
    exit 0
fi

cd ${HOME}

## get sources
if [[ -d "${SOURCES_DIR}/.git" ]]; then
  cd ${SOURCES_DIR}
  git fetch --all
else
  git clone -j4 --branch $BRANCH https://gitlab.denx.de/u-boot/u-boot.git u-boot
fi

## generate TAGS
cd ${SOURCES_DIR}
rm -f ./TAGS
find . -regex ".*\.\(h\|c\)$" -exec etags -a {} \;

## setup checkpatch / codespell
echo "#!/bin/sh" > ${SOURCES_DIR}/.git/hooks/post-commit
echo "exec git show --format=email HEAD | ./scripts/checkpatch.pl --strict --codespell" >> ${SOURCES_DIR}/.git/hooks/post-commit
chmod a+x ${SOURCES_DIR}/.git/hooks/post-commit

cd ${SOURCES_DIR}
make clean

echo "READY."
echo
