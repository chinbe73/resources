#!/bin/sh
#https://kubernetes.github.io/ingress-nginx/deploy/#gce-gke
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.35.0/deploy/static/provider/cloud/deploy.yaml
