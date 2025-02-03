#!/bin/bash
set -x
apt update -y 
apt install -y python3.12-venv python3.12-dev build-essential git curl libmariadb-dev-compat 

# XLTD Auctioneer Vars
AUCTIONEER_PATH="/opt/ffxi/auctioneer"
# Server Vars
SERVER_PATH="/opt/ffxi/server"
SERVER_SETTINGS_PATH="${SERVER_PATH}/settings"
SERVER_TOOLS_PATH="${SERVER_PATH}/tools"
SERVER_LOG_PATH="${SERVER_PATH}/log"
# VERSION 
VERSION="base"

# Pull Repos

# Builtin Auctioneer Detection/Installation Method
if [ ! -d $AUCTIONEER_PATH ]; then
    mkdir $AUCTIONEER_PATH
    pushd $AUCTIONEER_PATH
    python3.12 -m venv .
    popd
fi

# LSB Server Detection/Installation Method
if [ ! -d $SERVER_PATH ]; then
    mkdir $SERVER_PATH
    pushd $SERVER_PATH
    git clone --recursive https://github.com/LandSandBoat/server.git .
    popd
fi

pushd $SERVER_PATH
git stash
git fetch --all
git checkout $VERSION
git pull origin $VERSION
git stash pop
popd

cp $SERVER_SETTINGS_PATH/default/* $SERVER_SETTINGS_PATH/
cp $SERVER_TOOLS_PATH/requirements.txt $SERVER_TOOLS_PATH/auctioneer.txt

echo "ffxiahbot" >> $SERVER_TOOLS_PATH/auctioneer.txt
$AUCTIONEER_PATH/bin/python3.12 -m pip install --no-cache-dir --upgrade -r $SERVER_TOOLS_PATH/auctioneer.txt
rm -rf $SERVER_TOOLS_PATH/auctioneer-requirements.txt
