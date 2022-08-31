#!/bin/bash
I=`apt-cache policy docker | grep "Installed" ` #проверяем состояние пакета
if [ -n "$I" ] #проверяем что нашли строку со статусом (что строка не пуста)
then
   echo " installed" #выводим результат
else
   echo " not installed"
   echo " Install"
   apt-get update
   apt-get install \
   ca-certificates \
   curl \
   gnupg \
   lsb-release
   mkdir -p /etc/apt/keyrings
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
   echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
   apt-get update
   apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
fi

Y=`docker ps | grep "nginx_test" ` 
if [ -n "$Y" ] 
then
   echo "Docker container is runnung and will be steped and removed" && docker stop nginx_test 
else
   echo "Docker container is not running"
fi
