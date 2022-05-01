#!/bin/bash

# stop the peer
systemctl stop teleport

# copy data
function  backup_data() {
  mv /data/teleport/ /data/teleport_bak
  mkdir /data/teleport
  cp -r /data/teleport_bak/config /data/teleport/config
  mkdir /data/teleport/data
  cp -r /data/teleport_bak/data/priv_validator_state.json /data/teleport/data/
}



function replace_vars(){
  # query latest height and hash
  latest=`curl -s https://rpc1.testnet.teleport.network/abci_info? | jq -r '.result.response.last_block_height' `
  snapshot=`expr $latest / 10000 \* 10000`
  hash=`curl -s https://rpc1.testnet.teleport.network/block?height=${snapshot} | jq -r '.result.block_id.hash '`

  # replace the config
  sed -i  's/enable = false/enable = true/g' /data/teleport/config/config.toml
  sed -i  's!rpc_servers = ""!rpc_servers = "https://rpc1.testnet.teleport.network:443,https://rpc1.testnet.teleport.network:443"!g' /data/teleport/config/config.toml

  trust_height='trust_height = '$snapshot''
  sed -i  "s/trust_height = 0/$trust_height/g" /data/teleport/config/config.toml

  pre_trust_hash='trust_hash = ""'
  trust_hash='trust_hash = "'$hash'"'
  sed -i  "s/$pre_trust_hash/$trust_hash/g" /data/teleport/config/config.toml
}


# skip the snapshot peer
function skip_snapshot_peers(){
  echo "skip snapshot peers"
  str1=`cat /data/teleport/config/config.toml`

  str2="snapshot0"
  result=$(echo $str1 | grep "${str2}")
  if [[ "$result" != "" ]]
  then
    return
  else
    echo "不包含${str2}"
  fi

  str2="snapshot1"
  result=$(echo $str1 | grep "${str2}")
  if [[ "$result" != "" ]]
  then
    return
  else
    echo "不包含${str2}"
  fi


  str2="snapshot2"
  result=$(echo $str1 | grep "${str2}")
  if [[ "$result" != "" ]]
  then
    return
  else
    echo "不包含${str2}"
  fi

  replace_vars

}

backup_data
replace_vars_in_config

# restart the peer
systemctl start teleport
