# China Mirror Settings

```sh
pip config set global.index-url https://mirrors.aliyun.com/pypi/simple
```

```pwsh
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

```pwsh
pnpm config set registry "https://registry.npmmirror.com"
npm config set registry "https://registry.npmmirror.com"
```
