#!/bin/bash
sudo apt-get update

echo "Installing docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# Docker Root agent
echo "Creating the portainer agent for the root user"
sudo docker run -d -p 9011:9001 --name portainer_agent_root --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker/volumes:/var/lib/docker/volumes portainer/agent:latest

# Run commands as ubuntu user
UBUNTU_UID=`su ubuntu -c "id -u"`
echo $UBUNTU_UID

echo "Starting the setup of docker rootless"
su - ubuntu -c "sudo apt-get update && sudo apt-get install uidmap -y"
su - ubuntu -c "dockerd-rootless-setuptool.sh install"

echo "Adding config to ubuntu's .bashrc file"
su ubuntu -c "echo $'\nexport PATH=/usr/bin:\$PATH\nexport DOCKER_HOST=unix:///run/user/$UBUNTU_UID/docker.sock' >> ~/.bashrc"

echo "Creating the portainer agent container"
su ubuntu -c "export PATH=/usr/bin:$PATH && export DOCKER_HOST=unix:///run/user/$UBUNTU_UID/docker.sock && docker run --rm hello-world && docker run -d -p 9012:9001 --name portainer_agent_rootless --restart=always -v /run/user/$UBUNTU_UID/docker.sock:/var/run/docker.sock -v ~/.local/share/docker/volumes:/var/lib/docker/volumes portainer/agent:latest"

echo "Enabling linger for ubuntu user"
sudo loginctl enable-linger ubuntu