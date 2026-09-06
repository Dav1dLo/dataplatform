# Fully Qualified Name: dwh.DimVendor

## Description
This dimension table represents vendors from whom the organization procures goods or services. It captures key attributes of the vendor entity, including contact details, classification, and operational status, derived from the Odoo partner management system.

## Grain
One row per unique vendor.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations |
| --- | --- | --- | --- | --- |
| VendorKey | SK | integer | - | System-generated surrogate key. |
| VendorBK | BK | integer | - | Pass-through from staging.odoo_res_partner.id. |
| VendorName | SCD1 | varchar | 255 | Pass-through from staging.odoo_res_partner.name. |
| VendorVAT | SCD1 | varchar | 64 | Pass-through from staging.odoo_res_partner.vat. |
| VendorCity | SCD1 | varchar | 128 | Pass-through from staging.odoo_res_partner.city. |
| VendorCountry | SCD1 | varchar | 128 | Pass-through from staging.odoo_res_partner.country_id (resolved to name). |
| IsActive | SCD1 | boolean | - | Pass-through from staging.odoo_res_partner.active. |
| SupplierRank | SCD1 | integer | - | Pass-through from staging.odoo_res_partner.supplier_rank. |
| CreatedDate | TC | timestamp | - | Pass-through from staging.odoo_res_partner.create_date. |

## Transformation Logic
The table is populated by selecting records from `staging.odoo_res_partner` where `supplier_rank` > 0, indicating the entity is a vendor. The `VendorBK` is mapped directly from the source `id`. Attributes are standardized to reflect the current state of the vendor (SCD Type 1).

## Lineage
- Reads from: [staging.odoo_res_partner](../Staging/odoo_res_partner.md)

## Notes
- The `SupplierRank` attribute is used to filter for entities that have acted as suppliers.
- `VendorCountry` requires a join to a country reference table (not yet modeled) or a lookup; currently, this assumes the availability of the country name associated with the `country_id`.
- The `active` flag is preserved to allow for filtering out archived vendors in downstream reporting.