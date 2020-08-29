FROM gitpod/workspace-full

USER gitpod

RUN set -x; \
    brew tap argoproj/tap && brew install kubectl hub argoproj/tap/argocd && \
    curl https://sdk.cloud.google.com | bash -s -- --disable-prompts && \
    ( \
        cd "$(mktemp -d)" && \
        curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" && \
        tar zxvf krew.tar.gz && \
        KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" && \
        "$KREW" install krew \
    ) && \
    export PATH="$HOME/.krew/bin:$PATH" && \
    kubectl krew install ingress-nginx && \
    echo '. /home/gitpod/google-cloud-sdk/path.bash.inc' >> ~/.bashrc && \
    echo '. /home/gitpod/google-cloud-sdk/completion.bash.inc' >> ~/.bashrc && \
    echo '. /workspace/resources/setup/env.sh' >> ~/.bashrc && \
    echo 'export PATH="'$HOME'/.krew/bin:$PATH"' >> ~/.bashrc
