#!/bin/sh

sed -i "s|127.0.0.1 ${URL}||g" /etc/hosts;

docker-compose -f ${PWD}/srcs/docker-compose.yml down
# if docker ps -aq 
# then
#     docker rm -f $(docker ps -aq)
# fi
#only remove containers if they exist

if docker images ls -aq
then
    docker rmi -f $(docker images -aq)
fi
docker volume rm $(docker volume ls)

rm -rf /home/srachdi/data