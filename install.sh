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
curl -fsSL https://raw.githubusercontent.com/ColetteContreras/proxypanel-docker/main/docker-compose.yml -o docker-compose.yml
curl -fsSL https://raw.githubusercontent.com/ColetteContreras/proxypanel-docker/main/env -o env
sed -i "s|APP_KEY=placeholder|APP_KEY=base64:$(openssl rand -base64 32)|" env
dc pull && dc up -d
