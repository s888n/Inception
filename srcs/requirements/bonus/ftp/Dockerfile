
FROM alpine:3.17

RUN	apk update && apk upgrade && apk add --no-cache \
        vsftpd

COPY ./vsftpd.conf /tmp/vsftpd.conf

COPY ./config.sh /tmp/config.sh

ENTRYPOINT ["sh", "/tmp/config.sh"]