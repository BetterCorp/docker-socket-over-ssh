FROM alpine:latest

RUN apk add --no-cache docker-cli openssh-client curl jq envsubst

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
