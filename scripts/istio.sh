#!/bin/bash

function install_istio() {
  istioctl install -f istio/istio-operator.yaml -y
}

function apply_peer_auth() {
  kubectl apply -f istio/peerauthentication.yaml
}

kubectl label namespace default istio-injection=enabled --overwrite 

# Check if an argument was provided
if [ $# -eq 0 ]; then
  echo "No argument provided. Usage: $0 [istio|peer_auth|all]"
  exit 1
fi

# Check which argument was provided and call the appropriate function(s)
if [ "$1" == "istio" ]; then
  install_istio
elif [ "$1" == "peer_auth" ]; then
  apply_peer_auth
elif [ "$1" == "all" ]; then
  install_istio
  apply_peer_auth
else
  echo "Invalid argument. Usage: $0 [istio|peer_auth|all]"
  exit 1
fi

