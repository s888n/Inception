FROM alpine:3.17

RUN  apk update && apk upgrade && apk add nginx openssl --no-cache

COPY ./conf/default.conf /etc/nginx/http.d/default.conf
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/ss.key \
	-out /etc/ssl/certs/ss.crt \
	-subj "/C=/ST=/L=/O=1337/OU=/CN=srachdi"

RUN chmod -R 777 /etc/ssl/private/ss.key /etc/ssl/certs/ss.crt

RUN mkdir -p /run/nginx /var/www/html


EXPOSE 443

ENTRYPOINT ["nginx","-g","daemon off;"]
