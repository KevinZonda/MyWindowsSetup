# Path Spec for Linux

## Mount

Kind | Path
:--- | :---
Model Ckpt | `/mnt/modelzoo/$AUTHOR/$MODEL_NAME`
Data Ckpt  | `/mnt/datazoo/$MODEL_BASE_OR_TASK_KIND/$DATASET_NAME`
WebDAV     | `/mnt/webdav`



## Web

Kind | Path | Alternative Path
:--- | :--- | :---
SSL Cert | `/var/cert/$URL/pub`  |  `/var/www/cert/$URL/pub`
SSL Priv | `/var/cert/$URL/priv` | `/var/www/cert/$URL/priv`
Webroot  | `/var/www/$URL`
