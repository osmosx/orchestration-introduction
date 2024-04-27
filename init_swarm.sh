#!/bin/bash

if [ "$HOSTNAME" = "manager01" ]; then
  MANAGER_IP=$(ip addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
  docker swarm init --advertise-addr $MANAGER_IP > /dev/null
  docker swarm join-token worker | grep "docker swarm join" > /vagrant_data/join_swarm.txt
fi

if [ "$HOSTNAME" = "worker01" -o "$HOSTNAME" = "worker02" ]; then
  sleep 10
  JOIN_CMD=$(cat /vagrant_data/join_swarm.txt)
  $JOIN_CMD
fi
