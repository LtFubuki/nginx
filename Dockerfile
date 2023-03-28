FROM nginx:alpine

RUN apk update && \
    apk add --no-cache \
      bash \
      curl \
      openssl

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

COPY default.conf /etc/nginx/conf.d/default.conf

RUN curl https://get.acme.sh | sh

EXPOSE 80 443

ENTRYPOINT ["/entrypoint.sh"]
