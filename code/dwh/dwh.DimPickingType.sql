-- Work Item: ad-hoc
-- Task: dwh.DimPickingType
-- Spec: Specification/dwh.DimPickingType.md
-- Version: 1
-- Generated: 2026-09-10T14:57:40.779874+00:00
-- Notes: Initial generation of dwh.DimPickingType table, unknown member, and SCD1 upsert logic

CREATE SCHEMA IF NOT EXISTS "dwh";

CREATE TABLE IF NOT EXISTS "dwh"."DimPickingType" (
    "PickingTypeKey" integer GENERATED ALWAYS AS IDENTITY,
    "PickingTypeId" integer NOT NULL,
    "PickingTypeName" varchar(255),
    "SequenceCode" varchar(255),
    "OperationCode" varchar(50),
    "OperationCategory" varchar(50),
    "WarehouseId" integer,
    "WarehouseCode" varchar(5),
    "WarehouseName" varchar(255),
    "DefaultSourceLocationId" integer,
    "DefaultDestinationLocationId" integer,
    "ReturnPickingTypeId" integer,
    "CompanyId" integer,
    "ReservationMethod" varchar(50),
    "ReservationDaysBefore" integer,
    "ReservationDaysBeforePriority" integer,
    "CreateBackorderPolicy" varchar(50),
    "MoveType" varchar(50),
    "Barcode" varchar(255),
    "SequenceOrder" integer,
    "UseCreateLots" boolean,
    "UseExistingLots" boolean,
    "ShowEntirePacks" boolean,
    "ShowOperations" boolean,
    "IsActive" boolean,
    CONSTRAINT "PK_DimPickingType" PRIMARY KEY ("PickingTypeKey")
);

ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "PickingTypeId" integer NOT NULL;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "PickingTypeName" varchar(255);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "SequenceCode" varchar(255);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "OperationCode" varchar(50);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "OperationCategory" varchar(50);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "WarehouseId" integer;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "WarehouseCode" varchar(5);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "WarehouseName" varchar(255);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "DefaultSourceLocationId" integer;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "DefaultDestinationLocationId" integer;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "ReturnPickingTypeId" integer;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "CompanyId" integer;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "ReservationMethod" varchar(50);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "ReservationDaysBefore" integer;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "ReservationDaysBeforePriority" integer;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "CreateBackorderPolicy" varchar(50);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "MoveType" varchar(50);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "Barcode" varchar(255);
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "SequenceOrder" integer;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "UseCreateLots" boolean;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "UseExistingLots" boolean;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "ShowEntirePacks" boolean;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "ShowOperations" boolean;
ALTER TABLE "dwh"."DimPickingType" ADD COLUMN IF NOT EXISTS "IsActive" boolean;

-- This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed
-- Apply schema changes migration (renames are applied in-place / lossless; drops only when confirmed).

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimPickingType_PickingTypeId"
    ON "dwh"."DimPickingType" ("PickingTypeId");

INSERT INTO "dwh"."DimPickingType" (
    "PickingTypeKey",
    "PickingTypeId",
    "PickingTypeName",
    "SequenceCode",
    "OperationCode",
    "OperationCategory",
    "WarehouseId",
    "WarehouseCode",
    "WarehouseName",
    "DefaultSourceLocationId",
    "DefaultDestinationLocationId",
    "ReturnPickingTypeId",
    "CompanyId",
    "ReservationMethod",
    "ReservationDaysBefore",
    "ReservationDaysBeforePriority",
    "CreateBackorderPolicy",
    "MoveType",
    "Barcode",
    "SequenceOrder",
    "UseCreateLots",
    "UseExistingLots",
    "ShowEntirePacks",
    "ShowOperations",
    "IsActive"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1,
    -1,
    'Unknown',
    'Unknown',
    'Unknown',
    'Unknown',
    -1,
    'Unk',
    'Unknown',
    -1,
    -1,
    -1,
    -1,
    'Unknown',
    -1,
    -1,
    'Unknown',
    'Unknown',
    'Unknown',
    -1,
    false,
    false,
    false,
    false,
    false
)
ON CONFLICT ("PickingTypeKey") DO NOTHING;

INSERT INTO "dwh"."DimPickingType" AS target (
    "PickingTypeId",
    "PickingTypeName",
    "SequenceCode",
    "OperationCode",
    "OperationCategory",
    "WarehouseId",
    "WarehouseCode",
    "WarehouseName",
    "DefaultSourceLocationId",
    "DefaultDestinationLocationId",
    "ReturnPickingTypeId",
    "CompanyId",
    "ReservationMethod",
    "ReservationDaysBefore",
    "ReservationDaysBeforePriority",
    "CreateBackorderPolicy",
    "MoveType",
    "Barcode",
    "SequenceOrder",
    "UseCreateLots",
    "UseExistingLots",
    "ShowEntirePacks",
    "ShowOperations",
    "IsActive"
)
SELECT
    pt."id"::integer AS "PickingTypeId",
    COALESCE(
        pt."name"->>'en_US',
        pt."name"->>'en_GB',
        (SELECT val."value" FROM jsonb_each_text(pt."name") AS val LIMIT 1)
    )::varchar(255) AS "PickingTypeName",
    pt."sequence_code"::varchar(255) AS "SequenceCode",
    pt."code"::varchar(50) AS "OperationCode",
    CASE pt."code"
        WHEN 'incoming' THEN 'Receipts'
        WHEN 'outgoing' THEN 'Delivery Orders'
        WHEN 'internal' THEN 'Internal Transfers'
        WHEN 'mrp_operation' THEN 'Manufacturing'
        ELSE INITCAP(REPLACE(pt."code", '_', ' '))
    END::varchar(50) AS "OperationCategory",
    pt."warehouse_id"::integer AS "WarehouseId",
    wh."code"::varchar(5) AS "WarehouseCode",
    wh."name"::varchar(255) AS "WarehouseName",
    pt."default_location_src_id"::integer AS "DefaultSourceLocationId",
    pt."default_location_dest_id"::integer AS "DefaultDestinationLocationId",
    pt."return_picking_type_id"::integer AS "ReturnPickingTypeId",
    pt."company_id"::integer AS "CompanyId",
    pt."reservation_method"::varchar(50) AS "ReservationMethod",
    pt."reservation_days_before"::integer AS "ReservationDaysBefore",
    pt."reservation_days_before_priority"::integer AS "ReservationDaysBeforePriority",
    pt."create_backorder"::varchar(50) AS "CreateBackorderPolicy",
    pt."move_type"::varchar(50) AS "MoveType",
    pt."barcode"::varchar(255) AS "Barcode",
    pt."sequence"::integer AS "SequenceOrder",
    pt."use_create_lots"::boolean AS "UseCreateLots",
    pt."use_existing_lots"::boolean AS "UseExistingLots",
    pt."show_entire_packs"::boolean AS "ShowEntirePacks",
    pt."show_operations"::boolean AS "ShowOperations",
    pt."active"::boolean AS "IsActive"
FROM "staging"."odoo_stock_picking_type" AS pt
LEFT JOIN "staging"."odoo_stock_warehouse" AS wh
    ON pt."warehouse_id" = wh."id"
ON CONFLICT ("PickingTypeId") DO UPDATE
SET
    "PickingTypeName" = EXCLUDED."PickingTypeName",
    "SequenceCode" = EXCLUDED."SequenceCode",
    "OperationCode" = EXCLUDED."OperationCode",
    "OperationCategory" = EXCLUDED."OperationCategory",
    "WarehouseId" = EXCLUDED."WarehouseId",
    "WarehouseCode" = EXCLUDED."WarehouseCode",
    "WarehouseName" = EXCLUDED."WarehouseName",
    "DefaultSourceLocationId" = EXCLUDED."DefaultSourceLocationId",
    "DefaultDestinationLocationId" = EXCLUDED."DefaultDestinationLocationId",
    "ReturnPickingTypeId" = EXCLUDED."ReturnPickingTypeId",
    "CompanyId" = EXCLUDED."CompanyId",
    "ReservationMethod" = EXCLUDED."ReservationMethod",
    "ReservationDaysBefore" = EXCLUDED."ReservationDaysBefore",
    "ReservationDaysBeforePriority" = EXCLUDED."ReservationDaysBeforePriority",
    "CreateBackorderPolicy" = EXCLUDED."CreateBackorderPolicy",
    "MoveType" = EXCLUDED."MoveType",
    "Barcode" = EXCLUDED."Barcode",
    "SequenceOrder" = EXCLUDED."SequenceOrder",
    "UseCreateLots" = EXCLUDED."UseCreateLots",
    "UseExistingLots" = EXCLUDED."UseExistingLots",
    "ShowEntirePacks" = EXCLUDED."ShowEntirePacks",
    "ShowOperations" = EXCLUDED."ShowOperations",
    "IsActive" = EXCLUDED."IsActive"
WHERE target."PickingTypeName" IS DISTINCT FROM EXCLUDED."PickingTypeName"
   OR target."SequenceCode" IS DISTINCT FROM EXCLUDED."SequenceCode"
   OR target."OperationCode" IS DISTINCT FROM EXCLUDED."OperationCode"
   OR target."OperationCategory" IS DISTINCT FROM EXCLUDED."OperationCategory"
   OR target."WarehouseId" IS DISTINCT FROM EXCLUDED."WarehouseId"
   OR target."WarehouseCode" IS DISTINCT FROM EXCLUDED."WarehouseCode"
   OR target."WarehouseName" IS DISTINCT FROM EXCLUDED."WarehouseName"
   OR target."DefaultSourceLocationId" IS DISTINCT FROM EXCLUDED."DefaultSourceLocationId"
   OR target."DefaultDestinationLocationId" IS DISTINCT FROM EXCLUDED."DefaultDestinationLocationId"
   OR target."ReturnPickingTypeId" IS DISTINCT FROM EXCLUDED."ReturnPickingTypeId"
   OR target."CompanyId" IS DISTINCT FROM EXCLUDED."CompanyId"
   OR target."ReservationMethod" IS DISTINCT FROM EXCLUDED."ReservationMethod"
   OR target."ReservationDaysBefore" IS DISTINCT FROM EXCLUDED."ReservationDaysBefore"
   OR target."ReservationDaysBeforePriority" IS DISTINCT FROM EXCLUDED."ReservationDaysBeforePriority"
   OR target."CreateBackorderPolicy" IS DISTINCT FROM EXCLUDED."CreateBackorderPolicy"
   OR target."MoveType" IS DISTINCT FROM EXCLUDED."MoveType"
   OR target."Barcode" IS DISTINCT FROM EXCLUDED."Barcode"
   OR target."SequenceOrder" IS DISTINCT FROM EXCLUDED."SequenceOrder"
   OR target."UseCreateLots" IS DISTINCT FROM EXCLUDED."UseCreateLots"
   OR target."UseExistingLots" IS DISTINCT FROM EXCLUDED."UseExistingLots"
   OR target."ShowEntirePacks" IS DISTINCT FROM EXCLUDED."ShowEntirePacks"
   OR target."ShowOperations" IS DISTINCT FROM EXCLUDED."ShowOperations"
   OR target."IsActive" IS DISTINCT FROM EXCLUDED."IsActive";
