# 容器手术

对已有容器进行手术级更改。

首先获得容器长 HASH, 例如 `927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9`。

## Step 1. 停止 podman

```sh
sudo podman stop 927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9
sudo systemctl stop podman podman.socket
```

## Step 2. 备份容器配置数据库

首先备份数据库
```sh
cd /var/lib/containers/storage
cp db.sql db.sql.bak
```

### Step 3. 查找并确认容器配置

使用 SQLite3 进行修改数据库
```sh
sudo apt install sqlite3
sqlite3 db.sql
```

容器数据通常存储在 `ContainerConfig` 表（`.tables` 可以查看表），
```sql
.schema ContainerConfig
```
获取容器的 schema

我这里是 
```sql
CREATE TABLE ContainerConfig(
                ID              TEXT    PRIMARY KEY NOT NULL,
                Name            TEXT    UNIQUE NOT NULL,
                PodID           TEXT,
                JSON            TEXT    NOT NULL,
                FOREIGN KEY (ID)    REFERENCES IDNamespace(ID)    DEFERRABLE INITIALLY DEFERRED,
                FOREIGN KEY (ID)    REFERENCES ContainerState(ID) DEFERRABLE INITIALLY DEFERRED,
                FOREIGN KEY (PodID) REFERENCES PodConfig(ID)
        );
```

查询数据集
```sh
SELECT cc.Name
FROM ContainerConfig AS cc
WHERE ID = '927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9';
```

明确容器名正确后，可以查询

```sh
SELECT cc.Name, cc.JSON
FROM ContainerConfig AS cc
WHERE ID = '927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9';
```

获得容器配置（位于 `JSON`）。

## Step 4. 修改配置

SQLite3 支持 JSON，因此你可以用 SQL + JSON 修改这个容器，例如

```sql
UPDATE ContainerConfig
SET JSON = json_replace(
  JSON,
  '$.spec.mounts[0].source',
  '/data/rds/kevin/v2'
)
WHERE ID = '927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9'
  AND json_extract(JSON, '$.spec.mounts[0].source') = '/data/rds/kevin/v1';
```

修改后验证

```
SELECT
  json_extract(JSON, '$.spec.mounts[0].source') AS source,
  json_extract(JSON, '$.spec.mounts[0].destination') AS destination
FROM ContainerConfig
WHERE ID = '927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9';
```

在完成后，使用 `Ctrl+D` 退出 SQLite。

## Step 5. （可选）更新 overlay-container

> 这一步是没必要的，因为容器启动后会 podman 会自动实施。

进入
```sh
/var/lib/containers/storage/overlay-containers/$CONTAINER_HASH/userdata
```

例如我就是

```sh
cd /var/lib/containers/storage/overlay-containers/927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9/userdata
```

修改 `config.json` 匹配你的修改。

## Step 6. 启动容器

```sh
sudo systemctl start podman podman.sock
sudo podman start 927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9
```

验证

```sh
sudo podman inspect 927895e7d70a8d58e4afbad7374c67d87d2cc357b5ee71cb4ed974cb840b13d9
```
