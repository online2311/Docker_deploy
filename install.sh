curl -fsSL https://get.docker.com | bash
curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose
rm -rf `which dc`
ln -s /usr/local/bin/docker-compose /usr/bin/dc

echo -n "请输入安装目录（默认/www/wwwroot/proxypanel）: "
read install_dir
idir=${install_dir:-"/www/wwwroot/proxypanel"}

mkdir -p $idir && cd $idir
wget https://raw.githubusercontent.com/ColetteContreras/proxypanel-docker/main/docker-compose.yml
wget https://raw.githubusercontent.com/ColetteContreras/proxypanel-docker/main/env
sed -i "s|APP_KEY=placeholder|APP_KEY=base64:$(openssl rand -base64 32)|" env
dc pull && dc up -d
