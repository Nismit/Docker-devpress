# Docker for WordPress Development
You can set up for development of WordPress environment on Docker.

## Software Included


1. memcached (https://hub.docker.com/_/memcached/)
1. nginx (https://hub.docker.com/_/nginx/)
1. php (https://hub.docker.com/_/php/)
1. MariaDB (https://hub.docker.com/_/mariadb/)
1. Node (https://hub.docker.com/_/node/)
1. Composer
1. WP-CLI


## Installation

```bash
$ cd Docker-devpress
$ docker-compose up --build
```

## Install WordPress

```bash
$ chmod u+x wp-setup.sh
$ ./wp-setup.sh
```

After install, you can access to http://localhost:80 (http://localhost:80)

## How to stop
On the terminal, press `Control` + `c`

```bash
Gracefully stopping... (press Ctrl+C again to force)
Stopping nginx_server ... done
Stopping php-fpm ... done
Stopping mysql ... done
Stopping docker_memcached_1 ... done
```

Sometimes, terminal output `Aborting.`

```bash
$ docker-compose stop
```



## Delete

Use `rm` or `prune` command. If you want to delete container(s) or image(s), follow the command below.

### Delete all containers which are not using or active

```bash
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                        PORTS               NAMES
90b08538c099        docker_server       "nginx -g 'daemon ..."   18 minutes ago      Exited (137) 11 minutes ago                       nginx_server
c6458f538151        docker_php          "docker-php-entryp..."   18 minutes ago      Exited (137) 11 minutes ago                       php-fpm
$ docker container prune
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                        PORTS               NAMES
```

### Delete particular container

```bash
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                        PORTS               NAMES
90b08538c099        docker_server       "nginx -g 'daemon ..."   18 minutes ago      Exited (137) 11 minutes ago                       nginx_server
c6458f538151        docker_php          "docker-php-entryp..."   18 minutes ago      Exited (137) 11 minutes ago                       php-fpm
$ docker container rm php-fpm
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                        PORTS               NAMES
90b08538c099        docker_server       "nginx -g 'daemon ..."   18 minutes ago      Exited (137) 11 minutes ago                       nginx_server
```

```bash
$ docker image prune
```

```bash
$ docker system prune
$ docker system prune -a
```
