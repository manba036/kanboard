#!/bin/sh

docker exec kanboard   sh -c "kill 1"
docker exec db         sh -c "kill 1"
docker exec phpmyadmin sh -c "kill 1"
docker-compose down