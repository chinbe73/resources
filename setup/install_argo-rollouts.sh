#!/bin/sh
#https://github.com/argoproj/argo-rollouts/releases
kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/v0.9.0/manifests/install.yaml
