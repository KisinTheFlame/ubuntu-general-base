REPO=kisintheflame/ubuntu-general-base

docker container stop test
docker container rm test
docker image rm $REPO:$1
docker build . -t $REPO:$1
docker run -itd --name test $REPO:$1