echo 'start script'
echo "if [ -f '/home/gitpod/google-cloud-sdk/path.bash.inc' ]; then . '/home/gitpod/google-cloud-sdk/path.bash.inc'; fi" >> ~/.bashrc
echo "if [ -f '/home/gitpod/google-cloud-sdk/completion.bash.inc' ]; then . '/home/gitpod/google-cloud-sdk/completion.bash.inc'; fi" >> ~/.bashrc
echo "if [ -f '/workspace/resources/setup/shortcuts.sh' ]; then . '/workspace/resources/setup/shortcuts.sh'; fi" >> ~/.bashrc
. ~/.bashrc
gcloud auth login
gcloud container clusters get-credentials cluster-1 --zone us-central1-c --project big-mender-287619
