# teleport 工具集合。

主要包含以下工具：
- rollback
- statereader
- export
- analysis_data

### statereader

```shell
./statereader 高度 home目录
e.g
./statereader 100 /home/wenbin/teleport_testnetv1/validators/validator9/teleport/
```

### export
```shell
mkdir output
./export 100 /home/wenbin/teleport_testnetv1/validators/validator9/teleport/ ./output/
```

### analysis
```shell
./analysis-state -false_dir $PWD/export_data/false/320434/ \
 -true_dir $PWD/export_data/true/320434/
```

### parse

##### parse address
```shell
./parse -input 021493354845030274cd4bf1686abd60ab28ec52e1a76174656c65 -isParseAddress true 
```

##### parse balance
```shell

./parse -input 0a056174656c6512173431333632343936353930323030303030303030303030 -isParseBalances true 
```


##### parse base64
```shell
./parse -input MTA1MDA5MDAwMDAwMDAwMGF0ZWxl -isParseBase64 true
```

