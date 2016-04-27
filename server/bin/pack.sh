#!/usr/bin/env bash
echo 'start'

cd ../../../..

CURDIR=`pwd`
HOME=env | grep ^HOME= | cut -c 6-
TARGET=appinhouse_server
APPNAME=inhouse_service
export GOPATH="$CURDIR"

cd src/appinhouse/$APPNAME

echo 'get and build'
go get -v

go build -o appinhouse

echo 'package...'
bee pack -o "$HOME" -exr pack.sh


echo 'deploy...'
cd ~
if [ ! -d $TARGET ];
    then
        echo "File $TARGET not found."
		mkdir $TARGET
    else
        rm -rf $TARGET
        mkdir $TARGET
fi
tar -zxvf $APPNAME.tar.gz -C $TARGET
echo "deploy file in $HOME/$TARGET" 
echo 'finished'