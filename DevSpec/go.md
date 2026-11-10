# Go 开发规范

## 目录结构

```txt
cmd/
    -> $cmdName: 各个程序的入口
models/
    -> apimod: API 数据模型
    -> dbmod: 数据库模型
    -> cfg.go 或 cfgmod: 配置模型
shared/ <- 单例或共享实例
    -> 0.go: 初始化入口
    -> cfg.go: 配置初始化
    -> ...
lib/
    -> $libName: 库的适配封装（不含 svc），例如 utils
// 特定场景下的其他目录约定，参见下方三级标题中的说明
```

通常按以下顺序初始化：

```
main()
  -> shared.InitCfg(bytes)
  -> shared.InitSvcs() <- 根据 shared.cfg 初始化服务
    -> shared.initDb()
    -> shared.initXx()
    -> ...
  -> 其他函数调用
```

### 目录结构扩展：Web 服务端

```
domain/
    -> 0.go: 统一的服务注册入口，通常接收 Gin 路由对象，并注册相关服务
             例如：xxxSvc.Register(route); yyySvcRegister(route)
    -> $domainName/
        -> 0.go: 服务初始化入口，通常包含路由注册和依赖注册
        -> dao/: 数据库、文件等资源的原子操作
        -> svc/: 业务逻辑，可组合多个 dao 操作
        -> handler/: HTTP 请求处理，可组合多个 svc 调用
```

domain 表示业务领域，可参考领域驱动设计（DDD）。

> **svc 与 dao 的区别**
>
> dao 只包含数据库原子操作，不绑定具体的数据库实例，而是通过参数接收实例，例如 `func(db, xxxx)`。  
> svc 层可以将多个 dao 操作放在同一个事务中执行，例如 `db.Tx(func(tx) { dao.OperA(tx); dao.OperB(tx) })`。  
> svc 持有其使用的数据库实例，dao 则由调用方传入。

> **分层调用规则**
>
> handler 可以跨 domain 调用 svc，但不能调用 dao 或其他 handler。
> svc 可以跨 domain 调用 dao，但不能调用其他 svc 或 handler。

通常按以下顺序初始化：

```
main()
  -> shared.InitCfg(bytes)
  -> shared.InitSvcs() <- 根据 shared.cfg 初始化服务
    -> shared.initDb()
    -> shared.initXx()
    -> ...
    -> shared.initRoute()
      -> domain.InitRoute(shared.GetGinEngine())
        -> svc1.InitRoute(eng)
        -> svc2.InitRoute(eng)
```

### 目录结构扩展：Scale Web 服务端

业务规模较小时，svc 可以采用包级函数（静态函数）的形式，通过包级变量或 shared 获取所需资源。随着业务复杂度增加，如果需要隔离依赖、支持不同配置的服务实例，或方便测试时替换依赖，可以将 svc 改为对象，由实例持有数据库等资源。

每个 domain 负责组装并持有自己的 svc 实例。创建 domain 时，通过参数传入所需资源，再由 domain 创建 svc。数据库连接池等共享资源仍由外部统一创建和管理，svc 保存这些资源的引用。

```txt
domain/
    -> 0.go: 组装各个 domain，传入所需资源，并按需初始化调用入口
    -> $domainName/
        -> 0.go: 定义 Domain、初始化参数和 Init，创建并持有 svc 实例
        -> init_http.go: 可选，注册 HTTP 路由，将 svc 实例注入 handler
        -> init_func_call.go: 可选，提供进程内函数调用入口
        -> dao/: 数据库、文件等资源的原子操作，所需资源由调用方传入
        -> svc/: 定义服务对象，持有所需资源，并通过方法实现业务逻辑
        -> handler/: 定义 HTTP 请求处理对象，持有所需的 svc 实例
```

初始化流程示意：

```txt
d := domain1.Init(params)
  -> svc := &domain1Svc.Service{DB: params.DB, Z: params.Z}
  -> d := &Domain{svc: svc}
  -> 返回 d

d.InitHttp(route)       // 按需启用 HTTP 入口
  -> 创建 handler，注入 d 持有的 svc
  -> 注册路由

d.InitFuncCall()        // 按需启用进程内函数调用入口
  -> 基于 d 持有的 svc 暴露调用接口
```

`Init` 负责创建实例，`InitHttp`、`InitFuncCall` 等方法负责初始化不同的调用入口，并复用已创建的 svc。是否拆分入口、入口如何暴露，取决于具体场景；仅提供 HTTP 服务时，调用入口可以只保留 `InitHttp`，实例仍由 `Init` 创建。

业务调用时，handler 调用注入的 svc 实例方法，svc 再调用 dao。前述分层调用规则继续适用；改为实例后，跨 domain 使用的 svc 也通过参数显式注入。

这种结构主要用于隔离依赖和管理实例。是否采用，应根据业务复杂度和依赖管理需求决定，无需仅因请求量增加就将所有 svc 改为对象。

## 初始化与生命周期约定

### 0.go 与初始化顺序

`0.go` 是团队约定的初始化入口文件名，可以继续使用，无需统一改成 `init.go`。文件名只用于组织代码，禁止依赖文件名决定初始化顺序。

Go 普通函数的执行顺序由显式调用决定。`Init` 是普通函数，不会因为位于 `0.go` 中而自动执行，也不同于 Go 自动调用的 `init()`。资源和业务实例之间存在初始化依赖时，应由外层组件按依赖顺序显式调用。

### 生命周期方法命名

初始化实例、注册调用入口和启动服务应分别表达，按以下职责命名：

方法 | 职责
:--- | :---
`Init` | 创建资源和业务实例，接收并组装依赖
`InitHttp` | 注册 HTTP 路由、注入 handler 依赖，不启动监听
`InitFuncCall` | 按需提供进程内函数调用入口
`Run` | 启动服务，例如监听端口或运行后台任务
`Close` | 释放组件自身拥有的资源
`Shutdown(ctx)` | 在需要优雅停机时，停止接收新工作，等待在途工作结束，并按资源归属完成清理

按实际职责提供这些方法，无需为每个组件实现全部方法。`Close` 和 `Shutdown` 也不要求同时存在；如果同时提供，应明确两者的关系，避免重复释放资源。

### 资源归属与释放

资源生命周期由创建它的组件负责管理。将资源注入 domain 或 svc，只是传递使用权，不转移关闭责任；这一点在 Scale 模式下尤其需要明确。

- 共享 DB、Redis 连接池由创建它们的外层组件统一关闭，domain 和 svc 不得自行关闭注入的共享连接池。
- domain 内部创建并独占的资源，由该 domain 的 `Close()` 或 `Shutdown(ctx)` 释放；如果只有注入的资源引用，可以不提供关闭方法。
- HTTP Server 由创建并启动它的服务端组件负责关闭，domain 的 `InitHttp` 只注册路由。

退出时按依赖关系安排清理顺序：先停止接收新请求和任务，等待在途请求及后台任务结束，再释放 domain 自有资源，最后由外层组件关闭共享 DB、Redis 等资源。若等待超时，后续处理应由外层停机逻辑统一决定，避免仍在运行的任务继续使用已关闭的资源。

## 缩写约定

缩写 | 英文全称及中文含义
:--- | :---
svc | service，服务
svr | server，服务端
clt | client，客户端
cli | command line interface，命令行界面
cfg | config，配置
rcv/recv | receive，接收
req | request，请求
resp | response，响应
gen | generate，生成
oper | operator，操作或运算符
neg | negative，负值或否定
pub | public，公开的
priv | private，私有的
fk | foreign key，外键
pk | public key / primary key，公钥或主键
sk | secret key / private key，密钥或私钥
sec | secret，秘密
ptr | pointer，指针
fx/func | function，函数
incr/inc | increase，增加
dec | decode / decrease，解码或减少
plt | plot，绘图
opt | option，选项
unk | unknown，未知
mk | make，创建
