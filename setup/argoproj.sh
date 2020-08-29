kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v1.7.2/manifests/install.yaml
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

kubectl create namespace argo-rollouts
kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/v0.9.0/manifests/install.yaml

ADMIN_PASSWORD=admin
watch kubectl -n argocd get deploy
argocd --port-forward login --username admin --password $ADMIN_PASSWORD
if [ $? -ne 0 ]; then
    argocd --port-forward login --username admin --password $(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2)
    argocd --port-forward account update-password --current-password $(kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2) --new-password $ADMIN_PASSWORD
    argocd --port-forward login --username admin --password admin
fi
