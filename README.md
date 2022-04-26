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
