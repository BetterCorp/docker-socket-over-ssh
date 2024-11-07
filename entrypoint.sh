#!/bin/sh
set -e

cleanup() {
    # Remove the SSH key
    rm -f ~/.ssh/id_rsa
    # Clear known_hosts file
    > ~/.ssh/known_hosts
    # Cleanup docker token
    rm -rfv ~/.docker
}

# Set up cleanup to run on script exit
trap cleanup EXIT

# Check if required environment variables are set
if [ -z "$SSH_USERNAME" ] || [ -z "$SSH_HOST" ]; then
    echo "Error: SSH_USERNAME and SSH_HOST must be set"
    exit 1
fi

# Setup the docker
mkdir -p ~/.docker
chmod 700 ~/.docker

if [ -n "$DOCKER_CONFIG" ]; then
    echo "$DOCKER_CONFIG" > ~/.docker/config.json
    chmod 600 ~/.docker/config.json
fi

# Set up SSH
mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ -n "$SSH_PRIVATE_KEY" ]; then
    echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
elif [ -f /run/secrets/ssh_private_key ]; then
    cp /run/secrets/ssh_private_key ~/.ssh/id_rsa
    chmod 600 ~/.ssh/id_rsa
elif [ ! -f ~/.ssh/id_rsa ]; then
    echo "Error: No SSH key provided. Please set SSH_PRIVATE_KEY or mount a key to /run/secrets/ssh_private_key"
    exit 1
fi

# Add host key to known hosts
ssh-keyscan -H "$SSH_HOST" >> ~/.ssh/known_hosts 2>/dev/null

# Set Docker host
export DOCKER_HOST="ssh://${SSH_USERNAME}@${SSH_HOST}"

# Execute Docker command
exec docker $@
