#!/bin/bash


REGISTRY_SERVER=${1-'https://harbor.fumai.com/v2/'}
REGISTRY_USER=${2-'admin'}
REGISTRY_PASS=${3-'Harbor12345'}
REGISTRY_EMAIL=${4-'1zoxun1@gmail.com'}

SECRET_NAME=${5-'regcred'}
NAMESPACE=${6-'default'}

# 1. create secret method.
kubectl --namespace=$NAMESPACE create secret docker-registry $SECRET_NAME  --docker-server=$REGISTRY_SERVER --docker-username=$REGISTRY_USER --docker-password=$REGISTRY_PASS  --docker-email=$REGISTRY_EMAIL

# 2. create secret method too.
#kubectl --namespace=$NAMESPACE create secret   generic  $SECRET_NAME --from-file=.dockerconfigjson=config.json --type=kubernetes.io/dockerconfigjson

kubectl get secret $SECRET_NAME -n $NAMESPACE --output="jsonpath={.data.\.dockerconfigjson}" | base64 -d

