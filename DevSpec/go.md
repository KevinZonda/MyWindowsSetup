# Go Spec

## File Hieriarchy

```txt
cmd/
    -> $cmdName: any entry programme
models/
    -> apimod: API Models
    -> dbmod: Database Models
    -> cfg.go or cfgmod: cfg Model
shared/ <- Single or Shared Instance
    -> 0.go: Initer
    -> cfg.go: cfg initer
    -> ...
lib/
    -> $libName: library used adapter (excl. svc), such as utils
// OTHERS, SPEC FOR SPECIAL SCENARIO, REFER TO H3 SECTIONS
```

A general init path is:

```
main()
  -> shared.InitCfg(bytes)
  -> shared.InitSvcs() <- init svc according to shared.cfg
    -> shared.initDb()
    -> shared.initXx()
    -> ...
  -> other funcs()
```

### File Hieriarchy Extention: Web Server

```
domain/
    -> 0.go: global svc register, usually give in gin.Route and register related svc
             e.g. xxxSvc.Register(route); yyySvcRegister(route)
    -> $controllerName/
        -> 0.go: svc initer, usually contains router registration & dependency register
        -> dao/: databse, file and other atomic operator.
        -> svc/: service related functions. it can combine several dao operators.
        -> handler/: HTTP handler, it combine svc calls
```

A domain is a business domain (refer to DDD design).

> **Difference between svc & dao.**  
> dao only contains db atomic operator, and do not specify any database. i.e. `func(db, xxxx)`.
> But to svc layer, they may want to do a transaction on dao, such as `db.Tx(func(tx) { dao.OperA(tx); dao.OperB(tx) }`.
> svc always holds their known db, but dao donesn't/

> **Call Layers** 
> Handler can call svc cross diferenct controllers, but no daos & handlers.
> Svc can call dao cross different controllers, but no svcs & handlers.

A general init path is:

```
main()
  -> shared.InitCfg(bytes)
  -> shared.InitSvcs() <- init svc according to shared.cfg
    -> shared.initDb()
    -> shared.initXx()
    -> ...
    -> shared.initRoute()
      -> controller.InitRoute(shared.GetGinEngine())
        -> svc1.InitRoute(eng)
        -> svc2.InitRoute(eng)
```

## Abbr

Abbr | Full
:--- | :---
svc | service
svr | server
clt | client
cli | CLI (Command Line Interface)
cfg | config
rcv/recv | receive
req | request
resp | response
gen | generate
oper | operator
neg | negative
pub | public
priv | private
fk | foreign key
pk | pub key
sk | sec key / priv key
sec | secret
ptr | pointer
fx/func | function
incr/inc | increase
dec | decode / decrease
plt | plot
opt | option
unk | unknown
mk | make
