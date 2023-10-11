#!/bin/bash

# Set the project name using the PROJECT environment variable
PROJECT="$PROJECT_NAME"

# Define an associative array to map project names to SSH keys
declare -A SSH_KEYS

# Populate the SSH_KEYS array with project names and corresponding SSH key paths
SSH_KEYS["erp"]="/root/.ssh/id_rsa_erp"
SSH_KEYS["assetscore"]="/root/.ssh/id_rsa_assetscore"
SSH_KEYS["helper"]="/root/.ssh/id_rsa_helper"
SSH_KEYS["libs"]="/root/.ssh/id_rsa_libs"
SSH_KEYS["middleware"]="/root/.ssh/id_rsa_middleware"

# Check if the specified project exists in the SSH_KEYS array
if [ -n "${SSH_KEYS[$PROJECT]}" ]; then
    SSH_KEY="${SSH_KEYS[$PROJECT]}"
else
    echo "SSH key not found for project: $PROJECT"
    exit 1
fi

# Check if the SSH key file exists
if [ -f "$SSH_KEY" ]; then
    chmod 600 "$SSH_KEY"
    eval $(ssh-agent -s)
    ssh-add "$SSH_KEY"
    
    # Clone the project repository from GitHub
    echo "Cloning $PROJECT repository..."
    git clone "git@github.com:interactinteractive-php/php_$PROJECT.git" "/var/www/html/$PROJECT/"
    
    # Check if the clone was successful
    if [ $? -eq 0 ]; then
        echo "Cloning completed successfully."
    else
        echo "Cloning failed. Check the SSH key and repository availability."
    fi
    
    # Remove the SSH key after cloning
    rm "$SSH_KEY"
else
    echo "SSH key file not found: $SSH_KEY"
fi

# Start your application or desired services (e.g., PHP-FPM, Nginx)
# For example:
# /usr/sbin/php-fpm -F -R

# Keep the container running by blocking, or replace with your application's start command
# exec tail -f /dev/null
