#!/bin/bash

docker_cmd="docker"
docker_compose_cmd="docker-compose"

#Declare service  array
SvcArray=("jcloud-front-svc" "jcloud-bs-svc"  "jcloud-cs-svc"  "jcloud-fs-svc" \
 "jcloud-idp-svc"  "jcloud-rs-apiserver-svc"  "jcloud-rs-synchronize-svc" "jcloud-ts-svc" \
 "kubestar-svc" "jcloud-message-svc" "jcloud-message-email" "jcloud-message-sms" "jcloud-nginx-svc")

function check_and_install_docker () {
  which "$docker_cmd" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		return 0
	fi
  echo "Do docker install"
	yum update && yum install -y yum-utils && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && yum install -y docker-ce docker-ce-cli containerd.io
  systemctl  start docker && systemctl  enable docker
  if [ $? -eq 0 ]; then
    echo "Docker: Install docker successfully"
    return 0
  fi
  return  $?
}

function check_and_install_docker_compose () {
  which "$docker_compose_cmd" >/dev/null 2>&1
	if [ $? -eq 0 ]; then
		return 0
	fi
	echo "Do docker-compose install"
  curl -SL https://github.com/docker/compose/releases/download/v2.7.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
  if [ $? -eq 0 ]; then
    echo "Docker-compose: Install docker-compose successfully"
    return 0
  fi
  return  $?
}

function start_mongodb() {
    docker-compose  up mongo1 mongo2 mongo3  -d
    sleep 5
    while true ;do
      if [[ -n $(docker ps -q -f "name=^mongo1$") ]];then
        echo "Mongo1: Start mongo1 successfully"
        break
      else
        docker-compose  up mongo1 mongo2 mongo3  -d
        sleep 5
        continue
      fi
    done

    while true ;do
      if [[ -n $(docker ps -q -f "name=^mongo2$") ]];then
        echo "Mongo2: Start mongo2 successfully"
        break
      else
        docker-compose  up mongo1 mongo2 mongo3  -d
        sleep 5
        continue
      fi
    done

    while true ;do
      if [[ -n $(docker ps -q -f "name=^mongo3$") ]];then
        echo "Mongo3: Start mongo3 successfully"
        break
      else
        docker-compose  up mongo1 mongo2 mongo3  -d
        sleep 5
        continue
      fi
    done
}

function start_mysql() {
    while true ;do
      if [[ -n $(docker ps -q -f "name=^mysql$") ]];then
        echo "Mysql: Start mysql successfully"
        break
      else
        docker-compose  up mysql-svc  -d
        sleep 5
        continue
      fi
    done
}

function start_redis() {
    while true ;do
      if [[ -n $(docker ps -q -f "name=^redis$") ]];then
        echo "Redis: Start redis successfully"
        break
      else
        docker-compose  up redis-svc  -d
        sleep 5
        continue
      fi
    done
}

function mongodb_cluster_init() {
    docker exec mongo1 /scripts/init-mongodb-cluster.sh

    # add mongodb user for opsphere fs serivce
    while true ;do
        ret=`docker exec mongo1 /scripts/add-mongodb-user.sh`
        result="already exists"
        if [[ $ret =~ $result ]];then
            echo "Mongodb: Add mongodb user jcloud_fs done"
            break
        else
            sleep 3;
        fi
    done;
}


function start_opsphere() {
  for svc in ${SvcArray[*]}; do
     docker-compose  up $svc -d
  done
  while true ;do
    if [[ -n $(docker ps -q -f "name=^jcloud-nginx$") ]];then
      echo "Start Opsphere Successfully"
      break
    else
      sleep 5
      continue
    fi
  done
}

check_and_install_docker
check_and_install_docker_compose
start_mongodb
mongodb_cluster_init
start_mysql
start_redis
start_opsphere
