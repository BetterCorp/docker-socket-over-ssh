#!/bin/sh
set -e

# Check if required environment variables are set
if [ -z "$SSH_USERNAME" ] || [ -z "$SSH_HOST" ]; then
    echo "Error: SSH_USERNAME and SSH_HOST must be set"
    exit 1
fi

# Set up SSH directory
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Set correct permissions for SSH key if it exists
if [ -f ~/.ssh/id_rsa ]; then
    chmod 600 ~/.ssh/id_rsa
fi

# Add host key to known hosts
ssh-keyscan -H "$SSH_HOST" >> ~/.ssh/known_hosts 2>/dev/null

# Set Docker host
export DOCKER_HOST="ssh://${SSH_USERNAME}@${SSH_HOST}"

# Execute Docker command
exec docker "$@"
