#! /bin/bash

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.11.0 sh -

PROFILE=demo

if [ ! -z $1]; then
    PROFILE=$!
fi

mv istio-1.11.0 ~/istio-1.11.0
cd ~/istio-1.11.0
export PATH=$PWD/bin:$PATH
istioctl install --set profile=${PROFILE} -y
istioctl profile list
istioctl operator init
