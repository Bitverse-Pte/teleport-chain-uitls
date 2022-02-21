docker stop peer3
docker rm peer3


teleport  rollback --home ~/teleport_testnet/validators/validator3/teleport/
sleep 20


docker run -itd  --net teleport-br7  --ip 172.172.0.5 --name=peer3 -p 8575:8545 -p 8576:8546 -p 26686:26656 -p 26687:26657 -v ~/teleport_testnet/validators/validator3/teleport/:/root/teleport  -v $GOPATH/bin/teleport_ubuntu:/usr/bin/teleport arm64v8/ubuntu:20.04  teleport start --home /root/teleport --log_level info --json-rpc.api eth,txpool,personal,net,debug,web3,miner

docker logs -f peer3 --tail=1000
