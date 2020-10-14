#!/bin/sh
kubectl create namespace argocd
kubectl apply -n argocd -f - << EOF
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: argocd-operator
spec:
  channel: alpha
  installPlanApproval: Automatic
  name: argocd-operator
  source: community-operators
  sourceNamespace: openshift-marketplace
---
apiVersion: argoproj.io/v1alpha1
kind: ArgoCD
metadata:
  name: argocd
spec:
  dex:
#    image: quay.io/dexidp/dex
    version: v2.22.0
#  image: argoproj/argocd:v1.7.7
  redis:
#    image: redis
    version: 5.0.8
  server:
#    insecure: true
    route:
      enabled: true
#      path: /
#      TLS:
#        insecureEdgeTerminationPolicy: Redirect
#        termination: passthrough
#      wildcardPolicy: None
  tls:
    initialCerts:
      visana-machine-v3.crt: |
$(cat $(dirname $0)/resources/visana-machine-v3.crt | sed 's/^/        /')
      visana-root-v3.crt: |
$(cat $(dirname $0)/resources/visana-root-v3.crt | sed 's/^/        /')
      www-proxy-rtc.visana.ch-2019.crt: |
$(cat $(dirname $0)/resources/www-proxy-rtc.visana.ch-2019.crt | sed 's/^/        /')
      www-proxy-wp.visana.ch-2019.crt: |
$(cat $(dirname $0)/resources/www-proxy-wp.visana.ch-2019.crt | sed 's/^/        /')
  version: v1.7.7
EOF
