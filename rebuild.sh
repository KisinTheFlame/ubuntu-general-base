#!/bin/bash
OLD_VERSION=$1
NEW_VERSION=$2
if [[ $NEW_VERSION == "" ]]
then
    NEW_VERSION=$1
fi

echo "Old Version: $OLD_VERSION"
echo "New Version: $NEW_VERSION"

REPO=kisintheflame/ubuntu-general-base

docker container stop test
docker container rm test
docker image rm $REPO:$OLD_VERSION
docker build . -t $REPO:$NEW_VERSION
docker run -itd --name test $REPO:$NEW_VERSION