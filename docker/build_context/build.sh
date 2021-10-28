#!/bin/sh -e
MY_USER="${USER}"
MY_HOME="/home/${MY_USER}"
BRANCH="master"
WORKSPACE_DIR="${MY_HOME}/workspace"
SOURCES_DIR="${WORKSPACE_DIR}/u-boot"
CONFIGS_DIR="${MY_HOME}/configs"
SECRETS_DIR="${MY_HOME}/secrets"

## prepare
00_defenv.sh "${WORKSPACE_DIR}" "${CONFIGS_DIR}" "${SECRETS_DIR}"

if [ ! -f "${SECRETS_DIR}/.gitconfig" ]; then
    cp "${CONFIGS_DIR}/.gitconfig" "${SECRETS_DIR}/.gitconfig"
    echo "!!! FIRST TIME INSTALLATION !!!"
    echo "!!!"
    echo "!!! PLEASE FILL SECRET INFORMATION (NOT GIT TRACKED) IN"
    echo "!!! '${SECRETS_DIR}/.gitconfig'"
    echo "!!! THEN LOGIN AGAIN"
    echo "!!!"
    exit 0
fi

## get sources
if [ -d "${SOURCES_DIR}/.git" ]; then
  pushd "${SOURCES_DIR}" &> /dev/null
  git fetch --all
  popd &> /dev/null
else
  pushd "${MY_HOME}" &> /dev/null
  git clone -j4 --branch "${BRANCH}" https://gitlab.denx.de/u-boot/u-boot.git u-boot
  popd &> /dev/null
fi

## generate TAGS
#cd "${SOURCES_DIR}"
#rm -f ./TAGS
#find . -regex ".*\.\(h\|c\)$" -exec etags -a {} \;

## setup checkpatch / codespell
echo "#!/bin/sh" > ${SOURCES_DIR}/.git/hooks/post-commit
echo "exec git show --format=email HEAD | ./scripts/checkpatch.pl --strict --codespell" >> "${SOURCES_DIR}/.git/hooks/post-commit"
chmod a+x "${SOURCES_DIR}/.git/hooks/post-commit"

cd "${SOURCES_DIR}"
make clean

echo "READY."
echo
