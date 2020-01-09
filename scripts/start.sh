#!/usr/bin/env bash

ABSDIR=$( dirname "$(readlink -f -- "$0")" )
source ${ABSDIR}/profile.sh

REPOSITORY=/home/ec2-user/app/step3
PROJECT_NAME=freelec-springboot2-webservice

cp $REPOSITORY/zip/*.jar $REPOSITORY/

echo "> 새 애플리케이션 배포"

JAR_NAME=$(ls -tr $REPOSITORY/*.jar | tail -n 1)

echo "> JAR Name: $JAR_NAME"

echo "> $JAR_NAME 에 실행권한 추가"

chmod +x $REPOSITORY/zip/*

echo "> $JAR_NAME 실행"
echo "> $IDLE_PROFILE 프로파일 "

nohup java -jar \
-Dspring.config.location=classpath:/application.properties,classpath:/application-$IDLE_PROFILE.properties,\
/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
-Dspring.profiles.active=$IDLE_PROFILE $JAR_NAME > $REPOSITORY/nohup.out 2>&1 &
