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
function ksetns () { kset --namespace=$1; }
alias a="argocd --port-forward"
