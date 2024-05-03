SET FOREIGN_KEY_CHECKS = 0;
INSERT INTO `store_website`
VALUES (1, 'en', 'US Website', 0, 1, 1),
       (2, 'fr', 'FR Website', 10, 2, 0),
       (3, 'nl', 'NL Website', 30, 3, 0)
ON DUPLICATE KEY UPDATE code             = VALUES(code),
                        default_group_id = VALUES(default_group_id),
                        name             = VALUES(name)
;

INSERT INTO `store`
VALUES (1, 'en', 1, 1, 'US Store View', 0, 1),
       (2, 'fr', 2, 2, 'FR Store View', 20, 1),
       (3, 'nl', 3, 3, 'NL Store View', 30, 1)
ON DUPLICATE KEY UPDATE code      = VALUES(code),
                        is_active = VALUES(is_active),
                        name      = VALUES(name)
;

INSERT INTO `store_group`
VALUES (1, 1, 'US Website Store', 2, 1, 'en'),
       (2, 2, 'FR Website Store', 2, 2, 'fr'),
       (3, 3, 'NL Website Store', 2, 3, 'nl')
ON DUPLICATE KEY UPDATE code             = VALUES(code),
                        default_store_id = VALUES(default_store_id),
                        name             = VALUES(name)
;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO `inventory_source`
VALUES ('eu', 'EU', 1, NULL, NULL, NULL, 'NL', NULL, NULL, NULL, NULL, '1100 AA', NULL, NULL, NULL, NULL, 1, 0, 'EU',
        NULL),
       ('us', 'US', 1, NULL, NULL, NULL, 'US', 12, 'California', NULL, NULL, '90210', NULL, NULL, NULL, NULL, 1, 0,
        'US', NULL)

ON DUPLICATE key update enabled = VALUES(enabled);

INSERT INTO `inventory_stock`
VALUES (2, 'US'),
       (3, 'EU')

ON DUPLICATE key update name = VALUES(name);;

INSERT INTO `inventory_stock_sales_channel`
VALUES ('website', 'en', 2),
       ('website', 'fr', 3),
       ('website', 'nl', 3)

ON DUPLICATE key update stock_id = VALUES(stock_id);

INSERT INTO `inventory_source_stock_link`
VALUES (2, 2, 'us', 2),
       (3, 3, 'eu', 2)
ON DUPLICATE key update stock_id = VALUES(stock_id);;

INSERT INTO sales_sequence_meta (meta_id, entity_type, store_id, sequence_table)
VALUES (1, 'order', 0, 'sequence_order_0'),
       (2, 'invoice', 0, 'sequence_invoice_0'),
       (3, 'creditmemo', 0, 'sequence_creditmemo_0'),
       (4, 'shipment', 0, 'sequence_shipment_0'),
       (5, 'order', 1, 'sequence_order_1'),
       (6, 'invoice', 1, 'sequence_invoice_1'),
       (7, 'creditmemo', 1, 'sequence_creditmemo_1'),
       (8, 'shipment', 1, 'sequence_shipment_1'),
       (9, 'order', 2, 'sequence_order_2'),
       (10, 'invoice', 2, 'sequence_invoice_2'),
       (11, 'creditmemo', 2, 'sequence_creditmemo_2'),
       (12, 'shipment', 2, 'sequence_shipment_2'),
       (13, 'order', 3, 'sequence_order_3'),
       (14, 'invoice', 3, 'sequence_invoice_3'),
       (15, 'creditmemo', 3, 'sequence_creditmemo_3'),
       (16, 'shipment', 3, 'sequence_shipment_3')
ON DUPLICATE key update sequence_table = VALUES(sequence_table);

INSERT INTO sales_sequence_profile (profile_id, meta_id, prefix, suffix, start_value, step, max_value,
                                    warning_value, is_active)
VALUES (1, 1, null, null, 1, 1, 4294967295, 4294966295, 1),
       (2, 2, null, null, 1, 1, 4294967295, 4294966295, 1),
       (3, 3, null, null, 1, 1, 4294967295, 4294966295, 1),
       (4, 4, null, null, 1, 1, 4294967295, 4294966295, 1),
       (5, 5, '1', null, 1, 1, 4294967295, 4294966295, 1),
       (6, 6, '1', null, 1, 1, 4294967295, 4294966295, 1),
       (7, 7, '1', null, 1, 1, 4294967295, 4294966295, 1),
       (8, 8, '1', null, 1, 1, 4294967295, 4294966295, 1),
       (9, 9, '2', null, 1, 1, 4294967295, 4294966295, 1),
       (10, 10, '2', null, 1, 1, 4294967295, 4294966295, 1),
       (11, 11, '2', null, 1, 1, 4294967295, 4294966295, 1),
       (12, 12, '2', null, 1, 1, 4294967295, 4294966295, 1),
       (13, 13, '3', null, 1, 1, 4294967295, 4294966295, 1),
       (14, 14, '3', null, 1, 1, 4294967295, 4294966295, 1),
       (15, 15, '3', null, 1, 1, 4294967295, 4294966295, 1),
       (16, 16, '3', null, 1, 1, 4294967295, 4294966295, 1)
ON DUPLICATE key update start_value = VALUES(start_value);

create table if not exists sequence_creditmemo_0
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_creditmemo_1
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_creditmemo_2
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_creditmemo_3
(
    sequence_value int unsigned auto_increment primary key
);

create table if not exists sequence_invoice_0
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_invoice_1
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_invoice_2
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_invoice_3
(
    sequence_value int unsigned auto_increment primary key
);

create table if not exists sequence_order_0
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_order_1
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_order_2
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_order_3
(
    sequence_value int unsigned auto_increment primary key
);

create table if not exists sequence_shipment_0
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_shipment_1
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_shipment_2
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists sequence_shipment_3
(
    sequence_value int unsigned auto_increment primary key
);
create table if not exists inventory_stock_2
(
    `sku`        varchar(64)    NOT NULL COMMENT 'Sku',
    `quantity`   decimal(10, 4) NOT NULL DEFAULT 0.0000 COMMENT 'Quantity',
    `is_salable` tinyint(1)     NOT NULL COMMENT 'Is Salable',
    PRIMARY KEY (`sku`),
    KEY `index_sku_qty` (`sku`, `quantity`)
) COMMENT ='Inventory Stock item Table';


create table if not exists inventory_stock_3
(
    `sku`        varchar(64)    NOT NULL COMMENT 'Sku',
    `quantity`   decimal(10, 4) NOT NULL DEFAULT 0.0000 COMMENT 'Quantity',
    `is_salable` tinyint(1)     NOT NULL COMMENT 'Is Salable',
    PRIMARY KEY (`sku`),
    KEY `index_sku_qty` (`sku`, `quantity`)
) COMMENT ='Inventory Stock item Table';
