FROM alpine:3.17

RUN apk update && apk upgrade && apk add mariadb mariadb-client --no-cache

COPY ./tools/config.sh /tmp/config.sh

RUN	chmod +x /tmp/config.sh

EXPOSE 3306

ENTRYPOINT ["sh", "/tmp/config.sh"]
