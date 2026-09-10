-- Work Item:   ad-hoc
-- Task:        dwh.FactInventoryTransaction
-- Spec:        Specification/dwh/Fact/dwh.FactInventoryTransaction.md
-- Version:     1
-- Generated:   2026-09-10T15:22:47.166741+00:00
-- Notes:       Initial generation of dwh.FactInventoryTransaction DDL and DML.

CREATE SCHEMA IF NOT EXISTS "dwh";

CREATE TABLE IF NOT EXISTS "dwh"."FactInventoryTransaction" (
    "InventoryTransactionKey" bigint GENERATED ALWAYS AS IDENTITY,
    "StockMoveLineID"        integer NOT NULL,
    "StockMoveID"            integer,
    "StockPickingID"         integer,
    "ScrapID"                integer,
    "ProductKey"             integer NOT NULL DEFAULT -1,
    "SourceLocationKey"      integer NOT NULL DEFAULT -1,
    "DestinationLocationKey" integer NOT NULL DEFAULT -1,
    "StockLotKey"            integer NOT NULL DEFAULT -1,
    "PartnerKey"             integer NOT NULL DEFAULT -1,
    "PickingTypeKey"         integer NOT NULL DEFAULT -1,
    "MovementDate"           timestamp,
    "MovementDateKey"        integer NOT NULL DEFAULT -1,
    "CompanyId"              integer,
    "MovementState"          varchar(50),
    "ReferenceDocument"      varchar(255),
    "OriginDocument"         varchar(255),
    "ScrapReasonCode"        varchar(255),
    "MovementType"           varchar(50),
    "IsScrapped"             boolean,
    "IsInventoryAdjustment"  boolean,
    "QuantityMoved"          numeric(38,6),
    "QuantityProductUom"     numeric(38,6),
    "DemandQuantity"         numeric(38,6),
    "UnitCost"               numeric(38,6), -- non-additive: do NOT SUM
    "ValuationAmount"        numeric(38,6),
    "ScrapQuantity"          numeric(38,6),
    CONSTRAINT "PK_FactInventoryTransaction" PRIMARY KEY ("InventoryTransactionKey")
);

-- Ensure each spec column exists if the table was previously created
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "StockMoveLineID" integer;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "StockMoveID" integer;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "StockPickingID" integer;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "ScrapID" integer;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "ProductKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "SourceLocationKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "DestinationLocationKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "StockLotKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "PartnerKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "PickingTypeKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "MovementDate" timestamp;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "MovementDateKey" integer DEFAULT -1;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "CompanyId" integer;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "MovementState" varchar(50);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "ReferenceDocument" varchar(255);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "OriginDocument" varchar(255);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "ScrapReasonCode" varchar(255);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "MovementType" varchar(50);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "IsScrapped" boolean;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "IsInventoryAdjustment" boolean;
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "QuantityMoved" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "QuantityProductUom" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "DemandQuantity" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "UnitCost" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "ValuationAmount" numeric(38,6);
ALTER TABLE "dwh"."FactInventoryTransaction" ADD COLUMN IF NOT EXISTS "ScrapQuantity" numeric(38,6);

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

-- Natural grain uniqueness: conflict target for idempotent load
CREATE UNIQUE INDEX IF NOT EXISTS "UK_FactInventoryTransaction_Grain"
    ON "dwh"."FactInventoryTransaction" ("StockMoveLineID");

CREATE INDEX IF NOT EXISTS "IX_FactInventoryTransaction_ProductKey" ON "dwh"."FactInventoryTransaction" ("ProductKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryTransaction_SourceLocationKey" ON "dwh"."FactInventoryTransaction" ("SourceLocationKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryTransaction_DestinationLocationKey" ON "dwh"."FactInventoryTransaction" ("DestinationLocationKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryTransaction_StockLotKey" ON "dwh"."FactInventoryTransaction" ("StockLotKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryTransaction_PartnerKey" ON "dwh"."FactInventoryTransaction" ("PartnerKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryTransaction_PickingTypeKey" ON "dwh"."FactInventoryTransaction" ("PickingTypeKey");
CREATE INDEX IF NOT EXISTS "IX_FactInventoryTransaction_MovementDateKey" ON "dwh"."FactInventoryTransaction" ("MovementDateKey");

-- Foreign key constraints
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryTransaction_Product') THEN
        ALTER TABLE "dwh"."FactInventoryTransaction" ADD CONSTRAINT "FK_FactInventoryTransaction_Product"
            FOREIGN KEY ("ProductKey") REFERENCES "dwh"."DimProduct" ("ProductKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryTransaction_SourceLocation') THEN
        ALTER TABLE "dwh"."FactInventoryTransaction" ADD CONSTRAINT "FK_FactInventoryTransaction_SourceLocation"
            FOREIGN KEY ("SourceLocationKey") REFERENCES "dwh"."DimLocation" ("LocationKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryTransaction_DestinationLocation') THEN
        ALTER TABLE "dwh"."FactInventoryTransaction" ADD CONSTRAINT "FK_FactInventoryTransaction_DestinationLocation"
            FOREIGN KEY ("DestinationLocationKey") REFERENCES "dwh"."DimLocation" ("LocationKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryTransaction_StockLot') THEN
        ALTER TABLE "dwh"."FactInventoryTransaction" ADD CONSTRAINT "FK_FactInventoryTransaction_StockLot"
            FOREIGN KEY ("StockLotKey") REFERENCES "dwh"."DimStockLot" ("StockLotKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryTransaction_Partner') THEN
        ALTER TABLE "dwh"."FactInventoryTransaction" ADD CONSTRAINT "FK_FactInventoryTransaction_Partner"
            FOREIGN KEY ("PartnerKey") REFERENCES "dwh"."DimPartner" ("PartnerKey");
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'FK_FactInventoryTransaction_PickingType') THEN
        ALTER TABLE "dwh"."FactInventoryTransaction" ADD CONSTRAINT "FK_FactInventoryTransaction_PickingType"
            FOREIGN KEY ("PickingTypeKey") REFERENCES "dwh"."DimPickingType" ("PickingTypeKey");
    END IF;
END $$;

-- Load logic (Transaction Fact idempotent upsert)
WITH "val_agg" AS (
    SELECT
        "stock_move_id",
        AVG("unit_cost")::numeric(38,6) AS "unit_cost",
        SUM("value")::numeric(38,6) AS "value"
    FROM "staging"."odoo_stock_valuation_layer"
    GROUP BY "stock_move_id"
),
"src" AS (
    SELECT DISTINCT ON (sml."id")
        sml."id" AS "StockMoveLineID",
        sml."move_id" AS "StockMoveID",
        COALESCE(sml."picking_id", sm."picking_id") AS "StockPickingID",
        sm."scrap_id" AS "ScrapID",
        sml."product_id",
        sml."location_id",
        sml."location_dest_id",
        sml."lot_id",
        COALESCE(sm."partner_id", sp."partner_id") AS "partner_id",
        COALESCE(sm."picking_type_id", sp."picking_type_id") AS "picking_type_id",
        sml."date" AS "MovementDate",
        COALESCE(sm."company_id", sml."company_id") AS "CompanyId",
        sml."state" AS "MovementState",
        COALESCE(sml."reference", sm."reference", sp."name") AS "ReferenceDocument",
        COALESCE(sm."origin", sp."origin") AS "OriginDocument",
        scr."name" AS "ScrapReasonCode",
        COALESCE(sm."scrapped", sm."scrap_id" IS NOT NULL, FALSE) AS "IsScrapped",
        COALESCE(sm."is_inventory", FALSE) AS "IsInventoryAdjustment",
        sml."quantity"::numeric(38,6) AS "QuantityMoved",
        sml."quantity_product_uom"::numeric(38,6) AS "QuantityProductUom",
        sm."product_uom_qty"::numeric(38,6) AS "DemandQuantity",
        COALESCE(val."unit_cost", sm."price_unit"::numeric(38,6), 0.0)::numeric(38,6) AS "UnitCost",
        COALESCE(
            val."value",
            (sml."quantity"::numeric(38,6) * COALESCE(val."unit_cost", sm."price_unit"::numeric(38,6), 0.0))
        )::numeric(38,6) AS "ValuationAmount",
        CASE 
            WHEN COALESCE(sm."scrapped", FALSE) = TRUE THEN sml."quantity"::numeric(38,6)
            ELSE 0.0
        END AS "ScrapQuantity"
    FROM "staging"."odoo_stock_move_line" AS sml
    LEFT JOIN "staging"."odoo_stock_move" AS sm
        ON sml."move_id" = sm."id"
    LEFT JOIN "staging"."odoo_stock_picking" AS sp
        ON COALESCE(sml."picking_id", sm."picking_id") = sp."id"
    LEFT JOIN "staging"."odoo_stock_scrap" AS scr
        ON sm."scrap_id" = scr."id"
    LEFT JOIN "val_agg" AS val
        ON sml."move_id" = val."stock_move_id"
    WHERE sml."state" = 'done'
    ORDER BY sml."id"
)
INSERT INTO "dwh"."FactInventoryTransaction" (
    "StockMoveLineID",
    "StockMoveID",
    "StockPickingID",
    "ScrapID",
    "ProductKey",
    "SourceLocationKey",
    "DestinationLocationKey",
    "StockLotKey",
    "PartnerKey",
    "PickingTypeKey",
    "MovementDate",
    "MovementDateKey",
    "CompanyId",
    "MovementState",
    "ReferenceDocument",
    "OriginDocument",
    "ScrapReasonCode",
    "MovementType",
    "IsScrapped",
    "IsInventoryAdjustment",
    "QuantityMoved",
    "QuantityProductUom",
    "DemandQuantity",
    "UnitCost",
    "ValuationAmount",
    "ScrapQuantity"
)
SELECT
    src."StockMoveLineID",
    src."StockMoveID",
    src."StockPickingID",
    src."ScrapID",
    COALESCE(dp."ProductKey", -1) AS "ProductKey",
    COALESCE(src_loc."LocationKey", -1) AS "SourceLocationKey",
    COALESCE(dst_loc."LocationKey", -1) AS "DestinationLocationKey",
    COALESCE(dl."StockLotKey", -1) AS "StockLotKey",
    COALESCE(dpart."PartnerKey", -1) AS "PartnerKey",
    COALESCE(dpt."PickingTypeKey", -1) AS "PickingTypeKey",
    src."MovementDate",
    COALESCE(TO_CHAR(src."MovementDate", 'YYYYMMDD')::integer, -1) AS "MovementDateKey",
    src."CompanyId",
    src."MovementState",
    src."ReferenceDocument",
    src."OriginDocument",
    src."ScrapReasonCode",
    CASE
        WHEN src_loc."LocationUsage" = 'internal' AND dst_loc."LocationUsage" != 'internal' THEN 'Outbound'
        WHEN src_loc."LocationUsage" != 'internal' AND dst_loc."LocationUsage" = 'internal' THEN 'Inbound'
        WHEN src_loc."LocationUsage" = 'internal' AND dst_loc."LocationUsage" = 'internal' THEN 'Internal Transfer'
        ELSE 'Other'
    END AS "MovementType",
    src."IsScrapped",
    src."IsInventoryAdjustment",
    src."QuantityMoved",
    src."QuantityProductUom",
    src."DemandQuantity",
    src."UnitCost",
    src."ValuationAmount",
    src."ScrapQuantity"
FROM "src"
LEFT JOIN "dwh"."DimProduct" AS dp
    ON src."product_id" = dp."ProductBK"
LEFT JOIN "dwh"."DimLocation" AS src_loc
    ON src."location_id" = src_loc."LocationId"
LEFT JOIN "dwh"."DimLocation" AS dst_loc
    ON src."location_dest_id" = dst_loc."LocationId"
LEFT JOIN "dwh"."DimStockLot" AS dl
    ON src."lot_id" = dl."StockLotId"
LEFT JOIN "dwh"."DimPartner" AS dpart
    ON src."partner_id" = dpart."PartnerID"
LEFT JOIN "dwh"."DimPickingType" AS dpt
    ON src."picking_type_id" = dpt."PickingTypeId"
ON CONFLICT ("StockMoveLineID") DO UPDATE SET
    "StockMoveID"            = EXCLUDED."StockMoveID",
    "StockPickingID"         = EXCLUDED."StockPickingID",
    "ScrapID"                = EXCLUDED."ScrapID",
    "ProductKey"             = EXCLUDED."ProductKey",
    "SourceLocationKey"      = EXCLUDED."SourceLocationKey",
    "DestinationLocationKey" = EXCLUDED."DestinationLocationKey",
    "StockLotKey"            = EXCLUDED."StockLotKey",
    "PartnerKey"             = EXCLUDED."PartnerKey",
    "PickingTypeKey"         = EXCLUDED."PickingTypeKey",
    "MovementDate"           = EXCLUDED."MovementDate",
    "MovementDateKey"        = EXCLUDED."MovementDateKey",
    "CompanyId"              = EXCLUDED."CompanyId",
    "MovementState"          = EXCLUDED."MovementState",
    "ReferenceDocument"      = EXCLUDED."ReferenceDocument",
    "OriginDocument"         = EXCLUDED."OriginDocument",
    "ScrapReasonCode"        = EXCLUDED."ScrapReasonCode",
    "MovementType"           = EXCLUDED."MovementType",
    "IsScrapped"             = EXCLUDED."IsScrapped",
    "IsInventoryAdjustment"  = EXCLUDED."IsInventoryAdjustment",
    "QuantityMoved"          = EXCLUDED."QuantityMoved",
    "QuantityProductUom"     = EXCLUDED."QuantityProductUom",
    "DemandQuantity"         = EXCLUDED."DemandQuantity",
    "UnitCost"               = EXCLUDED."UnitCost",
    "ValuationAmount"        = EXCLUDED."ValuationAmount",
    "ScrapQuantity"          = EXCLUDED."ScrapQuantity";