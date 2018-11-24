## Post-JetPack3.2 Docker-CE setup
#  (run as root)

# Update libs, install prereqs for commands
sudo apt-get update && sudo apt-get upgrade && sudo apt-get -y install curl apt-transport-https

# Install Docker-CE
echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu xenial edge" >/etc/apt/sources.list.d/docker.list
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -qq - >/dev/null
sudo apt-get update && sudo apt-get install docker-ce
sudo systemctl enable docker

# Test Docker install
sudo docker run --rm -it arm64v8/ubuntu:16.04 cat /etc/issue

## At this point, if you choose, switch docker's install dir to point to a path on 
# your SSD:
# service docker stop
# mv /var/lib/docker /media/nvidia/storage/           #(or wherever you choose on your SSD)
# ln -s /media/nvidia/storage/docker /var/lib/docker  #(first path: use dir of your choice)
# optional: for experimental features (such as --squash): echo '{"experimental":true}' > /etc/docker/daemon.json
# service docker start

