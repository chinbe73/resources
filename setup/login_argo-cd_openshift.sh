#!/bin/sh
CURRENT_ADMIN_PASSWORD=$(kubectl get secret argocd-cluster -o jsonpath='{.data.admin\.password}' | base64 -d)
echo $CURRENT_ADMIN_PASSWORD
argocd --port-forward --port-forward-namespace argocd login --username admin --password $CURRENT_ADMIN_PASSWORD
