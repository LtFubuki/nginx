#!/bin/sh

# Set your GitHub repository URL
REPO_URL="https://github.com/LtFubuki/nginx.git"
CLONE_DIR="nginx_clone"

# Set the Docker image and container names
IMAGE_NAME="alicam-nginx-proxy"
CONTAINER_NAME="alicam-nginx-proxy"

# Clone the repository
if [ -d "$CLONE_DIR" ]; then
  echo "Updating repository..."
  cd "$CLONE_DIR" && git pull
else
  echo "Cloning repository..."
  git clone "$REPO_URL" "$CLONE_DIR"
  cd "$CLONE_DIR"
fi

# Build the Docker image
echo "Building Docker image..."
docker build -t "$IMAGE_NAME" .

# Stop and remove the existing container, if it exists
if [ "$(docker ps -aq --filter name="$CONTAINER_NAME")" ]; then
  echo "Removing existing container..."
  docker rm -f "$CONTAINER_NAME"
fi

# Run the Docker container
echo "Starting Docker container..."
docker run -d -p 80:80 -p 443:443 --name "$CONTAINER_NAME" "$IMAGE_NAME"

echo "Deployment completed successfully!"
