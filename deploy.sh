#!/bin/bash
set -e

if [ $# -eq 0 ]
    then
        BRANCH=$(git rev-parse --abbrev-ref HEAD)
    else
        BRANCH=$1
fi

if [ $BRANCH == "master" ]
then
    POSTGRESQL_VERSION="9.6"
    IMAGE_TAG="latest"
else
    POSTGRESQL_VERSION="$(echo $BRANCH | cut -d'-' -f1)"
    IMAGE_TAG=$BRANCH
fi

echo $BRANCH

deploy() {
    IMAGE_TAG=$1
    POSTGRESQL_VERSION=$2
    IMAGE=nvtienanh/postgresql:$IMAGE_TAG
    docker build \
     -t $IMAGE \
     --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
     --build-arg VCS_REF=`git rev-parse --short HEAD` \
     --build-arg POSTGRESQL_VERSION=$POSTGRESQL_VERSION .
    docker push $IMAGE
}


deploy $IMAGE_TAG $ZEPPELIN_VERSION
# Update Microbadger
curl -X POST https://hooks.microbadger.com/images/nvtienanh/postgresql/4w3yZBgJhVDCQtHOapich660Eq4=
