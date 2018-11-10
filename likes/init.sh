oc create -f mongo.yaml
oc create -f service.yaml
istioctl create -f rule.yaml
oc get services
