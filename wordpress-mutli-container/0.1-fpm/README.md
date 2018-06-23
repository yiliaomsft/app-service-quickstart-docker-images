# Wordpress Docker Image for Multi-container using Docker Compose in Azure Web App for Containers

* ready-for-deploy.yml ( for web app for mutli containers of Azure )
* ready-for-docker-compose.yml ( for cmd ```docker-compse -f ready-for-docker-compose.yml up``` )

## Components
This docker image currently contains the following components:

1. WordPress (4.9.6) + Redis Object Cache (1.3.8)
2. Php-fpm (7.2.6)

## How to configure to use Azure Database for MySQL with web app 
1. Create a Web App for Mutli Containers
2. App Setting:
    * WORDPRESS_DB_HOST
    * WORDPRESS_DB_USER
    * WORDPRESS_DB_PASSWORD
    * WORDPRESS_DB_NAME
3. Browse your site
4. Complete WordPress installation  

## Connect WordPress to Redis
1. Log-in to WordPress admin. In the left navigation, select **Plugins**, and then select **Installed Plugins**.
2. In the plugins page, find **Redis Object Cache** and click **Settings**.
3. Click the **Enable Object Cache** button.
4. WordPress connects to the Redis server. The connection status appears on the same page.
5. [More infomation about **Redis Object Cache**](https://wordpress.org/plugins/redis-cache)

## Limitations
- Some unexpected issues may happen after you scale out your site to multiple instances, if you deploy a WordPress site on Azure with this docker image and use the MariaDB built in this docker image as the database.
- The phpMyAdmin built in this docker image is available only when you use the MariaDB built in this docker image as the database.
- Please Include  App Setting ```WEBSITES_ENABLE_APP_SERVICE_STORAGE``` = true  when use built in MariaDB since we need files to be persisted.

## Change Log

# How to Contribute
If you have feedback please create an issue but **do not send Pull requests** to these images since any changes to the images needs to tested before it is pushed to production. 
