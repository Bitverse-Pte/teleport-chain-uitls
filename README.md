# teleport-rollback-utils

unsafe-rollback:
- rollback to height-1
- rollback to any previous height.

## 1.build binary
```shell
git clone git@github.com:teleport-network/teleport.git
cd teleport
git checkout rollback-cmd
make install
```

## 2.check build success

If run the `teleport --help`, will found the `rollback` && `rollback-any` in the subcommands.

## 3.usage

##### 3.1 rollback to the height-1
```shell
teleport rollback --height 28
```

##### 3.2 rollback to any previous height
```shell
tendermint rollback-any --height 28
```

### 4.simple 4 nodes demo

##### 4.1. build binary for docker
```shell
cd 4_four_nodes
sh build_for_docker.sh
```


##### 4.2. clear the pre data
```shell
sh clear.sh
```

##### 4.3 start the nodes
```shell
sh startNodes.sh
```


##### 4.4 rollback the height-1
```shell
sh rollback.sh
```

##### 4.5 rollback to any height
for example: If we want to rollback to the heigth: `50`
```shell
sh rollback-any.sh 50
```


### reference materials:

- https://github.com/cosmos/cosmos-sdk/pull/11179
- https://github.com/teleport-network/teleport/tree/rollback-cmd
- https://github.com/teleport-network/cosmos-sdk/tree/rollback-cmd
- https://github.com/teleport-network/tendermint/tree/rollback-cmd
