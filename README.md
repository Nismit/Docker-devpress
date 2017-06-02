# WordPress Development Environment for Docker
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

After install, you can access to http://localhost:8080 (http://localhost:8080)


## How to stop
On the terminal, press `Control` + `c`

Sometimes, terminal output `ERROR: Aborting.`
Execute `docker-compose stop`

```bash
$ docker-compose stop
```

Other, it suceeded to stop containers.

```bash
Gracefully stopping... (press Ctrl+C again to force)
Stopping devpress_server ... done
Stopping devpress_php ... done
Stopping devpress_mysql ... done
Stopping devpress_memcached ... done
```


## Example of installing Sage

An example, to install WP Starter theme Sage(https://github.com/roots/sage) ver 8.5.1

First, you should finish to install WordPress, follow the installation

```bash
$ docker exec -it devpress_php composer create-project roots/sage wp-content/themes/example 8.5.1
## Install npm packages
$ docker-compose run --rm node bash -c "cd wp-content/themes/example/ && npm install"
## Install bower components
$ docker-compose run --rm node bash -c "cd wp-content/themes/example/ && bower --allow-root install"
## Compile Gulp
$ docker-compose run --rm node bash -c "cd wp-content/themes/example/ && gulp"
## Watch Gulp
$ docker-compose run --rm node bash -c "cd wp-content/themes/example/ && gulp watch"
```


## Delete

Use `rm` or `prune` command. If you want to delete container(s) or image(s), follow the command below.




### Delete all containers which are not using or active

If you do not want to delete a container, you should use `docker container rm CONTAINER-NAME`

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
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS                        PORTS               NAMES
7151fa915423        rails_rails             "bundle exec rails..."   17 minutes ago      Exited (137) 17 minutes ago                       rails_rails_1
aa91f7b50937        postgres:9.6.2          "docker-entrypoint..."   17 minutes ago      Exited (137) 17 minutes ago                       rails_db_1
060bc6917c30        dockerdevpress_server   "nginx -g 'daemon ..."   33 minutes ago      Exited (0) 22 minutes ago                         devpress_server
a95afee425d1        dockerdevpress_php      "docker-php-entryp..."   33 minutes ago      Exited (0) 22 minutes ago                         devpress_php
$ docker container rm devpress_php
$ docker ps -a
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS                        PORTS               NAMES
7151fa915423        rails_rails             "bundle exec rails..."   17 minutes ago      Exited (137) 17 minutes ago                       rails_rails_1
aa91f7b50937        postgres:9.6.2          "docker-entrypoint..."   17 minutes ago      Exited (137) 17 minutes ago                       rails_db_1
060bc6917c30        dockerdevpress_server   "nginx -g 'daemon ..."   33 minutes ago      Exited (0) 22 minutes ago                         devpress_server
```



### Delete containters for devpress

```bash
$ docker ps -a
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS                        PORTS               NAMES
7151fa915423        rails_rails             "bundle exec rails..."   17 minutes ago      Exited (137) 17 minutes ago                       rails_rails_1
aa91f7b50937        postgres:9.6.2          "docker-entrypoint..."   17 minutes ago      Exited (137) 17 minutes ago                       rails_db_1
060bc6917c30        dockerdevpress_server   "nginx -g 'daemon ..."   33 minutes ago      Exited (0) 22 minutes ago                         devpress_server
a95afee425d1        dockerdevpress_php      "docker-php-entryp..."   33 minutes ago      Exited (0) 22 minutes ago                         devpress_php
b3fbc8fb271f        dockerdevpress_node     "npm start"              33 minutes ago      Exited (254) 33 minutes ago                       devpress_node
f77ce20f4232        mariadb                 "docker-entrypoint..."   33 minutes ago      Exited (0) 22 minutes ago                         devpress_mysql
$ docker rm $(docker ps -a --filter name=devpress -q)
060bc6917c30
a95afee425d1
b3fbc8fb271f
f77ce20f4232
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS                        PORTS               NAMES
7151fa915423        rails_rails         "bundle exec rails..."   18 minutes ago      Exited (137) 17 minutes ago                       rails_rails_1
aa91f7b50937        postgres:9.6.2      "docker-entrypoint..."   18 minutes ago      Exited (137) 17 minutes ago                       rails_db_1
```



### Delete images which are not using

```bash
$ docker image prune
```

