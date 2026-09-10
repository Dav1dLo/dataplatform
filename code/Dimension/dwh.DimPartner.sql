-- Work Item: ad-hoc
-- Task: dwh.DimPartner
-- Spec: Specification/Dimension/dwh.DimPartner.md
-- Version: 1
-- Generated: 2026-09-10T14:57:37.545696+00:00
-- Notes: Initial generation of DimPartner DDL and SCD1 upsert DML.

CREATE SCHEMA IF NOT EXISTS "dwh";

CREATE TABLE IF NOT EXISTS "dwh"."DimPartner" (
    "PartnerKey" integer GENERATED ALWAYS AS IDENTITY,
    "PartnerID" integer NOT NULL,
    "PartnerName" varchar(255),
    "CompleteName" varchar(255),
    "InternalReference" varchar(255),
    "CompanyRegistry" varchar(255),
    "TaxID" varchar(255),
    "AddressType" varchar(255),
    "Street" varchar(255),
    "Street2" varchar(255),
    "City" varchar(255),
    "PostalCode" varchar(255),
    "Email" varchar(255),
    "NormalizedEmail" varchar(255),
    "Phone" varchar(255),
    "Mobile" varchar(255),
    "LanguageCode" varchar(255),
    "Timezone" varchar(255),
    "Website" varchar(255),
    "JobTitle" varchar(255),
    "CompanyName" varchar(255),
    "CommercialCompanyName" varchar(255),
    "IsCompany" boolean,
    "IsEmployee" boolean,
    "IsCustomer" boolean,
    "IsSupplier" boolean,
    "CustomerRank" integer,
    "SupplierRank" integer,
    "ParentPartnerID" integer,
    "CommercialPartnerID" integer,
    "StateID" integer,
    "CountryID" integer,
    "IndustryID" integer,
    "CompanyID" integer,
    "PartnerLatitude" numeric(18,6),
    "PartnerLongitude" numeric(18,6),
    "PickingWarn" varchar(255),
    "InvoiceWarn" varchar(255),
    "DebitLimit" numeric(18,2),
    "IsActive" boolean,
    "SourceCreatedAt" timestamp,
    "SourceUpdatedAt" timestamp,
    CONSTRAINT "PK_DimPartner" PRIMARY KEY ("PartnerKey")
);

-- Ensure columns exist for additive schema evolution
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "PartnerKey" integer GENERATED ALWAYS AS IDENTITY;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "PartnerID" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "PartnerName" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "CompleteName" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "InternalReference" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "CompanyRegistry" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "TaxID" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "AddressType" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "Street" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "Street2" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "City" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "PostalCode" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "Email" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "NormalizedEmail" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "Phone" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "Mobile" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "LanguageCode" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "Timezone" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "Website" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "JobTitle" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "CompanyName" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "CommercialCompanyName" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "IsCompany" boolean;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "IsEmployee" boolean;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "IsCustomer" boolean;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "IsSupplier" boolean;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "CustomerRank" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "SupplierRank" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "ParentPartnerID" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "CommercialPartnerID" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "StateID" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "CountryID" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "IndustryID" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "CompanyID" integer;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "PartnerLatitude" numeric(18,6);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "PartnerLongitude" numeric(18,6);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "PickingWarn" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "InvoiceWarn" varchar(255);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "DebitLimit" numeric(18,2);
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "IsActive" boolean;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "SourceCreatedAt" timestamp;
ALTER TABLE "dwh"."DimPartner" ADD COLUMN IF NOT EXISTS "SourceUpdatedAt" timestamp;

-- Note: This script creates the table and adds any missing columns but does NOT rename or drop columns.
-- Columns renamed or removed in the spec must be reconciled with the workspace's reviewed Apply schema changes migration.

CREATE UNIQUE INDEX IF NOT EXISTS "UK_DimPartner_PartnerID"
    ON "dwh"."DimPartner" ("PartnerID");

-- Unknown member (-1 row)
INSERT INTO "dwh"."DimPartner" (
    "PartnerKey", "PartnerID", "PartnerName", "CompleteName", "InternalReference",
    "CompanyRegistry", "TaxID", "AddressType", "Street", "Street2",
    "City", "PostalCode", "Email", "NormalizedEmail", "Phone",
    "Mobile", "LanguageCode", "Timezone", "Website", "JobTitle",
    "CompanyName", "CommercialCompanyName", "IsCompany", "IsEmployee", "IsCustomer",
    "IsSupplier", "CustomerRank", "SupplierRank", "ParentPartnerID", "CommercialPartnerID",
    "StateID", "CountryID", "IndustryID", "CompanyID", "PartnerLatitude",
    "PartnerLongitude", "PickingWarn", "InvoiceWarn", "DebitLimit", "IsActive",
    "SourceCreatedAt", "SourceUpdatedAt"
)
OVERRIDING SYSTEM VALUE
VALUES (
    -1, -1, 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', false, false, false,
    false, -1, -1, -1, -1,
    -1, -1, -1, -1, 0,
    0, 'Unknown', 'Unknown', 0, false,
    '1900-01-01 00:00:00'::timestamp, '1900-01-01 00:00:00'::timestamp
)
ON CONFLICT ("PartnerKey") DO NOTHING;

-- SCD Type 1 Upsert Load
INSERT INTO "dwh"."DimPartner" (
    "PartnerID",
    "PartnerName",
    "CompleteName",
    "InternalReference",
    "CompanyRegistry",
    "TaxID",
    "AddressType",
    "Street",
    "Street2",
    "City",
    "PostalCode",
    "Email",
    "NormalizedEmail",
    "Phone",
    "Mobile",
    "LanguageCode",
    "Timezone",
    "Website",
    "JobTitle",
    "CompanyName",
    "CommercialCompanyName",
    "IsCompany",
    "IsEmployee",
    "IsCustomer",
    "IsSupplier",
    "CustomerRank",
    "SupplierRank",
    "ParentPartnerID",
    "CommercialPartnerID",
    "StateID",
    "CountryID",
    "IndustryID",
    "CompanyID",
    "PartnerLatitude",
    "PartnerLongitude",
    "PickingWarn",
    "InvoiceWarn",
    "DebitLimit",
    "IsActive",
    "SourceCreatedAt",
    "SourceUpdatedAt"
)
SELECT
    s."id"::integer AS "PartnerID",
    s."name"::varchar(255) AS "PartnerName",
    s."complete_name"::varchar(255) AS "CompleteName",
    s."ref"::varchar(255) AS "InternalReference",
    s."company_registry"::varchar(255) AS "CompanyRegistry",
    s."vat"::varchar(255) AS "TaxID",
    s."type"::varchar(255) AS "AddressType",
    s."street"::varchar(255) AS "Street",
    s."street2"::varchar(255) AS "Street2",
    s."city"::varchar(255) AS "City",
    s."zip"::varchar(255) AS "PostalCode",
    s."email"::varchar(255) AS "Email",
    s."email_normalized"::varchar(255) AS "NormalizedEmail",
    s."phone"::varchar(255) AS "Phone",
    s."mobile"::varchar(255) AS "Mobile",
    s."lang"::varchar(255) AS "LanguageCode",
    s."tz"::varchar(255) AS "Timezone",
    s."website"::varchar(255) AS "Website",
    s."function"::varchar(255) AS "JobTitle",
    s."company_name"::varchar(255) AS "CompanyName",
    s."commercial_company_name"::varchar(255) AS "CommercialCompanyName",
    s."is_company"::boolean AS "IsCompany",
    s."employee"::boolean AS "IsEmployee",
    (CASE WHEN s."customer_rank" > 0 THEN TRUE ELSE FALSE END)::boolean AS "IsCustomer",
    (CASE WHEN s."supplier_rank" > 0 THEN TRUE ELSE FALSE END)::boolean AS "IsSupplier",
    s."customer_rank"::integer AS "CustomerRank",
    s."supplier_rank"::integer AS "SupplierRank",
    s."parent_id"::integer AS "ParentPartnerID",
    s."commercial_partner_id"::integer AS "CommercialPartnerID",
    s."state_id"::integer AS "StateID",
    s."country_id"::integer AS "CountryID",
    s."industry_id"::integer AS "IndustryID",
    s."company_id"::integer AS "CompanyID",
    s."partner_latitude"::numeric(18,6) AS "PartnerLatitude",
    s."partner_longitude"::numeric(18,6) AS "PartnerLongitude",
    s."picking_warn"::varchar(255) AS "PickingWarn",
    s."invoice_warn"::varchar(255) AS "InvoiceWarn",
    s."debit_limit"::numeric(18,2) AS "DebitLimit",
    s."active"::boolean AS "IsActive",
    s."create_date"::timestamp AS "SourceCreatedAt",
    s."write_date"::timestamp AS "SourceUpdatedAt"
FROM "staging"."odoo_res_partner" AS s
ON CONFLICT ("PartnerID") DO UPDATE SET
    "PartnerName" = EXCLUDED."PartnerName",
    "CompleteName" = EXCLUDED."CompleteName",
    "InternalReference" = EXCLUDED."InternalReference",
    "CompanyRegistry" = EXCLUDED."CompanyRegistry",
    "TaxID" = EXCLUDED."TaxID",
    "AddressType" = EXCLUDED."AddressType",
    "Street" = EXCLUDED."Street",
    "Street2" = EXCLUDED."Street2",
    "City" = EXCLUDED."City",
    "PostalCode" = EXCLUDED."PostalCode",
    "Email" = EXCLUDED."Email",
    "NormalizedEmail" = EXCLUDED."NormalizedEmail",
    "Phone" = EXCLUDED."Phone",
    "Mobile" = EXCLUDED."Mobile",
    "LanguageCode" = EXCLUDED."LanguageCode",
    "Timezone" = EXCLUDED."Timezone",
    "Website" = EXCLUDED."Website",
    "JobTitle" = EXCLUDED."JobTitle",
    "CompanyName" = EXCLUDED."CompanyName",
    "CommercialCompanyName" = EXCLUDED."CommercialCompanyName",
    "IsCompany" = EXCLUDED."IsCompany",
    "IsEmployee" = EXCLUDED."IsEmployee",
    "IsCustomer" = EXCLUDED."IsCustomer",
    "IsSupplier" = EXCLUDED."IsSupplier",
    "CustomerRank" = EXCLUDED."CustomerRank",
    "SupplierRank" = EXCLUDED."SupplierRank",
    "ParentPartnerID" = EXCLUDED."ParentPartnerID",
    "CommercialPartnerID" = EXCLUDED."CommercialPartnerID",
    "StateID" = EXCLUDED."StateID",
    "CountryID" = EXCLUDED."CountryID",
    "IndustryID" = EXCLUDED."IndustryID",
    "CompanyID" = EXCLUDED."CompanyID",
    "PartnerLatitude" = EXCLUDED."PartnerLatitude",
    "PartnerLongitude" = EXCLUDED."PartnerLongitude",
    "PickingWarn" = EXCLUDED."PickingWarn",
    "InvoiceWarn" = EXCLUDED."InvoiceWarn",
    "DebitLimit" = EXCLUDED."DebitLimit",
    "IsActive" = EXCLUDED."IsActive",
    "SourceCreatedAt" = EXCLUDED."SourceCreatedAt",
    "SourceUpdatedAt" = EXCLUDED."SourceUpdatedAt";
