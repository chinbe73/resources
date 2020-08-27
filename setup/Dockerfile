FROM gitpod/workspace-full

USER gitpod

RUN brew tap argoproj/tap && brew install kubectl hub argoproj/tap/argocd && \
    curl https://sdk.cloud.google.com | bash -s -- --disable-prompts
