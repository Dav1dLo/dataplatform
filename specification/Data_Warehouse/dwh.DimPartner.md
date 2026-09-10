# Fully Qualified Name: dwh.DimPartner

## Description
Represents business partners, including suppliers, customers, internal contacts, and commercial entities interacting with the organization's logistics and inventory flows. Captures contact attributes, classification indicators (supplier vs customer), geographic location, and commercial hierarchy for inventory transaction analysis and reporting.

## Grain
One row per partner entity (`PartnerID`).

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations |
| --- | --- | --- | --- | --- |
| `PartnerKey` | SK | integer | integer | System-generated surrogate primary key. |
| `PartnerID` | BK | integer | integer | Business key representing the unique partner identifier. Sourced from `staging.odoo_res_partner.id`. |
| `PartnerName` | SCD1 | varchar(255) | varchar(255) | Name of the partner entity. Sourced from `staging.odoo_res_partner.name`. Source precision unknown; safe default varchar(255). |
| `CompleteName` | SCD1 | varchar(255) | varchar(255) | Full hierarchical name of the partner. Sourced from `staging.odoo_res_partner.complete_name`. Source precision unknown; safe default varchar(255). |
| `InternalReference` | SCD1 | varchar(255) | varchar(255) | User-defined internal code or reference. Sourced from `staging.odoo_res_partner.ref`. Source precision unknown; safe default varchar(255). |
| `CompanyRegistry` | SCD1 | varchar(255) | varchar(255) | Company registration number. Sourced from `staging.odoo_res_partner.company_registry`. Source precision unknown; safe default varchar(255). |
| `TaxID` | SCD1 | varchar(255) | varchar(255) | Tax identification number / VAT number. Sourced from `staging.odoo_res_partner.vat`. Source precision unknown; safe default varchar(255). |
| `AddressType` | SCD1 | varchar(255) | varchar(255) | Type of address (e.g., 'contact', 'invoice', 'delivery'). Sourced from `staging.odoo_res_partner.type`. Source precision unknown; safe default varchar(255). |
| `Street` | SCD1 | varchar(255) | varchar(255) | Primary street address. Sourced from `staging.odoo_res_partner.street`. Source precision unknown; safe default varchar(255). |
| `Street2` | SCD1 | varchar(255) | varchar(255) | Secondary street address. Sourced from `staging.odoo_res_partner.street2`. Source precision unknown; safe default varchar(255). |
| `City` | SCD1 | varchar(255) | varchar(255) | City name. Sourced from `staging.odoo_res_partner.city`. Source precision unknown; safe default varchar(255). |
| `PostalCode` | SCD1 | varchar(255) | varchar(255) | Postal or ZIP code. Sourced from `staging.odoo_res_partner.zip`. Source precision unknown; safe default varchar(255). |
| `Email` | SCD1 | varchar(255) | varchar(255) | Contact email address. Sourced from `staging.odoo_res_partner.email`. Source precision unknown; safe default varchar(255). |
| `NormalizedEmail` | SCD1 | varchar(255) | varchar(255) | Normalized email address. Sourced from `staging.odoo_res_partner.email_normalized`. Source precision unknown; safe default varchar(255). |
| `Phone` | SCD1 | varchar(255) | varchar(255) | Primary phone number. Sourced from `staging.odoo_res_partner.phone`. Source precision unknown; safe default varchar(255). |
| `Mobile` | SCD1 | varchar(255) | varchar(255) | Mobile phone number. Sourced from `staging.odoo_res_partner.mobile`. Source precision unknown; safe default varchar(255). |
| `LanguageCode` | SCD1 | varchar(255) | varchar(255) | Language code (e.g., 'en_US'). Sourced from `staging.odoo_res_partner.lang`. Source precision unknown; safe default varchar(255). |
| `Timezone` | SCD1 | varchar(255) | varchar(255) | Partner timezone (e.g., 'UTC'). Sourced from `staging.odoo_res_partner.tz`. Source precision unknown; safe default varchar(255). |
| `Website` | SCD1 | varchar(255) | varchar(255) | Website URL. Sourced from `staging.odoo_res_partner.website`. Source precision unknown; safe default varchar(255). |
| `JobTitle` | SCD1 | varchar(255) | varchar(255) | Job title / function. Sourced from `staging.odoo_res_partner.function`. Source precision unknown; safe default varchar(255). |
| `CompanyName` | SCD1 | varchar(255) | varchar(255) | Display company name. Sourced from `staging.odoo_res_partner.company_name`. Source precision unknown; safe default varchar(255). |
| `CommercialCompanyName` | SCD1 | varchar(255) | varchar(255) | Commercial legal company name. Sourced from `staging.odoo_res_partner.commercial_company_name`. Source precision unknown; safe default varchar(255). |
| `IsCompany` | SCD1 | boolean | boolean | Indicates if the partner is a company entity. Sourced from `staging.odoo_res_partner.is_company`. |
| `IsEmployee` | SCD1 | boolean | boolean | Indicates if the partner is an internal employee. Sourced from `staging.odoo_res_partner.employee`. |
| `IsCustomer` | SCD1 | boolean | boolean | Flag indicating whether partner acts as a customer (`customer_rank > 0`). Sourced from `staging.odoo_res_partner.customer_rank`. |
| `IsSupplier` | SCD1 | boolean | boolean | Flag indicating whether partner acts as a supplier/vendor (`supplier_rank > 0`). Sourced from `staging.odoo_res_partner.supplier_rank`. |
| `CustomerRank` | SCD1 | integer | integer | Customer tier or interaction frequency rank. Sourced from `staging.odoo_res_partner.customer_rank`. |
| `SupplierRank` | SCD1 | integer | integer | Supplier tier or interaction frequency rank. Sourced from `staging.odoo_res_partner.supplier_rank`. |
| `ParentPartnerID` | SCD1 | integer | integer | Business key of the parent partner entity for organizational hierarchies. Sourced from `staging.odoo_res_partner.parent_id`. |
| `CommercialPartnerID` | SCD1 | integer | integer | Business key of the main commercial partner entity for legal/invoicing purposes. Sourced from `staging.odoo_res_partner.commercial_partner_id`. |
| `StateID` | SCD1 | integer | integer | Identifier of state/province. Sourced from `staging.odoo_res_partner.state_id`. |
| `CountryID` | SCD1 | integer | integer | Identifier of country. Sourced from `staging.odoo_res_partner.country_id`. |
| `IndustryID` | SCD1 | integer | integer | Identifier of industry sector. Sourced from `staging.odoo_res_partner.industry_id`. |
| `CompanyID` | SCD1 | integer | integer | Identifier of multi-company organizational context. Sourced from `staging.odoo_res_partner.company_id`. |
| `PartnerLatitude` | SCD1 | numeric(18,6) | numeric(18,6) | Geographic latitude coordinates. Sourced from `staging.odoo_res_partner.partner_latitude`. Source precision unknown; safe default numeric(18,6). |
| `PartnerLongitude` | SCD1 | numeric(18,6) | numeric(18,6) | Geographic longitude coordinates. Sourced from `staging.odoo_res_partner.partner_longitude`. Source precision unknown; safe default numeric(18,6). |
| `PickingWarn` | SCD1 | varchar(255) | varchar(255) | Operational warning category for stock picking operations. Sourced from `staging.odoo_res_partner.picking_warn`. Source precision unknown; safe default varchar(255). |
| `InvoiceWarn` | SCD1 | varchar(255) | varchar(255) | Operational warning category for invoicing operations. Sourced from `staging.odoo_res_partner.invoice_warn`. Source precision unknown; safe default varchar(255). |
| `DebitLimit` | SCD1 | numeric(18,2) | numeric(18,2) | Debit limit allocated to the partner. Sourced from `staging.odoo_res_partner.debit_limit`. Source precision unknown; safe default numeric(18,2). |
| `IsActive` | SCD1 | boolean | boolean | Soft-delete / active status indicator. Sourced from `staging.odoo_res_partner.active`. |
| `SourceCreatedAt` | SCD1 | timestamp | timestamp | Record creation timestamp in source system. Sourced from `staging.odoo_res_partner.create_date`. |
| `SourceUpdatedAt` | SCD1 | timestamp | timestamp | Last update timestamp in source system. Sourced from `staging.odoo_res_partner.write_date`. |

## Transformation Logic
1. **Source Selection**: Read all records from [staging.odoo_res_partner](../Staging/staging.odoo_res_partner.md).
2. **Surrogate Key Assignment**: Generate an integer surrogate key `PartnerKey` monotonically or via warehouse sequence/identity generation.
3. **Derived Attributes**:
   - `IsCustomer`: Evaluated as `CASE WHEN customer_rank > 0 THEN TRUE ELSE FALSE END`.
   - `IsSupplier`: Evaluated as `CASE WHEN supplier_rank > 0 THEN TRUE ELSE FALSE END`.
4. **SCD Type 1 Handling**: Overwrite attributes in place upon change matching on the natural key `staging.odoo_res_partner.id`.

## Lineage
- Reads from: [staging.odoo_res_partner](../Staging/staging.odoo_res_partner.md)

## Notes
- `StateID`, `CountryID`, `IndustryID`, and `CompanyID` are retained as integer identifiers directly from `staging.odoo_res_partner` to allow future snowflake or outrigger joins once those lookup tables are modeled.
- `ParentPartnerID` and `CommercialPartnerID` capture the partner hierarchy and commercial relationship directly as natural keys.