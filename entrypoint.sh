#!/bin/sh

# Set domain and email variables
DOMAIN="alicam.org"
EMAIL="cameron.alford@gmail.com"

# Create or renew SSL certificates
certbot certonly --nginx \
  --non-interactive \
  --agree-tos \
  --email "$EMAIL" \
  --domain "$DOMAIN" \
  --domain "java.$DOMAIN" \
  --domain "bedrock.$DOMAIN"

# Link the generated certificates to the expected paths
ln -sf "/etc/letsencrypt/live/$DOMAIN/fullchain.pem" /etc/nginx/certs/alicam.org.crt
ln -sf "/etc/letsencrypt/live/$DOMAIN/privkey.pem" /etc/nginx/certs/alicam.org.key

# Start Nginx
nginx -g "daemon off;"
