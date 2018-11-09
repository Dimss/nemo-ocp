#!/usr/bin/env bash
if [ -z "$1" ]
then
      echo "Version is missing. Usage example: ./deploy.sh 0.3 "
      exit
fi
export APP_NAME=links
export IMAGE_TAG=$1
export VERSION=v$(echo $1 | tr . -)
export ISTIO_INJECT=$PWD/../istio-inject/i-config.yaml
export ISTIO_MESH=$PWD/../istio-inject/m-config.yaml
oc process -f dpl-tmpl.yaml -p VERSION=${VERSION} -p IMAGE_TAG=${IMAGE_TAG} -o yaml > ${APP_NAME}-${VERSION}.yaml
istioctl kube-inject --injectConfigFile ${ISTIO_INJECT} --meshConfigFile $ISTIO_MESH --filename ${APP_NAME}-${VERSION}.yaml --output tmp/i-${APP_NAME}-${VERSION}.yaml
rm -f ${APP_NAME}-${VERSION}.yaml
oc create -f tmp/i-${APP_NAME}-${VERSION}.yaml

