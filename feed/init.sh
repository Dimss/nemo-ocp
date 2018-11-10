oc apply -f service.yaml
istioctl create -f rule.yaml

oc get services
oc get destinationrules
oc get virtualservices

