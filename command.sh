#!/bin/bash

function error() {
    echo $*
    exit 1
}

function parameterError() {
    if [[ -z $1 ]]
    then
        error "parameter error"
    else
        error $1
    fi
}

# clean
# parameters:
#   1 repository name
#   2 version
function clean() {
    docker container stop test
    docker container rm test
    docker image rm $1:$2
}

# build
# parameters:
#   1 repository name
#   2 version
function build() {
    docker build . -t $1:$2
    docker run -itd --name test $1:$2
}

REPO=$(grep repo ./build/information | awk '{print $2}')
CURRENT_VERSION=$(grep version ./build/information | awk '{print $2}')
if [ -z $1 ]
then
    parameterError "blank"
elif [[ $1 == "clean" ]]
then
    clean $REPO $CURRENT_VERSION
elif [[ $1 == "rebuild" ]]
then
    clean $REPO $CURRENT_VERSION
    build $REPO $CURRENT_VERSION
elif [[ $1 == "update" ]]
then
    if [ -z $2 ]
    then
        parameterError "need new version"
    fi
    NEW_VERSION=$2
    clean $REPO $CURRENT_VERSION
    build $REPO $NEW_VERSION
    cat ./build/information | awk -v newVersion=$NEW_VERSION '{if($1=="version") {print $1,newVersion} else {print $1,$2}}' > ./build/temp
    mv ./build/temp ./build/information
elif [[ $1 == "push" ]]
then
    git add .
    if [[ -z $2 ]]
    then
        git commit -m "update"
    else
        git commit -m "$2"
    fi
    git push origin master
    docker push $REPO:$CURRENT_VERSION
fi
