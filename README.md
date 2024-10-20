# Docker Socket Over SSH

[![Docker Pulls](https://img.shields.io/docker/pulls/betterweb/docker-socket-over-ssh.svg)](https://hub.docker.com/r/betterweb/docker-socket-over-ssh)
[![GitHub license](https://img.shields.io/github/license/BetterCorp/docker-socket-over-ssh.svg)](https://github.com/BetterCorp/docker-socket-over-ssh/blob/main/LICENSE)

Execute Docker commands on remote hosts via SSH, ideal for Docker Swarm deployments.

## Usage

To use this image, you need to provide your SSH credentials and the Docker command you want to execute.

```bash
docker run -e SSH_USERNAME=user -e SSH_HOST=example.com betterweb/docker-socket-over-ssh <docker command>
```

Replace `<docker command>` with the Docker command you want to execute on the remote host.

### Environment Variables

- `SSH_USERNAME`: The username for SSH authentication
- `SSH_HOST`: The hostname or IP address of the remote Docker host
- `SSH_PRIVATE_KEY`: The SSH private key as a string (optional)

### SSH Key

You have three options to provide the SSH key:

1. As an environment variable:
   ```bash
   docker run -e SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)" -e SSH_USERNAME=user -e SSH_HOST=example.com betterweb/docker-socket-over-ssh <command>
   ```

2. As a Docker secret (in Swarm mode):
   ```bash
   echo "$(cat ~/.ssh/id_rsa)" | docker secret create ssh_private_key -
   docker service create --secret ssh_private_key -e SSH_USERNAME=user -e SSH_HOST=example.com betterweb/docker-socket-over-ssh <command>
   ```

3. By mounting the key file:
   ```bash
   docker run -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro -e SSH_USERNAME=user -e SSH_HOST=example.com betterweb/docker-socket-over-ssh <command>
   ```

## Example: Deploying to Docker Swarm

To deploy a service to a Docker Swarm, you might use a command like this:

```bash
docker run -e SSH_PRIVATE_KEY="$(cat ~/.ssh/id_rsa)" \
           -e SSH_USERNAME=swarm-manager \
           -e SSH_HOST=swarm.example.com \
           betterweb/docker-socket-over-ssh \
           stack deploy -c docker-compose.yml my-stack
```

This command deploys a stack defined in `docker-compose.yml` to the Swarm cluster.

## Security Considerations

- Always use secure methods to pass your SSH key
- Ensure your SSH keys have appropriate permissions (600 for private keys)
- Use strong, unique passwords for SSH accounts
- Consider using SSH key authentication instead of password authentication

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the AGPL-3.0 License - see the [LICENSE](LICENSE) file for details.

## Links

- [GitHub Repository](https://github.com/BetterCorp/docker-socket-over-ssh)
- [Docker Hub](https://hub.docker.com/r/betterweb/docker-socket-over-ssh)
