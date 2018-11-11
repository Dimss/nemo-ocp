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