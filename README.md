# Linux Server - Instalation server with docker

Basic configuration of linux server

- Nginx Proxy
- Let's Encrypt
- Backup with notification (bot files and db dumps)
- SQL Server 2022

## Instalation
1. Run install.sh which installs
   1. Basic confguration
   2. ufw - Uncomplicated FireWall
   3. Install docker
   4. Creates docker network called nginx-proxy
2. Copy docker-compose.yml to some folder on the host 
3. In that folder run ``` docker-compose up -d```
4. That's it 

## Adding proxy
TODO

## Backups
TODO

## How to connect to DB
TODO

## Firewall (UFW)
TODO