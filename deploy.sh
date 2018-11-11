#!/usr/bin/env bash
GREEN='\033[1;32m'
CYAN='\e[01;96m'
NC='\033[0m' 
### Init cluster
echo -e "${GREEN}Init cluster...${NC}"
cd cluster-init
./init.sh
sleep 10
cd ../
echo -e "${GREEN}Init cluster done!${NC}"

### Deploy data services
echo -e "${GREEN}Deploy data services...${NC}"
cd identity
oc create -f pg.yaml
cd ../links
oc create -f mongo.yaml
cd ../likes
oc create -f mongo.yaml
cd ../comments
oc craete -f mongo.yaml
cd ../
sleep 10
echo -e "${GREEN}Data services deployed!${NC}"


### Deploy links service
echo -e "${GREEN}Deploying links service . . .${NC}"
cd links
./init.sh
sleep 3
./deploy.sh 0.10
cd ../
echo -e "${GREEN}Links service deployed!${NC}"

### Deploy comments service
echo -e "${GREEN}Deploying comments service . . .${NC}"
cd comments
./init.sh
sleep 3
./deploy.sh 0.10
cd ../
echo -e "${GREEN}Comments service deployed!${NC}"

### Deploy likes service
echo -e "${GREEN}Deploying Likes service. . .${NC}"
cd likes
./init.sh
sleep 3
./deploy.sh 0.10
cd ../
echo -e "${GREEN}Likes service deployed!${NC}"

### Deploy identity service
echo -e "${GREEN}Deploying Identity service. . .${NC}"
cd identity
./init.sh
sleep 10
./deploy.sh 0.10
cd ../
echo -e "${GREEN}Identity service deployed!${NC}"

### Deploy receiver service
echo -e "${GREEN}Deploying Receiver service. . .${NC}"
cd receiver
./init.sh
sleep 5
./deploy.sh 0.10
cd ../
echo -e "${GREEN}Receiver service deployed${NC}"

### Deploy feed service
echo -e "${GREEN}Deploying Feed service. . .${NC}"
cd feed
./init.sh
sleep 5
./deploy.sh 0.10
cd ../
echo -e "${GREEN}Feed service deployed!${NC}"

### Deploy Kiali
echo -e "${GREEN}Deploying Kiali service. . .${NC}"
cd kiali
./init.sh
sleep 5
cd ../
echo -e "${GREEN}Feed service deployed!${NC}"

echo -e "${CYAN}*** PHOTOGRAM APPLICATION HAS BEEN SUCCESSFULLY DEPLOYED! ***${NC}"
