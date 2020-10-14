#!/bin/sh
ADMIN_PASSWORD=admin
kubectl -n argocd get deploy
for i in {1..90}; do
    if [ $(kubectl -n argocd get deploy --no-headers | awk '{if ($2=="1/1") print $2}' | wc -l) -ge 5 ]; then
        printf "ok\n"
        break
    fi
    printf .
    sleep 2
done
kubectl -n argocd get deploy
argocd --port-forward --port-forward-namespace argocd login --username admin --password $ADMIN_PASSWORD
if [ $? -ne 0 ]; then
    argocd --port-forward --port-forward-namespace argocd login --username admin --password $(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2)
    argocd --port-forward --port-forward-namespace argocd account update-password --current-password $(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2) --new-password $ADMIN_PASSWORD
    argocd --port-forward --port-forward-namespace argocd login --username admin --password admin
fi
