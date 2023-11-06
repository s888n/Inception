FROM alpine:3.17

RUN mkdir -p /var/www/html/adminer

RUN apk update && apk upgrade && apk add --no-cache wget php php-fpm php-mysqli php-json php-session 

RUN	sed -i 's/listen = 127.0.0.1:9000/listen = 5000/g' /etc/php81/php-fpm.d/www.conf \
    && wget https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php -O /var/www/html/adminer/adminer.php

EXPOSE 5000

ENTRYPOINT ["php-fpm81", "-F"]

