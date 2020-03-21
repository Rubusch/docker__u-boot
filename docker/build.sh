#!/bin/bash -e
HOME="/home/$(whoami)"
BRANCH="master"
SOURCES="${HOME}/u-boot"
CONFIGS="${HOME}/configs"
SHARES=( ${SOURCES} ${CONFIGS} )

## fix permissions
for item in ${SHARES[*]}; do
    test -e ${item} && sudo chown $(whoami).$(whoami) -R ${item}
done

cd ${HOME}

## get sources
if [[ -d "${SOURCES}/.git" ]]; then
  cd ${SOURCES}
  git fetch --all
else
  git clone -j4 --branch $BRANCH https://gitlab.denx.de/u-boot/u-boot.git u-boot
fi

## generate TAGS
cd ${SOURCES}
rm -f ./TAGS
find . -regex ".*\.\(h\|c\)$" -exec etags -a {} \;

## setup checkpatch / codespell
echo "#!/bin/sh" > ${SOURCES}/.git/hooks/post-commit
echo "exec git show --format=email HEAD | ./scripts/checkpatch.pl --strict --codespell" >> ${SOURCES}/.git/hooks/post-commit
chmod a+x ${SOURCES}/.git/hooks/post-commit

cd ${SOURCES}
make clean

echo "READY."
echo
