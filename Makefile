.DEFAULT_GOAL := setup
include $(PWD)/.env

warden-up:
	@warden svc up
	@warden sign-certificate ${TRAEFIK_DOMAIN}
	@warden env up

composer-install:
	@warden env exec php-fpm composer install --no-dev

magento-install:
	@warden env exec php-fpm bin/magento setup:install --backend-frontname=backend \
     	--amqp-host=rabbitmq --amqp-port=5672 --amqp-user=guest --amqp-password=guest \
     	--db-host=db --db-name=magento --db-user=magento --db-password=magento \
     	--search-engine=opensearch --opensearch-host=opensearch \
     	--opensearch-port=9200 --opensearch-index-prefix=magento2 --opensearch-enable-auth=0 --opensearch-timeout=15 \
     	--http-cache-hosts=varnish:80 \
     	--session-save=redis --session-save-redis-host=redis --session-save-redis-port=6379 --session-save-redis-db=2   --session-save-redis-max-concurrency=20 \
     	--cache-backend=redis --cache-backend-redis-server=redis --cache-backend-redis-db=0 --cache-backend-redis-port=6379 \
     	--page-cache=redis --page-cache-redis-server=redis --page-cache-redis-db=1 --page-cache-redis-port=6379
	@warden env exec php-fpm bin/magento config:set --lock-env web/unsecure/base_url "https://${TRAEFIK_SUBDOMAIN}.${TRAEFIK_DOMAIN}/"
	@warden env exec php-fpm bin/magento config:set --lock-env web/secure/base_url "https://${TRAEFIK_SUBDOMAIN}.${TRAEFIK_DOMAIN}/"
	@warden env exec php-fpm bin/magento config:set --lock-env web/secure/offloader_header X-Forwarded-Proto
	@warden env exec php-fpm bin/magento config:set --lock-env web/secure/use_in_frontend 1
	@warden env exec php-fpm bin/magento config:set --lock-env web/secure/use_in_adminhtml 1
	@warden env exec php-fpm bin/magento config:set --lock-env web/seo/use_rewrites 1
	@warden env exec php-fpm bin/magento config:set --lock-env system/full_page_cache/caching_application 2
	@warden env exec php-fpm bin/magento config:set --lock-env system/full_page_cache/ttl 604800
	@warden env exec php-fpm bin/magento config:set --lock-env dev/static/sign 0
	@warden env exec php-fpm bin/magento cache:disable block_html
	@warden env exec php-fpm bin/magento cache:flush

production:
	@warden env exec php-fpm composer dump
	@warden env exec php-fpm bin/magento deploy:mode:set -s production
	@warden env exec php-fpm bin/magento setup:di:compile
	@warden env exec php-fpm bin/magento setup:static-content:deploy
	@warden env exec php-fpm composer dump -o --apcu
	@warden env restart varnish

development:
	@warden env exec php-fpm composer dump
	@rm -rf generated/*
	@warden env exec php-fpm bin/magento deploy:mode:set -s developer
	@warden env restart varnish

images:
	@mkdir -p pub/media/catalog/product/S/h
	@cp product-images/Sh*.png pub/media/catalog/product/S/h/

msi-stock:
	@warden db connect -e "insert into inventory_source_item (sku, source_code, quantity, status) select c.sku, 'eu', si.qty, 1 from cataloginventory_stock_item si inner join catalog_product_entity c on c.entity_id = si.product_id where type_id = 'simple' on duplicate key update quantity = VALUES(quantity), status = VALUES(status)"
	@warden db connect -e "insert into inventory_source_item (sku, source_code, quantity, status) select c.sku, 'us', si.qty, 1 from cataloginventory_stock_item si inner join catalog_product_entity c on c.entity_id = si.product_id where type_id = 'simple' on duplicate key update quantity = VALUES(quantity), status = VALUES(status)"

reindex:
	@warden env exec php-fpm bin/magento index:reindex inventory cataloginventory_stock catalog_category_product

small:
	@warden db import < db.small.sql
	@warden env exec php-fpm bin/magento setup:db-schema:upgrade
	@warden env exec php-fpm bin/magento app:config:import
	@warden env exec php-fpm bin/magento index:reset catalogsearch_fulltext
	@warden env exec php-fpm bin/magento index:reindex catalogsearch_fulltext

medium:
	@gunzip -c db.medium.sql.gz | warden db import
	@warden env exec php-fpm bin/magento setup:db-schema:upgrade
	@warden env exec php-fpm bin/magento app:config:import
	@warden env exec php-fpm bin/magento index:reset catalogsearch_fulltext
	@warden env exec php-fpm bin/magento index:reindex catalogsearch_fulltext

large:
	@gunzip -c db.large.sql.gz | warden db import
	@warden env exec php-fpm bin/magento setup:db-schema:upgrade
	@warden env exec php-fpm bin/magento app:config:import
	#@warden env exec php-fpm bin/magento index:reindex catalogsearch_fulltext

setup: warden-up composer-install magento-install development images small
