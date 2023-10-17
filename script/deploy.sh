#!/bin/bash

#if [ $(docker ps | grep -c "db") -eq 0 ]; then
#  echo "### Starting database ###"
#  docker-compose up -d db
#else
#  echo "db is already running"
#fi
#
#echo
#echo
#
#if [ $(docker ps | grep -c "redis") -eq 0 ]; then
#  echo "### Starting redis ###"
#  docker-compose up -d redis
#else
#  echo "redis is already running"
#fi

APP_NAME=web
DOCKER_DIR = /home/ubuntu/app/docker

IS_GREEN=$(cd $DOCKER_DIR && docker-compose ps | grep green) # 현재 실행중인 App이 blue인지 확인
DEFAULT_CONF=" /etc/nginx/nginx.conf"

if [ -z $IS_GREEN  ];then # blue라면

  echo "### BLUE => GREEN ###"


  echo "1. get green image"
  cd $DOCKER_DIR && docker-compose pull green # 이미지 받아서


  echo "2. green container up"
  cd $DOCKER_DIR && docker-compose up -d green # 컨테이너 실행

  while [ 1 = 1 ]; do
  echo "3. green health check..."
  sleep 3

  REQUEST=$(curl http://127.0.0.1:8080) # green으로 request
    if [ -n "$REQUEST" ]; then # 서비스 가능하면 health check 중지
            echo "health check success"
            break ;
            fi
  done;

  echo "4. reload nginx"
  sudo cp /etc/nginx/nginx.green.conf /etc/nginx/nginx.conf
  sudo nginx -s reload

  echo "5. blue container down"
  cd $DOCKER_DIR && docker-compose stop blue
else
  echo "### GREEN => BLUE ###"

  echo "1. get blue image"
  cd $DOCKER_DIR && docker-compose pull blue

  echo "2. blue container up"
  cd $DOCKER_DIR && docker-compose up -d blue

  while [ 1 = 1 ]; do
    echo "3. blue health check..."
    sleep 3
    REQUEST=$(curl http://127.0.0.1:8081) # blue로 request

    if [ -n "$REQUEST" ]; then # 서비스 가능하면 health check 중지
      echo "health check success"
      break ;
    fi
  done;

  echo "4. reload nginx"
  sudo cp /etc/nginx/nginx.blue.conf /etc/nginx/nginx.conf
  sudo nginx -s reload

  echo "5. green container down"
  cd $DOCKER_DIR && docker-compose stop green
fi