#!/bin/bash

rm -rf ~/teleport_testnet
cp -r teleport_testnet ~/

docker rm -f $(docker ps -aq)

# remove existed network
docker network rm  teleport-br7

# create new network
docker network create --subnet=172.172.0.0/24 teleport-br7

# start-contianer
docker run -itd  --net teleport-br7  --ip 172.172.0.2 --name=peer0 -p 8545:8545 -p 8546:8546 -p 26656:26656 -p 26657:26657 -v ~/teleport_testnet/validators/validator0/teleport/:/root/teleport  -v $GOPATH/bin/teleport_ubuntu:/usr/bin/teleport arm64v8/ubuntu:20.04  teleport start --home /root/teleport --log_level info --json-rpc.api eth,txpool,personal,net,debug,web3,miner
docker run -itd  --net teleport-br7  --ip 172.172.0.3 --name=peer1 -p 8555:8545 -p 8556:8546 -p 26666:26656 -p 26667:26657 -v ~/teleport_testnet/validators/validator1/teleport/:/root/teleport  -v $GOPATH/bin/teleport_ubuntu:/usr/bin/teleport arm64v8/ubuntu:20.04  teleport start --home /root/teleport --log_level info --json-rpc.api eth,txpool,personal,net,debug,web3,miner
docker run -itd  --net teleport-br7  --ip 172.172.0.4 --name=peer2 -p 8565:8545 -p 8566:8546 -p 26676:26656 -p 26677:26657 -v ~/teleport_testnet/validators/validator2/teleport/:/root/teleport  -v $GOPATH/bin/teleport_ubuntu:/usr/bin/teleport arm64v8/ubuntu:20.04  teleport start --home /root/teleport --log_level info --json-rpc.api eth,txpool,personal,net,debug,web3,miner
docker run -itd  --net teleport-br7  --ip 172.172.0.5 --name=peer3 -p 8575:8545 -p 8576:8546 -p 26686:26656 -p 26687:26657 -v ~/teleport_testnet/validators/validator3/teleport/:/root/teleport  -v $GOPATH/bin/teleport_ubuntu:/usr/bin/teleport arm64v8/ubuntu:20.04  teleport start --home /root/teleport --log_level info --json-rpc.api eth,txpool,personal,net,debug,web3,miner
