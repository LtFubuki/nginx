#!/bin/sh

DOMAIN="alicam.org"
EMAIL="youremail@example.com"

# Create the directory for SSL certificates and webroot
mkdir -p /etc/nginx/certs /var/www/html

# Register the account
certbot register --non-interactive --agree-tos --email "$EMAIL" --server "https://acme-v02.api.letsencrypt.org/directory" || true

# Obtain the SSL certificate
certbot certonly --webroot --webroot-path /var/www/html --non-interactive --agree-tos --email "$EMAIL" -d "$DOMAIN" --server "https://acme-v02.api.letsencrypt.org/directory" || true

# Create symbolic links for the SSL certificates
ln -sf /etc/letsencrypt/live/"$DOMAIN"/fullchain.pem /etc/nginx/certs/alicam.org.crt
ln -sf /etc/letsencrypt/live/"$DOMAIN"/privkey.pem /etc/nginx/certs/alicam.org.key

# Start Nginx in the foreground
nginx -g "daemon off;"
