FROM debian:stable-slim

ARG TIDEWAYS_ENVIRONMENT_DEFAULT=production
ARG DEBIAN_FRONTEND=noninteractive

ENV TIDEWAYS_ENVIRONMENT=$TIDEWAYS_ENVIRONMENT_DEFAULT

RUN useradd --system tideways && \
    apt-get update -yq && \
    apt-get install -yq --no-install-recommends gpg wget ca-certificates && \
    echo 'deb [signed-by=/usr/share/keyrings/tideways.gpg] https://packages.tideways.com/apt-packages-main any-version main' | tee /etc/apt/sources.list.d/tideways.list && \
    wget -qO - 'https://packages.tideways.com/key.gpg' | gpg --dearmor > /usr/share/keyrings/tideways.gpg && \
    apt-get update -yq && \
    apt-get install -yq tideways-daemon && \
    apt-get clean -yq

EXPOSE 9135

USER tideways

ENTRYPOINT ["tideways-daemon","--hostname=tideways-daemon","--address=0.0.0.0:9135"]
