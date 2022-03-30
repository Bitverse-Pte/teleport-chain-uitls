# teleport-rollback-utils

### prepare
```shell
git clone https://github.com/teleport-network/cosmos-sdk.git
git checkout rollback-v0.34
cd cosmos-sdk
make install
```

### 执行顺序

备份数据，以防止回滚失败。
```
tar -cvf teleport_bak.tar /data/teleport
```


执行命令1：
```
simd rollback-any --home /data/teleport --height ${height} --rollbackMode iavl-storage-1
```
正常情况下上述命令1可以成功回滚。

当上面指令裁剪数据后节点重启失败，并抛出以下错误

```shell
panic: version 22 was already saved to different hash C704EF921CAAEDC2175886D8634757C12038708701C3CCF2A6FBF7EBAA1230BF (existing hash 1C5A9A5D805AAA14C3F488F8EE3FE00C607005D15E8E1777EBB3E5BDBEFB94C9)

goroutine 122 [running]:
github.com/cosmos/cosmos-sdk/store/iavl.(*Store).Commit(0xc001798c70)
	github.com/cosmos/cosmos-sdk@v0.45.0/store/iavl/store.go:112 +0x165
github.com/cosmos/cosmos-sdk/store/rootmulti.commitStores(0x16, 0xc001982390)
	github.com/cosmos/cosmos-sdk@v0.45.0/store/rootmulti/store.go:974 +0x150
github.com/cosmos/cosmos-sdk/store/rootmulti.(*Store).Commit(0xc0013ac790)
	github.com/cosmos/cosmos-sdk@v0.45.0/store/rootmulti/store.go:388 +0x6f
github.com/cosmos/cosmos-sdk/baseapp.(*BaseApp).Commit(0xc001882820)
	github.com/cosmos/cosmos-sdk@v0.45.0/baseapp/abci.go:308 +0x231
github.com/tendermint/tendermint/abci/client.(*localClient).CommitSync(0xc0017b3da0)
	github.com/tendermint/tendermint@v0.34.15/abci/client/local_client.go:264 +0xb6
github.com/tendermint/tendermint/proxy.(*appConnConsensus).CommitSync(0x0)
	github.com/tendermint/tendermint@v0.34.15/proxy/app_conn.go:93 +0x22
github.com/tendermint/tendermint/state.(*BlockExecutor).Commit(_, {{{0xb, 0x0}, {0xc000634a20, 0x26}}, {0xc001816b30, 0xf}, 0x11, 0x16, {{0xc0012df100, ...}, ...}, ...}, ...)
	github.com/tendermint/tendermint@v0.34.15/state/execution.go:228 +0x269
github.com/tendermint/tendermint/state.(*BlockExecutor).ApplyBlock(_, {{{0xb, 0x0}, {0xc000634a20, 0x26}}, {0xc001816b30, 0xf}, 0x11, 0x16, {{0xc0012df100, ...}, ...}, ...}, ...)
	github.com/tendermint/tendermint@v0.34.15/state/execution.go:180 +0x6ee
github.com/tendermint/tendermint/blockchain/v0.(*BlockchainReactor).poolRoutine(0xc00079c380, 0x0)
	github.com/tendermint/tendermint@v0.34.15/blockchain/v0/reactor.go:398 +0xb7b
created by github.com/tendermint/tendermint/blockchain/v0.(*BlockchainReactor).OnStart
	github.com/tendermint/tendermint@v0.34.15/blockchain/v0/reactor.go:110 +0x85

```

继续执行下列命令2。
```shell
simd rollback-any --home /data/teleport --height ${height} --rollbackMode iavl-storage-2
```


### 注意事项

- 无法直接执行命令2，有可能会直接破坏数据。
- 命令1和命令2的区别在于节点panic时，对state的修改不同所导致。后面会考虑将命令1和命令2合在一条命令中。
- 不太适合一次性裁剪太多的区块，实际测试耗时严重。建议在上次100个区块左右。
- tendemrint v0.34.14 和 v0.35 db的存储结构大不相同，当tendermint升级到v0.35时，测试工具需要做相应修改。


### 测试方法

在`binary`文件夹中提供了一个正常节点和恶意节点，恶意节点在高度21时会通过自己的cosmos-sdk篡改数据库。
