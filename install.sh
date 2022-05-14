function installDocker {
  which docker

  if [ $? -eq 0 ]
  then
      docker --version | grep "Docker version"
      if [ $? -eq 0 ]
      then
          echo "docker existing"
      else
          curl -fsSL https://get.docker.com | bash
      fi
  else
      curl -fsSL https://get.docker.com | bash
  fi
}

installDocker

curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod a+x /usr/local/bin/docker-compose
rm -rf `which dc`
ln -s /usr/local/bin/docker-compose /usr/bin/dc

mkdir -p ${install_dir} && cd ${install_dir}
curl -fsSL https://raw.githubusercontent.com/online2311/Docker_deploy/main/docker-compose.yml -o docker-compose.yml
curl -fsSL https://raw.githubusercontent.com/online2311/Docker_deploy/main/env -o env

mysqlPW="$(openssl rand -hex 12)"

sed -i "s|APP_KEY=placeholder|APP_KEY=base64:$(openssl rand -base64 32)|" env
sed -i "s|MYSQL_ROOT_PASSWORD=proxypanel|MYSQL_ROOT_PASSWORD=${mysqlPW}|" env
sed -i "s|DB_PASSWORD=proxypanel|DB_PASSWORD=${mysqlPW}|" env

dc pull && dc up -d && dc exec -it web php artisan migrate --seed --force

echo "MySQL root password: ${mysqlPW}"
echo "Show logs: cd ${install_dir} && dc logs -f web"
