#!/usr/bin/env bash

set -o errexit
set -o nounset

if [ "${VERBOSE}" == "true" ] ; then
set -o xtrace
fi

PWD=$(pwd)
cd ${WORKSPACE}/${APP_DIR}/
GITCOMMITID=$(git rev-parse --short=15 HEAD)

mkdir -p "${WORKSPACE}/${ARTIFACT_DIR}"
cp -r ${WORKSPACE}/${MANIFEST_GIT_DIR}/${APP_NAME}/docker/* ${WORKSPACE}/${ARTIFACT_DIR}/

DOCKER_VERSION="$(date "+%Y-%m-%d-%s"-${BUILD_NUMBER})-${GITCOMMITID}"

DOCKER_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

echo "===================================="
echo "DOCKER_REGISTRY : ${DOCKER_REGISTRY}"
echo "===================================="

cd ${WORKSPACE}/${ARTIFACT_DIR}/

docker build --no-cache -t ${DOCKER_REGISTRY}/${APP_NAME}:${DOCKER_VERSION} .

if [ $? !=  0 ] ; then
  echo "Docker Build failed"
  exit 1
fi

eval $(aws ecr get-login --no-include-email --region ${AWS_REGION})
docker push ${DOCKER_REGISTRY}/${APP_NAME}:${DOCKER_VERSION}

echo "===================================="
echo "DOCKER IMAGE : ${DOCKER_REGISTRY}/${APP_NAME}:${DOCKER_VERSION}"
echo "===================================="
