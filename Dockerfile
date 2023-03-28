FROM nginx:alpine

RUN apk update && \
    apk add --no-cache \
      bash \
      curl \
      openssl

COPY entrypoint.sh /entrypoint.sh
COPY default.conf /etc/nginx/conf.d/default.conf

RUN curl https://get.acme.sh | sh

EXPOSE 80 443

RUN chmod +x /entrypoint.shs

ENTRYPOINT ["/entrypoint.sh"]
