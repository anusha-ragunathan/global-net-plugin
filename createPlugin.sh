#!/bin/bash

PLUGIN_SRC_DIR=$GOPATH/src/github.com/anusha-ragunathan/global-net-plugin
IMAGE_NAME=global-net
PLUGIN_NAME=global-net-plugin
HUB_USERNAME=aragunathan
DOCKERFILE=Dockerfile.nested

# directory for plugin create
PLUGIN_CREATE_DIR=$PLUGIN_SRC_DIR/pluginsrc
PLUGIN_CONFIG=config.json

# build plugin image
pushd $PLUGIN_SRC_DIR
docker build . -t $IMAGE_NAME -f $DOCKERFILE
id=`docker create $IMAGE_NAME`
echo "container with $IMAGE_NAME created" $id

# Prepare plugin source
mkdir -p $PLUGIN_CREATE_DIR/rootfs
cp $PLUGIN_CONFIG $PLUGIN_CREATE_DIR/config.json
docker export $id -o $PLUGIN_CREATE_DIR/rootfs.tar
tar xvf $PLUGIN_CREATE_DIR/rootfs.tar -C $PLUGIN_CREATE_DIR/rootfs
rm $PLUGIN_CREATE_DIR/rootfs.tar

# create plugin
docker plugin create $HUB_USERNAME/$PLUGIN_NAME $GLOBAL_NET_PLUGIN/$PLUGIN_CREATE_DIR

# enable plugin
docker plugin enable $HUB_USERNAME/$PLUGIN_NAME

popd

# plugin is build and enabled. we can remove PLUGIN_CREATE_DIR
rm -rf $PLUGIN_CREATE_DIR
