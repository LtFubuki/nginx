# Use the official Nginx image as the base image
FROM nginx:stable

# Install necessary packages for certbot
RUN apt-get update && \
    apt-get install -y certbot python3-certbot-nginx

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Add the http and events blocks to the main Nginx configuration file
RUN sed -i 's#\(http {.*\)#\1\n    include /etc/nginx/conf.d/*.conf;#' /etc/nginx/nginx.conf
RUN sed -i '/http {/i events {\n    worker_connections 1024;\n}\n' /etc/nginx/nginx.conf

# Copy the custom Nginx configuration file into the container
COPY nginx.conf /etc/nginx/conf.d/

# Copy the entrypoint script
COPY entrypoint.sh /entrypoint.sh

# Set the correct permissions for the entrypoint script
RUN chmod +x /entrypoint.sh

# Set the entrypoint script as the executable
ENTRYPOINT ["/entrypoint.sh"]
