# Fully Qualified Name: dwh.DimProduct

## Description
This dimension table represents the master catalog of products and their specific variants, consolidating core product definitions from templates and specific variant details. It provides the necessary attributes to categorize, identify, and describe products for procurement and inventory analysis.

## Grain
One row per product variant.

## SQL Dialect
PostgreSQL

## Columns
| Column Name | Column Type | Data Type | Precision / Sizing | Column-Level Transformations |
| --- | --- | --- | --- | --- |
| ProductKey | SK | integer | integer | System-generated surrogate key. |
| ProductBK | BK | integer | integer | Source `staging.odoo_product_product.id`. |
| ProductSKU | SCD1 | varchar(255) | varchar(255) | Source `staging.odoo_product_product.default_code` (COALESCE with `staging.odoo_product_template.default_code` if null). |
| ProductName | SCD1 | varchar(1024) | varchar(1024) | Source `staging.odoo_product_template.name` (extracted from JSONB). |
| ProductType | SCD1 | varchar(50) | varchar(50) | Source `staging.odoo_product_template.type`. |
| ProductBarcode | SCD1 | varchar(255) | varchar(255) | Source `staging.odoo_product_product.barcode`. |
| IsActive | SCD1 | boolean | boolean | Source `staging.odoo_product_product.active`. |
| EffectiveDate | TC | timestamp | timestamp | System-generated timestamp of record creation. |
| ExpiryDate | TC | timestamp | timestamp | System-generated timestamp of record expiration. |
| IsCurrent | TC | boolean | boolean | Flag indicating if this is the current record. |
| CreatedDate | TC | timestamp | timestamp | System-generated timestamp of record creation. |

## Transformation Logic
The table is populated by joining `staging.odoo_product_product` with `staging.odoo_product_template` on `product_tmpl_id`. The grain is defined by the product variant (`odoo_product_product.id`). Attributes are sourced from the template for general product information and from the variant table for specific variant details. JSONB fields are extracted to their base types.

## Lineage
- Reads from: [staging.odoo_product_template](../Staging/staging.odoo_product_template.md)
- Reads from: [staging.odoo_product_product](../Staging/staging.odoo_product_product.md)

## Notes
- The `ProductSKU` logic prioritizes the variant-level `default_code`, falling back to the template-level `default_code` if the variant code is null.
- `ProductName` is extracted from the JSONB field in `staging.odoo_product_template`; ensure the extraction logic handles the default language (e.g., 'en_US').
- `IsActive` reflects the status of the variant; if the variant is inactive, it is excluded from active procurement analysis.