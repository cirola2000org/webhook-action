FROM ubuntu:bionic

LABEL "name"="webhook-action"
LABEL "repository"="https://github.com/cirola2000org/webhook-ation"
LABEL "version"="v0.0.3"
LABEL com.github.actions.name="Actions Webhook"
LABEL com.github.actions.description="Call github webhook"
LABEL com.github.actions.icon="link"
LABEL com.github.actions.color="blue"

RUN apt-get update && apt-get install -y curl openssl xxd jq

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
