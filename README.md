# docker-wordpress
https://hub.docker.com/r/wishbone51/wordpress

This is is a simple image based on the official PHP version on Debian (with mysqli) and a copy of Wordpress in /var/www/html

## Example Docker run command:

```
docker run -d -p 80:80 --name my-wordpress -v wordpress_html:/var/www/html \
           -e MYSQL_DATABASE=dbname \
           -e MYSQL_USER=username \
           -e MYSQL_PASSWORD=password \
           -e MYSQL_HOST=hostname \
           wishbone51/wordpress:1.0
```

It's best to use a named volume instead of a host volume, since non-existant named volumes get pre-populated with container data, in this case, a copy of Wordpress. If you use a host volume, the default Wordpress files would be replaced with the contents of your volume.

The default Wordpress files don't have a wp-config.php file. If you don't pass the MySQL environment variables, when you load the page, Wordpress will walk you through the settings and create the config file for you. You can connect to an existing database or create a [MySQL/MariaDB container.](https://hub.docker.com/r/yobasystems/alpine-mariadb/)

If you take down the container, and re-create it, the volume will still exist, with all the database settings, so the environment variables aren't needed for subsequent runs. This container will never overwrite your config file.

## Example Docker Compose file

This project has everything you need for a ready-to-go Wordpress site:

docker-compose.yml

```
version: '3.8'
services:
  db:
    image: yobasystems/alpine-mariadb:10.4.15
    ports:
      - "3306/tcp"
    volumes:
      - db:/var/lib/mysql
    restart: always

    environment:
      MYSQL_ROOT_PASSWORD:
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD:

  wordpress:
    image: wishbone51/wordpress:1.0
    volumes:
      - html:/var/www/html
    ports:
      - 80:80/tcp
    restart: always

    environment:
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD:
      MYSQL_HOST: db

volumes:
  db:
  html:
```

Set your MYSQL_ROOT_PASSWORD and MYSQL_PASSWORD environment variables and run ```docker-compose up -d``` and you'll have a site ready to go on port 80.

To auto-generate these passwords, you can run the following Linux commands:

```
export MYSQL_ROOT_PASSWORD=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
export MYSQL_PASSWORD=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`
```

Note that the above step only needs to be done for the first build. These variables are completely ignored for subsequent containers generated, as long as your volume still exists.

This is a work in progress, and I'm very new at this. Any comments and suggestions are welcome. Feel free to fork or create a pull request on GitHub if you would like to add to this project!

-- Wishbone51
