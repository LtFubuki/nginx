#!/bin/sh

DOMAIN="alicam.org"
EMAIL="youremail@example.com"

# Create the directory for SSL certificates
mkdir -p /etc/nginx/certs

# Obtain the SSL certificate
certbot certonly --standalone --non-interactive --agree-tos --email "$EMAIL" -d "$DOMAIN" || true

# Create symbolic links for the SSL certificates
ln -sf /etc/letsencrypt/live/"$DOMAIN"/fullchain.pem /etc/nginx/certs/alicam.org.crt
ln -sf /etc/letsencrypt/live/"$DOMAIN"/privkey.pem /etc/nginx/certs/alicam.org.key

# Start Nginx in the foreground
nginx -g "daemon off;"
