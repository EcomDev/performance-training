ARG PHP_VERSION

FROM docker.io/wardenenv/php-fpm:${PHP_VERSION}-magento2
LABEL authors="ivan@ecom.dev"
# IMPORTANT: Find current version at https://tideways.com/profiler/downloads
ARG TIDEWAYS_VERSION=5.14.0
ARG TIDEWAYS_CLI_VERSION=1.0.10

ENV TIDEWAYS_APIKEY=""
ENV TIDEWAYS_SERVICE=app
ENV TIDEWAYS_SAMPLERATE=25
ENV TIDEWAYS_CONNECTION=tcp://tideways-daemon:9135

USER root

COPY tideways.repo /etc/yum.repos.d/tideways.repo

RUN export ARCH=$([[ "$(uname -m)" == "aarch64" ]] && echo "arm64" || echo "x86_64") \
    && wget -Otideways-php.tar.gz "https://tideways.s3.amazonaws.com/extension/$TIDEWAYS_VERSION/tideways-php-$TIDEWAYS_VERSION-$ARCH.tar.gz" \
    && tar xzvf tideways-php.tar.gz \
    && cd tideways-php-$TIDEWAYS_VERSION \
    && bash install.sh \
    && cd .. && rm -r tideways-php*

RUN export ARCH=$([[ "$(uname -m)" == "aarch64" ]] && echo "arm64" || echo "amd64") \
    && wget -Otideways-cli.tar.gz "https://tideways.s3.amazonaws.com/cli/$TIDEWAYS_CLI_VERSION/tideways-cli_linux_$ARCH-$TIDEWAYS_CLI_VERSION.tar.gz" \
    && tar xzvf tideways-cli.tar.gz \
    && chmod +x tideways-cli_$TIDEWAYS_CLI_VERSION/tideways \
    && mv tideways-cli_$TIDEWAYS_CLI_VERSION/tideways /usr/local/bin/ \
    && rm -rf tideways-cli*

COPY tideways.ini /etc/php.d/99-custom-tideways.ini

USER www-data
