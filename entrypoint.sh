#!/bin/sh

DOMAIN="alicam.org"
EMAIL="youremail@example.com"

# Create the directory for SSL certificates and webroot
mkdir -p /etc/nginx/certs /var/www/html

# Export the path to acme.sh
export PATH="$HOME/.acme.sh:$PATH"

# Obtain the SSL certificate
acme.sh --issue --webroot /var/www/html --domain "$DOMAIN" --email "$EMAIL" --reloadcmd "nginx -s reload" || true

# Create symbolic links for the SSL certificates
ln -sf "$HOME/.acme.sh/$DOMAIN/fullchain.cer" /etc/nginx/certs/alicam.org.crt
ln -sf "$HOME/.acme.sh/$DOMAIN/$DOMAIN.key" /etc/nginx/certs/alicam.org.key

# Start Nginx in the foreground
nginx -g "daemon off;"
