ARG NGINX_VERSION=1.16

FROM docker.io/wardenenv/nginx:${NGINX_VERSION}

COPY default.conf.template /etc/nginx/conf.d/default.conf.template
ENV NGINX_UPSTREAM_TIDEWAYS_HOST='php-tideways'
ENV NGINX_UPSTREAM_TIDEWAYS_PORT=9000

CMD envsubst '${NGINX_UPSTREAM_HOST} ${NGINX_UPSTREAM_PORT} \
              ${NGINX_UPSTREAM_BLACKFIRE_HOST} ${NGINX_UPSTREAM_BLACKFIRE_PORT} \
              ${NGINX_UPSTREAM_TIDEWAYS_HOST} ${NGINX_UPSTREAM_TIDEWAYS_PORT} \
              ${NGINX_UPSTREAM_DEBUG_HOST} ${NGINX_UPSTREAM_DEBUG_PORT} \
              ${NGINX_ROOT} ${NGINX_PUBLIC} ${NGINX_TEMPLATE} ${NGINX_APM}' \
        < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf \
    && envsubst '${XDEBUG_CONNECT_BACK_HOST}' \
        < /etc/nginx/fastcgi_params.template > /etc/nginx/fastcgi_params \
    && nginx -g "daemon off;"
