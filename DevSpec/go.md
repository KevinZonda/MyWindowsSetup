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
    -> $controllerName/
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
> handler 可以跨 controller 调用 svc，但不能调用 dao 或其他 handler。
> svc 可以跨 controller 调用 dao，但不能调用其他 svc 或 handler。

通常按以下顺序初始化：

```
main()
  -> shared.InitCfg(bytes)
  -> shared.InitSvcs() <- 根据 shared.cfg 初始化服务
    -> shared.initDb()
    -> shared.initXx()
    -> ...
    -> shared.initRoute()
      -> controller.InitRoute(shared.GetGinEngine())
        -> svc1.InitRoute(eng)
        -> svc2.InitRoute(eng)
```

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
