export IDENTITY_IP=$(oc get service | grep identity | awk '{print $3}')
#export PAYLOAD='{"email":"user1@gmail.com","password":"111"}'
#curl -H "Content-Type: application/json" -X POST --data $PAYLOAD http://$IDENTITY_IP/v1/signup | jq .
#curl -H "Content-Type: application/json" -X POST --data $PAYLOAD http://$IDENTITY_IP/v1/login | jq .
curl http://$IDENTITY_IP/v1/system/info | jq .
