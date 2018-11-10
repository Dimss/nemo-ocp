oc create -f mongo.yaml
oc create -f service.yaml

oc get services
oc get destinationrules
oc get virtualservices