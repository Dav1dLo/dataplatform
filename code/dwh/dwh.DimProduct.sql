-- Work Item: ad-hoc
-- Task: dwh.DimProduct
-- Spec: dwh.DimProduct
-- Version: 1
-- Generated: 2026-09-06T09:29:31.713252+00:00
-- Notes: Initial generation of dwh.DimProduct using SCD Type 1 upsert pattern.

CREATE SCHEMA IF NOT EXISTS "dwh";

CREATE TABLE IF NOT EXISTS "dwh"."DimProduct" (
    "ProductKey"    integer GENERATED ALWAYS AS IDENTITY,
    "ProductBK"     integer NOT NULL,
    "ProductSKU"    varchar(255),
    "ProductName"   varchar(1024),
    "ProductType"   varchar(50),
    "ProductBarcode" varchar(255),
    "IsActive"      boolean,
    "EffectiveDate" timestamptz NOT NULL,
    "ExpiryDate"    timestamptz,
    "IsCurrent"     boolean NOT NULL DEFAULT true,
    "CreatedDate"   timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT "PK_DimProduct" PRIMARY KEY ("ProductKey")
);

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimProduct_ProductBK" ON "dwh"."DimProduct" ("ProductBK");

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

INSERT INTO "dwh"."DimProduct" (
    "ProductKey", "ProductBK", "ProductSKU", "ProductName", "ProductType", "ProductBarcode", "IsActive", "EffectiveDate", "ExpiryDate", "IsCurrent", "CreatedDate"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1, -1, 'Unknown', 'Unknown', 'Unknown', 'Unknown', false, '1900-01-01 00:00:00+00', NULL, true, now()
)
ON CONFLICT ("ProductKey") DO NOTHING;

INSERT INTO "dwh"."DimProduct" (
    "ProductBK", "ProductSKU", "ProductName", "ProductType", "ProductBarcode", "IsActive", "EffectiveDate", "ExpiryDate", "IsCurrent", "CreatedDate"
)
SELECT
    s."id",
    COALESCE(s."default_code", t."default_code")::varchar(255),
    (t."name"->>'en_US')::varchar(1024),
    t."type"::varchar(50),
    s."barcode"::varchar(255),
    s."active"::boolean,
    now(),
    NULL,
    true,
    now()
FROM "staging"."odoo_product_product" AS s
JOIN "staging"."odoo_product_template" AS t ON s."product_tmpl_id" = t."id"
ON CONFLICT ("ProductBK") DO UPDATE
SET "ProductSKU" = EXCLUDED."ProductSKU",
    "ProductName" = EXCLUDED."ProductName",
    "ProductType" = EXCLUDED."ProductType",
    "ProductBarcode" = EXCLUDED."ProductBarcode",
    "IsActive" = EXCLUDED."IsActive";