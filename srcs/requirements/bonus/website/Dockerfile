FROM alpine:3.17

RUN apk update && apk upgrade && apk add wget nginx

RUN  mkdir -p /var/www/html/website

COPY ./index.html /var/www/html/website/index.html

COPY ./default.conf /etc/nginx/http.d/default.conf

EXPOSE 80

ENTRYPOINT ["nginx", "-g", "daemon off;"]
