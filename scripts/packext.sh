#!/bin/sh

############################################
# Piotr Pierzak <piotrek.pierzak@gmail.com>
############################################

############################################
# When executing, as parameter please provide path to extension directory.
# Example usage:
# ./packext.sh ~/Workspace/magento-2.2/src/app/code/Cminds/MultiUserAccounts
#
# After executing above commands, in result in current directory two packages
# will be created:
# cminds-multiuseraccounts-1.1.17.zip
# cminds-multiuseraccounts-1.1.17-bundle.zip
#
# In above example version of the extension was 1.1.17.
#
# To easily execute this command you can create alias for it.
# Example alias:
# alias packext="~/Workspace/dotfiles/scripts/packext.sh"
############################################

DEBUG=0

CURR_DIR=$PWD

EXT_DIR="$1"
WORK_DIR="$HOME/packext"
TMP_DIR="$WORK_DIR/tmp"

CORE_EXT_GIT_URL="git@bitbucket.org:cminds/magento2-extension-cminds-core.git"
CORE_EXT_DIR="$WORK_DIR/core-ext"

echo "Creating extension packages..."

if [[ -z $EXT_DIR ]] ; then
    echo "Path has been not provided!"
    exit -1
else
    echo "Looking for extension files in path: $EXT_DIR"
fi

####
# 1. Creating working directory.
####
if [[ ! -d $WORK_DIR ]] ; then
    echo "Creating working directory..."
    mkdir $WORK_DIR
fi
####
# 2. Checking if core extension exists, fetching it or updating.
####
if [[ ! -d $CORE_EXT_DIR ]] ; then
    echo "Fetching core extension..."
    CLONE_CMD="git clone $CORE_EXT_GIT_URL $CORE_EXT_DIR"
    CLONE_CMD_RUNn=$($CLONE_CMD 2>&1)

    if [[ $DEBUG == 1 ]] ; then
        echo "Running: \n$ $CLONE_CMD\n"
        echo "${CLONE_CMD_RUN}\n"
    fi
else
    echo "Updating core extension..."
    UPDATE_CMD="git -C $CORE_EXT_DIR pull origin master"
    UPDATE_CMD_RUN=$($UPDATE_CMD 2>&1)

    if [[ $DEBUG == 1 ]] ; then
        echo "Running: \n$ $UPDATE_CMD\n"
        echo "${UPDATE_CMD_RUN}\n"
    fi
fi

####
# 3. Copying pointed extension to working directory.
####
rm -rf $TMP_DIR
CP_CMD="cp -R $EXT_DIR $TMP_DIR"
CP_CMD_RUN="$($CP_CMD 2>&1)"

if [[ ! -z $CP_CMD_RUN ]] ; then
    if [[ $DEBUG == 1 ]] ; then echo "${CP_CMD_RUN}\n" ; fi
    echo "Ups... Something goes wrong with copying pointed extension. Please enable debug mode to get more information.\n"
    exit -1
fi

cd $WORK_DIR
rm -rf $TMP_DIR/.git

####
# 4. Get extension name and version.
####
PACK_NAME=""
PACK_VER=""

namePattern="\"Cminds[\W]+([a-zA-Z]*)[\W]+\": \"([^\"]*)"\"
verPattern="\"version\": \"([^\"]*)\""

echo "Processing extension files..."
while read -r l; do
    if [[ $l =~ $namePattern ]]; then
        PACK_NAME="${BASH_REMATCH[1]}"
        echo "Found extension name: $PACK_NAME"
    fi
    if [[ $l =~ $verPattern ]]; then
        PACK_VER="${BASH_REMATCH[1]}"
        echo "Found extension version: $PACK_VER"
    fi
done < $TMP_DIR/composer.json

if [[ -z $PACK_NAME ]] ; then
    echo "Extension name not found!"
    exit -1
fi
if [[ -z $PACK_VER ]] ; then
    echo "Extension version not found!"
    exit -1
fi

L_PACK_NAME="$(tr [A-Z] [a-z] <<< "$PACK_NAME")"

####
# 4. Creating single package.
####
SINGLE_FILE_NAME="cminds-$L_PACK_NAME-$PACK_VER"
FULL_SINGLE_FILE_NAME="$SINGLE_FILE_NAME.zip"

mv $TMP_DIR $WORK_DIR/$SINGLE_FILE_NAME

PACK_CMD="zip -r $FULL_SINGLE_FILE_NAME $SINGLE_FILE_NAME"
PACK_CMD_RUN="$($PACK_CMD 2>&1)"
if [[ $DEBUG == 1 ]] ; then
    echo "Running: \n$ $PACK_CMD\n"
    echo "${PACK_CMD_RUN}\n"
fi
mv $FULL_SINGLE_FILE_NAME $CURR_DIR/$FULL_SINGLE_FILE_NAME

echo "Package $FULL_SINGLE_FILE_NAME has been created."

####
# 5. Creating bundle package.
####
BUNDLE_FILE_NAME="cminds-$L_PACK_NAME-$PACK_VER-bundle"
FULL_BUNDLE_FILE_NAME="$BUNDLE_FILE_NAME.zip"

mkdir -p "$BUNDLE_FILE_NAME/app/code/Cminds"
mv $SINGLE_FILE_NAME "$BUNDLE_FILE_NAME/app/code/Cminds/$PACK_NAME"
cp -R $CORE_EXT_DIR "$BUNDLE_FILE_NAME/app/code/Cminds/Licensing"
rm -rf "$BUNDLE_FILE_NAME/app/code/Cminds/Licensing/.git"

PACK_CMD="zip -r $FULL_BUNDLE_FILE_NAME $BUNDLE_FILE_NAME"
PACK_CMD_RUN="$($PACK_CMD 2>&1)"
if [[ $DEBUG == 1 ]] ; then
    echo "Running: \n$ $PACK_CMD\n"
    echo "${PACK_CMD_RUN}\n"
fi
mv $FULL_BUNDLE_FILE_NAME $CURR_DIR/$FULL_BUNDLE_FILE_NAME

echo "Package $FULL_BUNDLE_FILE_NAME has been created."

rm -rf $WORK_DIR/$BUNDLE_FILE_NAME
cd $CURR_DIR

echo "Finished!"

exit 0
