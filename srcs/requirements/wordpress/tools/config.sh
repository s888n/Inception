#!/bin/sh

while ! mariadb -h${DB_HOST} -u${WP_DB_USER} -p${WP_DB_PASS} ${WP_DB_NAME} &>/dev/null; 
do
	sleep 3
done

if [ ! -f "/var/www/html/wordpress/wp-config.php" ]; then
    wp core download --path=/var/www/html/wordpress --allow-root
    wp config create --dbname=$WP_DB_NAME --dbuser=$WP_DB_USER --dbpass=$WP_DB_PASS --dbhost=$DB_HOST --allow-root --path=/var/www/html/wordpress
    wp core install --url=$URL --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --path=/var/www/html/wordpress  --allow-root
    wp user create $WP_DB_USER $WP_EMAIL --role=author --user_pass=$WP_DB_PASS --allow-root --path=/var/www/html/wordpress
    wp theme install shining-blog --path=/var/www/html/wordpress --activate --allow-root
    wp theme status shining-blog --allow-root --path=/var/www/html/wordpress
    wp config set FS_METHOD direct --allow-root --path=/var/www/html/wordpress
    wp config set WP_REDIS_HOST $WP_REDIS_HOST --add --allow-root --path=/var/www/html/wordpress
    wp config set WP_REDIS_PORT $WP_REDIS_PORT  --add --allow-root --path=/var/www/html/wordpress
    wp config set WP_REDIS_DATABASE $WP_REDIS_DATABASE --add --allow-root --path=/var/www/html/wordpress
    wp plugin install redis-cache --path=/var/www/html/wordpress --activate --allow-root
    wp plugin install multiple-domain --activate --allow-root --path=/var/www/html/wordpress
    wp redis enable --path=/var/www/html/wordpress --allow-root 
    chmod -R 777 /var/www/html/
    wp post delete $(wp post list --format=ids --allow-root) --allow-root
fi

php-fpm81 -F
