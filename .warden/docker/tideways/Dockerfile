FROM docker.io/wardenenv/php-fpm:8.1-magento2
LABEL authors="ivan@ecom.dev"
# IMPORTANT: Find current version at https://tideways.com/profiler/downloads
ENV TIDEWAYS_APIKEY=""
ENV TIDEWAYS_SERVICE=app
ENV TIDEWAYS_SAMPLERATE=25
ENV TIDEWAYS_CONNECTION=tcp://tideways-daemon:9135

USER root

COPY tideways.repo /etc/yum.repos.d/tideways.repo

RUN rpm --import https://packages.tideways.com/key.gpg &&  \
    yum makecache --disablerepo=* --enablerepo=tideways && \
    yum install tideways-php --nogpgcheck -y

COPY tideways.ini /etc/php.d/99-custom-tideways.ini

USER www-data
