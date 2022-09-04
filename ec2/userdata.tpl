#!/bin/bash
sudo apt update
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
dockerd-rootless-setuptool.sh install
bash -c "echo $'\nexport PATH=/usr/bin:\$PATH\nexport DOCKER_HOST=unix:///run/user/$(id -u)/docker.sock'" >> ~/.bashrc
exec $SHELL
# Non rootless agent
sudo docker run -d -p 9011:9001 --name portainer_agent_root --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest
# Docker Rootless agent
docker run -d -p 9012:9001 --name portainer_agent_rootless --restart=always -v /$XDG_RUNTIME_DIR/docker.sock:/var/run/docker.sock -v ~/.local/share/docker/volumes:/var/lib/docker/volumes portainer/agent:latest