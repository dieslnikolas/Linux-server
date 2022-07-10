# Linux Server - Instalation server with docker

Basic configuration of linux server

- Nginx Proxy
- Let's Encrypt
- Backup with notification (both files and db dumps)
- SQL Server 2022

## Instalation
1. Run install.sh which does:
   1. Basic server confguration
   2. ufw - Uncomplicated FireWall
   3. Install docker
   4. Creates docker network called nginx-proxy
2. Copy docker-compose.yml to some folder on the host 
3. In that folder run ``` docker-compose up -d```
4. That's it 

## Adding proxy
There are 2 ways to do it:

1) Short way
   ```
   docker run -e VIRTUAL_HOST=foo.bar.com,www.foo.bar.com LETSENCRYPT_HOST=foo.bar.com,www.foo.bar.com some_image_wordpressmaybe
   ```
2) The better way
    ```
    version: "3"
    services:
      some_web:
        container_name: wordpress_2
        image: some_image_wordpressmaybe
        expose:
          - 8080:80
        restart: unless-stopped
        environment:
        VIRTUAL_HOST: foo.bar.com,www.foo.bar.com 
        LETSENCRYPT_HOST: foo.bar.com,www.foo.bar.com 
    
    networks:
    default:
        external:
        name: nginx-proxy
    ```

## Backups
TODO

## How to connect to DB
TODO

## Firewall (UFW)
TODO