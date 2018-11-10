#!/usr/bin/env bash
# Fix SCC
oc login -u system:admin
oc adm policy add-scc-to-group anyuid system:authenticated

# Create project and login to docker registry 
oc login -u developer
oc new-project nemo
oc policy add-role-to-user registry-viewer developer
oc policy add-role-to-user registry-editor developer
docker login -u openshift -p $(oc whoami -t) 172.30.1.1:5000

# Istio access
oc login -u system:admin
oc new-project istio-system
oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z default -n istio-system
oc adm policy add-scc-to-user anyuid -z prometheus -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-egressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-citadel-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-ingressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-cleanup-old-ca-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-post-install-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-sidecar-injector-service-account -n istio-system
oc adm policy add-scc-to-user privileged -z istio-sidecar-injector-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-galley-service-account -n istio-system
oc adm policy add-scc-to-user privileged -z default -n nemo
oc apply -f istio.yaml
sleep 3
oc apply -f istio.yaml
oc project nemo
oc apply -f ../tel/i-deployment.yaml

# Push  application images
docker push 172.30.1.1:5000/nemo/likes:0.10
docker push 172.30.1.1:5000/nemo/feed:0.10
docker push 172.30.1.1:5000/nemo/comments:0.10
docker push 172.30.1.1:5000/nemo/identity:0.10
docker push 172.30.1.1:5000/nemo/receiver:0.10
docker push 172.30.1.1:5000/nemo/links:0.10
docker push 172.30.1.1:5000/nemo/mongo:latest
docker push 172.30.1.1:5000/nemo/postgres:latest
docker push 172.30.1.1:5000/nemo/tkit:latest




