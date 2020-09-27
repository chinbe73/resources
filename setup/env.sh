alias hg="history | grep"
alias gps="git add . --all && git commit -m . && git push"
alias gap="git add . --all && git commit --allow-empty --amend --no-edit && git push -f"
alias grf="git fetch -f && git reset --hard \$(git rev-parse --abbrev-ref --symbolic-full-name @{u})"
alias grs="git reset --soft"
alias grh="git reset --hard"
alias gl="git log --pretty=oneline"
alias gs="git status"
alias gd="git diff"

#https://kubernetes.io/de/docs/reference/kubectl/cheatsheet/
source <(kubectl completion bash)
alias k='kubectl'
complete -F __start_kubectl k
alias kset='kubectl config set-context --current'
function ns () { kset --namespace=$1; }
export ARGOCD_OPTS='--port-forward-namespace argocd'
alias a="argocd"
