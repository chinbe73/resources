#!/bin/sh
#https://github.com/argoproj/argo-cd/releases
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v1.7.7/manifests/install.yaml
#kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
kubectl apply -n argocd -f - << EOF
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: argocd-server-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    nginx.ingress.kubernetes.io/ssl-passthrough: "true"
    nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
spec:
  rules:
  - host: argocd
    http:
      paths:
      - backend:
          serviceName: argocd-server
          servicePort: https
EOF

$(dirname $0)/set_argo-cd_login.sh
