# Linux Server - Instalation server with docker

### Basic configuration of linux server
- Nginx Proxy
- Let's Encrypt
- OPTIONAL: Backup with notification (both files and db dumps)
- OPTIONAL: Monitor
- OPTIONAL: SQL Server 2022

## Instalation
1. Run install.sh. You can run it with ```./install.sh``` in its folder. Maybe you'll need to set permissions with chmod. This script does:
   1. Basic server confguration
   2. ufw - Uncomplicated FireWall
   3. Install docker
   4. Creates docker network called nginx-proxy
2. Copy docker-compose.yml to **/docker**. This is important, otherwise you'ill need to go trough files and change path
3. In that folder run ``` docker-compose up -d```
   1. **ALLWAYS** Before you just run docker-compose up. Please check its content. Especially env variables, volumes, etc..
4. **OPTIONAL**: If you want to instal Backups do the same thing for backup/docker-compose.yml
5. **OPTIONAL**: If you want to instal Server monitoring do the same thing for monitor/docker-compose.yml
6. **OPTIONAL**: If you want to instal SQL Server 2022 do the same thing for sql/docker-compose.yml
7. That's it!

## Adding proxy for website
There are 2 ways to do it:

1) Short way
   ```
   docker run -e VIRTUAL_HOST=foo.bar.com,www.foo.bar.com LETSENCRYPT_HOST=foo.bar.com,www.foo.bar.com myweb-image
   ```
2) The **better way** (*docker-compose*)
   ```
   version: "3"
   services:
     myweb:
       container_name: myweb-container
       image: myweb-image
       ports: 
         - "8080:80"
       restart: unless-stopped
       environment:
         VIRTUAL_HOST: foo.bar.com,www.foo.bar.com
         LETSENCRYPT_HOST: foo.bar.com,www.foo.bar.com

   networks:
     default:
       external:
         name: nginx-proxy
   ```

## Duplicati Backups
- If you did instalation step 4) you have Duplicati installed. Check environment variables inside **backup/docker-compose.yml**
- Before you just run docker-compose up. Please check its content. Especially env variables, volumes, etc..
## Monitor
- If you did instalation step 5) you have Monitor installed. Check environment variables inside **monitor/docker-compose.yml** 
- Before you just run docker-compose up. Please check its content. Especially env variables, volumes, etc..
## SQL Server 2022
### Basic configuration
- If you did instalation step 6) you have DB already installed. If not then instal it. You can set backups after.
- Before you just run docker-compose up. Please check its content. Especially env variables, volumes, etc..
 ### DB backups
1. Copy content of **sqldb/service** to **/etc/systemd/system** 
    ```
    cp /docker/sqldb/service/sqldb-backup.service /etc/systemd/system
    cp /docker/sqldb/service/sqldb-backup.timer /etc/systemd/system
    ```
2. then write
    ```
    sudo systemctl enable sqldb-backup --now
    ```

### **Be aware while changing password for sa**
You can set your sa password easily, but once you've bild your image you have to remove SQL container with volumes. If you dont, than password don't change. Only after removing container completely it'll generate new shiny clean container. So only when you remove everything, only then you can set new password in docker-compose.yml:
```
docker rm sql_db -v
```


## Firewall (UFW)
- **Install.sh** does it that this is already enabled
  - **SSH** 
  - port **1433** for SQL remote connections
  - ports **80** and **443** for WWW 
- Basic commands
  - ```ufw app list ``` - list of rules prepared from 3rd apps which can be used right away
  - ```ufw status verbose``` - check currently set rules
  - ```ufw allow ssh``` - add rule for ssh
  - ```ufw delete allow ssh``` - remove rule for ssh
  - ```apt-get install gufw``` - graphical interface - not much use in terminal though :)

