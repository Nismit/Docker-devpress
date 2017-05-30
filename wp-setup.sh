#!/bin/bash

# Setting for database
DBNAME="mysql_database"
DBUSER="mysql_user"
DBPASSWORD="mysql_password"
DBHOST="mysql"
DBPREFIX=""

# Setting for wordpress
SITE_URL="localhost:8080"
SITE_TITLE="Docker-WordPress"
ADMIN_USER="admin"
ADMIN_PASSWORD="password"
ADMIN_EMAIL="local@admin.com"

# Pre install plugin list
PLUGINS=("wp-multibyte-patch","duplicate-post")

# Download Wordpress
docker exec -it devpress_php wp --allow-root core download --locale=ja

# SetUp wp-config
docker exec -it devpress_php wp --allow-root core config --dbname=${DBNAME} --dbuser=${DBUSER} --dbpass=${DBPASSWORD} --dbhost=${DBHOST} --dbprefix=${DBPREFIX}

# Wordpress Install
docker exec -it devpress_php wp --allow-root core install --url=${SITE_URL} --title=${SITE_TITLE} --admin_user=${ADMIN_USER} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL}

# Plugins Download & Install
for plugin in ${PLUGINS[@]}
do
  docker exec -it devpress_php wp --allow-root plugin install $plugin --activate
done