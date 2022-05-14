# ProxyPanel Docker Deploy

### Install

```
(yum install curl 2> /dev/null || apt install curl 2> /dev/null) && \
install_dir="/www/wwwroot/proxypanel" \
bash <(curl -L https://raw.githubusercontent.com/online2311/Docker_deploy/main/install.sh)
```

**cd /www/wwwroot/proxypanel**

### Update

```
dc pull && dc up -d
```

### Restart

```
dc restart web
```

### Show logs

```
dc logs -f web
```
