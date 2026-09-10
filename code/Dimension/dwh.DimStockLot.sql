-- Work Item: ad-hoc
-- Task: dwh.DimStockLot
-- Spec: Specification/Dimension/dwh.DimStockLot.md
-- Version: 1
-- Generated: 2026-09-10T14:57:46.410730+00:00
-- Notes: Initial generation of dwh.DimStockLot table and Type 1 dimension pipeline.

CREATE SCHEMA IF NOT EXISTS "dwh";

CREATE TABLE IF NOT EXISTS "dwh"."DimStockLot" (
    "StockLotKey"         integer GENERATED ALWAYS AS IDENTITY,
    "StockLotId"          integer NOT NULL,
    "LotNumber"           varchar(255),
    "InternalReference"   varchar(255),
    "SourceProductId"     integer,
    "SourceProductUomId"  integer,
    "SourceCompanyId"     integer,
    "SourceLocationId"    integer,
    "LotNotes"            varchar(2000),
    "SourceCreatedAt"     timestamp,
    "SourceUpdatedAt"     timestamp,
    CONSTRAINT "PK_DimStockLot" PRIMARY KEY ("StockLotKey")
);

-- Ensure all specified columns exist on previously created tables
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "StockLotId" integer;
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "LotNumber" varchar(255);
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "InternalReference" varchar(255);
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "SourceProductId" integer;
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "SourceProductUomId" integer;
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "SourceCompanyId" integer;
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "SourceLocationId" integer;
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "LotNotes" varchar(2000);
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "SourceCreatedAt" timestamp;
ALTER TABLE "dwh"."DimStockLot" ADD COLUMN IF NOT EXISTS "SourceUpdatedAt" timestamp;

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimStockLot_StockLotId"
    ON "dwh"."DimStockLot" ("StockLotId");

-- Insert unknown member (-1)
INSERT INTO "dwh"."DimStockLot" (
    "StockLotKey",
    "StockLotId",
    "LotNumber",
    "InternalReference",
    "SourceProductId",
    "SourceProductUomId",
    "SourceCompanyId",
    "SourceLocationId",
    "LotNotes",
    "SourceCreatedAt",
    "SourceUpdatedAt"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1,
    -1,
    'Unknown',
    'Unknown',
    -1,
    -1,
    -1,
    -1,
    'Unknown',
    '1900-01-01 00:00:00'::timestamp,
    '1900-01-01 00:00:00'::timestamp
)
ON CONFLICT ("StockLotKey") DO NOTHING;

-- Upsert dimension records (SCD Type 1)
WITH "deduped_source" AS (
    SELECT
        s."id"::integer AS "StockLotId",
        TRIM(s."name")::varchar(255) AS "LotNumber",
        TRIM(s."ref")::varchar(255) AS "InternalReference",
        s."product_id"::integer AS "SourceProductId",
        s."product_uom_id"::integer AS "SourceProductUomId",
        s."company_id"::integer AS "SourceCompanyId",
        s."location_id"::integer AS "SourceLocationId",
        TRIM(s."note")::varchar(2000) AS "LotNotes",
        s."create_date"::timestamp AS "SourceCreatedAt",
        s."write_date"::timestamp AS "SourceUpdatedAt",
        ROW_NUMBER() OVER (
            PARTITION BY s."id"
            ORDER BY s."write_date" DESC NULLS LAST, s."create_date" DESC NULLS LAST
        ) AS "rn"
    FROM "staging"."odoo_stock_lot" AS s
    WHERE s."id" IS NOT NULL
)
INSERT INTO "dwh"."DimStockLot" (
    "StockLotId",
    "LotNumber",
    "InternalReference",
    "SourceProductId",
    "SourceProductUomId",
    "SourceCompanyId",
    "SourceLocationId",
    "LotNotes",
    "SourceCreatedAt",
    "SourceUpdatedAt"
)
SELECT
    src."StockLotId",
    src."LotNumber",
    src."InternalReference",
    src."SourceProductId",
    src."SourceProductUomId",
    src."SourceCompanyId",
    src."SourceLocationId",
    src."LotNotes",
    src."SourceCreatedAt",
    src."SourceUpdatedAt"
FROM "deduped_source" AS src
WHERE src."rn" = 1
ON CONFLICT ("StockLotId") DO UPDATE
SET
    "LotNumber"           = EXCLUDED."LotNumber",
    "InternalReference"   = EXCLUDED."InternalReference",
    "SourceProductId"     = EXCLUDED."SourceProductId",
    "SourceProductUomId"  = EXCLUDED."SourceProductUomId",
    "SourceCompanyId"     = EXCLUDED."SourceCompanyId",
    "SourceLocationId"    = EXCLUDED."SourceLocationId",
    "LotNotes"            = EXCLUDED."LotNotes",
    "SourceCreatedAt"     = EXCLUDED."SourceCreatedAt",
    "SourceUpdatedAt"     = EXCLUDED."SourceUpdatedAt";
