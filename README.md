# Docker Socket Over SSH

[![Docker Pulls](https://img.shields.io/docker/pulls/betterweb/docker-socket-over-ssh.svg)](https://hub.docker.com/r/betterweb/docker-socket-over-ssh)
[![GitHub license](https://img.shields.io/github/license/BetterCorp/docker-socket-over-ssh.svg)](https://github.com/BetterCorp/docker-socket-over-ssh/blob/main/LICENSE)

This Docker image allows you to execute Docker commands on a remote host via SSH. It's particularly useful for deploying containers to a Docker Swarm setup without exposing the Docker socket directly.

## Usage

To use this image, you need to provide your SSH credentials and the Docker command you want to execute.

```bash
docker run -v /path/to/your/id_rsa:/root/.ssh/id_rsa:ro \
           -e SSH_USERNAME=user \
           -e SSH_HOST=example.com \
           betterweb/docker-socket-over-ssh <docker command>
```

Replace `<docker command>` with the Docker command you want to execute on the remote host.

### Environment Variables

- `SSH_USERNAME`: The username for SSH authentication
- `SSH_HOST`: The hostname or IP address of the remote Docker host

### Volumes

- `/root/.ssh/id_rsa`: Mount your SSH private key here (read-only)

## Example: Deploying to Docker Swarm

To deploy a service to a Docker Swarm, you might use a command like this:

```bash
docker run -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
           -e SSH_USERNAME=swarm-manager \
           -e SSH_HOST=swarm.example.com \
           betterweb/docker-socket-over-ssh \
           stack deploy -c docker-compose.yml my-stack
```

This command deploys a stack defined in `docker-compose.yml` to the Swarm cluster.

## Security Considerations

- Always use read-only volume mounts for SSH keys
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
