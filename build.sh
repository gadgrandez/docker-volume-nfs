#!/bin/bash

docker plugin disable gadgrandez/nfs -f
docker plugin rm gadgrandez/nfs -f
rm -rf plugin

git pull
docker build . -t gadgrandez/nfs

id=$(docker create gadgrandez/nfs true)
mkdir -p plugin/rootfs
cp config.json plugin/
docker export "$id" | sudo tar -x -C plugin/rootfs
docker rm -vf "$id"
docker rmi gadgrandez/nfs

docker plugin create gadgrandez/nfs plugin/
docker plugin enable gadgrandez/nfs
docker plugin ls
