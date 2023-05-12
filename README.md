# Aurelius Atlas docker compose

## Description of the deployment result
TODO: an abstract of the services deployed

TODO: Create a diagram similar to Andreas from the presentation - should give the basic intution of the connections (ssh from local machine to server)

## Installation Requirements


This installation assumes that you have the following:

- Server
    - docker
    - docker compose
    - ssh server

- Local machine
    - ssh client

This description is based on a linux deployment

## Hardware requirments
TODO: Server requirments -> 32GB RAM, 4CPU, DISK SPACE MENTION MINIMUM

## How to connect to the docker-compose environment?

#### If deployment on local machine
- No additional action is required (follow the steps [here](#steps-before-spin-up)) 

#### Deployment on VM with public domain name
- Connect to the VM using as destination its public IP

#### Deployment on VM without public domain name

- Connect to the VM using as destination its private IP 

- Define a ssh tunnel to the IP of the VM
- - TODO: Include putty for windows and cmd command for linux

```
8087 -> 127.0.0.1:8087
```


TODO: for local machine
- Extend hosts file with the following line (admin right required)
```
127.0.0.1       localhost localhost4 {{ replace hostname }}
```

##  Environment variables responsible for user/pass
if fork advantage that the code gets updated with new features

- git clone/

- adjustment of env variables / conf files

## Steps before spin up:

If docker service is not running (admin right required):
```
sudo service docker start
```
Retrieve the eth0 IP (main network interface) from your host machine using:
```
export EXTERNAL_IP=$(ifconfig eth0 | grep 'inet' | cut -d: -f2 | sed -e 's/.*inet \([^ ]*\).*/\1/')
```

Execute the following script to replace the EXTERNAL_IP

- Explain functionality of script

```
./retrieve_ip.sh
```

In order for elastic stack to spin up (admin right required):
```
sudo sysctl -w vm.max_map_count=262144
```
- create link to some document explaining the variable - elastic documentation

## Spin up docker-compose environment:
```
docker compose up
```

Please wait patiently for few minutes for containers to spin up. Then you should be able
to access the reverse proxy at: 

http://{{ IP or Hostname }}:8087/

- provide evidences how the user will undestand that everything is good to go 


## Setting up the environment:

#### Notes:

- How to restart Apache Atlas?
```
docker exec -it atlas /bin/bash
cd /opt/apache-atlas-2.2.0/bin/
python atlas_stop.py
python atlas_start.py
exit
```

- How to restart reverse proxy?
```
apachectl restart
```