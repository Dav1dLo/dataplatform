-- Work Item:   ad-hoc
-- Task:        dwh.FactInventoryMonthlySnapshot
-- Spec:        Specification/dwh/dwh.FactInventoryMonthlySnapshot.md
-- Version:     1
-- Generated:   2026-09-10T15:06:02.707877+00:00
-- Notes:       Initial implementation of FactInventoryMonthlySnapshot table and periodic reload pattern.

CREATE SCHEMA IF NOT EXISTS "dwh";

CREATE TABLE IF NOT EXISTS "dwh"."FactInventoryMonthlySnapshot" (
    "InventoryMonthlySnapshotKey" bigint GENERATED ALWAYS AS IDENTITY,
    "SnapshotDateKey"             integer       NOT NULL,
    "SnapshotDate"                date          NOT NULL,
    "YearMonth"                   varchar(7)    NOT NULL,
    "ProductKey"                  integer       NOT NULL DEFAULT -1,
    "LocationKey"                 integer       NOT NULL DEFAULT -1,
    "StockLotKey"                 integer       NOT NULL DEFAULT -1,
    "CompanyId"                   integer,
    "PackageId"                   integer,
    "OwnerId"                     integer,
    "StorageCategoryId"           integer,
    "OnHandQuantity"              numeric(38,6), -- semi-additive: not over time
    "ReservedQuantity"            numeric(38,6), -- semi-additive: not over time
    "AvailableQuantity"           numeric(38,6), -- semi-additive: not over time
    "UnitCost"                    numeric(38,6), -- non-additive: do NOT SUM
    "TotalInventoryValuation"     numeric(38,6), -- semi-additive: not over time
    "RemainingQuantity"           numeric(38,6), -- semi-additive: not over time
    "RemainingValuation"          numeric(38,6), -- semi-additive: not over time
    "DwhCreatedAt"                timestamp     NOT NULL DEFAULT clock_timestamp(),
    "DwhUpdatedAt"                timestamp     NOT NULL DEFAULT clock_timestamp(),
    CONSTRAINT "PK_FactInventoryMonthlySnapshot" PRIMARY KEY ("InventoryMonthlySnapshotKey")
);

-- Ensure each column exists idempotently for additive schema evolution
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "InventoryMonthlySnapshotKey" bigint GENERATED ALWAYS AS IDENTITY;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "SnapshotDateKey" integer;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "SnapshotDate" date;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "YearMonth" varchar(7);
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "ProductKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "LocationKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "StockLotKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "CompanyId" integer;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "PackageId" integer;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "OwnerId" integer;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "StorageCategoryId" integer;
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "OnHandQuantity" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "ReservedQuantity" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "AvailableQuantity" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "UnitCost" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "TotalInventoryValuation" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "RemainingQuantity" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "RemainingValuation" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "DwhCreatedAt" timestamp DEFAULT clock_timestamp();
ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD COLUMN IF NOT EXISTS "DwhUpdatedAt" timestamp DEFAULT clock_timestamp();

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed
-- Apply schema changes migration (renames are applied in-place / lossless; drops only when confirmed).

-- Natural grain uniqueness constraint across snapshot date, product, location, stock lot, and company
CREATE UNIQUE INDEX IF NOT EXISTS "UK_FactInventoryMonthlySnapshot_Grain"
    ON "dwh"."FactInventoryMonthlySnapshot" ("SnapshotDateKey", "ProductKey", "LocationKey", "StockLotKey", "CompanyId");

-- Foreign key index lookups
CREATE INDEX IF NOT EXISTS "IX_FactInventoryMonthlySnapshot_ProductKey"  ON "dwh"."FactInventoryMonthlySnapshot" ("ProductKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryMonthlySnapshot_LocationKey" ON "dwh"."FactInventoryMonthlySnapshot" ("LocationKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryMonthlySnapshot_StockLotKey" ON "dwh"."FactInventoryMonthlySnapshot" ("StockLotKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryMonthlySnapshot_DateKey"     ON "dwh"."FactInventoryMonthlySnapshot" ("SnapshotDateKey");

-- Guarded foreign-key constraints to dimension surrogate keys
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryMonthlySnapshot_DimProduct') THEN
        ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD CONSTRAINT "FK_FactInventoryMonthlySnapshot_DimProduct"
            FOREIGN KEY ("ProductKey") REFERENCES "dwh"."DimProduct" ("ProductKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryMonthlySnapshot_DimLocation') THEN
        ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD CONSTRAINT "FK_FactInventoryMonthlySnapshot_DimLocation"
            FOREIGN KEY ("LocationKey") REFERENCES "dwh"."DimLocation" ("LocationKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryMonthlySnapshot_DimStockLot') THEN
        ALTER TABLE "dwh"."FactInventoryMonthlySnapshot" ADD CONSTRAINT "FK_FactInventoryMonthlySnapshot_DimStockLot"
            FOREIGN KEY ("StockLotKey") REFERENCES "dwh"."DimStockLot" ("StockLotKey");
    END IF;
END $$;

-- Periodic snapshot monthly load block
DO $$
DECLARE
    -- Target snapshot calculation date: default to latest completed month end or specified date
    v_snapshot_date date := (date_trunc('month', CURRENT_DATE) - INTERVAL '1 day')::date;
    v_snapshot_date_key integer := to_char(v_snapshot_date, 'YYYYMMDD')::integer;
    v_year_month varchar(7) := to_char(v_snapshot_date, 'YYYY-MM');
    v_cutoff_ts timestamp := (v_snapshot_date + INTERVAL '1 day' - INTERVAL '1 microsecond')::timestamp;
BEGIN
    -- 1. Idempotently remove existing snapshot partition for the target period
    DELETE FROM "dwh"."FactInventoryMonthlySnapshot"
    WHERE "SnapshotDateKey" = v_snapshot_date_key;

    -- 2. Insert calculated snapshot balances for the target period
    WITH "quant_aggregated" AS (
        SELECT
            q."product_id",
            q."location_id",
            q."lot_id",
            q."company_id",
            MAX(q."package_id") AS "package_id",
            MAX(q."owner_id") AS "owner_id",
            MAX(q."storage_category_id") AS "storage_category_id",
            SUM(COALESCE(q."quantity", 0))::numeric(38,6) AS "quantity",
            SUM(COALESCE(q."reserved_quantity", 0))::numeric(38,6) AS "reserved_quantity"
        FROM "staging"."odoo_stock_quant" AS q
        GROUP BY
            q."product_id",
            q."location_id",
            q."lot_id",
            q."company_id"
    ),
    "valuation_aggregated" AS (
        SELECT
            v."product_id",
            v."company_id",
            v."lot_id",
            AVG(v."unit_cost")::numeric(38,6) AS "unit_cost",
            SUM(COALESCE(v."remaining_qty", 0))::numeric(38,6) AS "remaining_qty",
            SUM(COALESCE(v."remaining_value", 0))::numeric(38,6) AS "remaining_value"
        FROM "staging"."odoo_stock_valuation_layer" AS v
        WHERE COALESCE(v."accounting_date", v."create_date"::date) <= v_snapshot_date
           OR v."create_date" <= v_cutoff_ts
        GROUP BY
            v."product_id",
            v."company_id",
            v."lot_id"
    )
    INSERT INTO "dwh"."FactInventoryMonthlySnapshot" (
        "SnapshotDateKey",
        "SnapshotDate",
        "YearMonth",
        "ProductKey",
        "LocationKey",
        "StockLotKey",
        "CompanyId",
        "PackageId",
        "OwnerId",
        "StorageCategoryId",
        "OnHandQuantity",
        "ReservedQuantity",
        "AvailableQuantity",
        "UnitCost",
        "TotalInventoryValuation",
        "RemainingQuantity",
        "RemainingValuation",
        "DwhCreatedAt",
        "DwhUpdatedAt"
    )
    SELECT
        v_snapshot_date_key AS "SnapshotDateKey",
        v_snapshot_date AS "SnapshotDate",
        v_year_month AS "YearMonth",
        COALESCE(dp."ProductKey", -1) AS "ProductKey",
        COALESCE(dl."LocationKey", -1) AS "LocationKey",
        COALESCE(dsl."StockLotKey", -1) AS "StockLotKey",
        q."company_id" AS "CompanyId",
        q."package_id" AS "PackageId",
        q."owner_id" AS "OwnerId",
        q."storage_category_id" AS "StorageCategoryId",
        q."quantity" AS "OnHandQuantity",
        q."reserved_quantity" AS "ReservedQuantity",
        (q."quantity" - q."reserved_quantity")::numeric(38,6) AS "AvailableQuantity",
        vl."unit_cost" AS "UnitCost",
        COALESCE(vl."remaining_value", (q."quantity" * COALESCE(vl."unit_cost", 0)))::numeric(38,6) AS "TotalInventoryValuation",
        vl."remaining_qty" AS "RemainingQuantity",
        vl."remaining_value" AS "RemainingValuation",
        clock_timestamp() AS "DwhCreatedAt",
        clock_timestamp() AS "DwhUpdatedAt"
    FROM "quant_aggregated" AS q
    LEFT JOIN "valuation_aggregated" AS vl
        ON vl."product_id" = q."product_id"
       AND vl."company_id" = q."company_id"
       AND (vl."lot_id" = q."lot_id" OR (vl."lot_id" IS NULL AND q."lot_id" IS NULL))
    LEFT JOIN "dwh"."DimProduct" AS dp
        ON dp."ProductBK" = q."product_id"
    LEFT JOIN "dwh"."DimLocation" AS dl
        ON dl."LocationId" = q."location_id"
    LEFT JOIN "dwh"."DimStockLot" AS dsl
        ON dsl."StockLotId" = q."lot_id";
END $$;
