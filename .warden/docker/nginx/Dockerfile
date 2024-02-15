FROM docker.io/wardenenv/nginx:1.16

COPY default.conf.template /etc/nginx/conf.d/default.conf.template

CMD envsubst '${NGINX_UPSTREAM_HOST} ${NGINX_UPSTREAM_PORT} \
              ${NGINX_UPSTREAM_BLACKFIRE_HOST} ${NGINX_UPSTREAM_BLACKFIRE_PORT} \
              ${NGINX_UPSTREAM_DEBUG_HOST} ${NGINX_UPSTREAM_DEBUG_PORT} \
              ${NGINX_ROOT} ${NGINX_PUBLIC} ${NGINX_TEMPLATE} ${TIDEWAYS_APIKEY}' \
        < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf \
    && envsubst '${XDEBUG_CONNECT_BACK_HOST}' \
        < /etc/nginx/fastcgi_params.template > /etc/nginx/fastcgi_params \
    && nginx -g "daemon off;"
