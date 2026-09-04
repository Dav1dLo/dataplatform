# odoo_product_pricelist

## Source system
This table originates from Odoo ERP, an open-source business management software. The naming convention (e.g., `create_uid`, `write_uid`, `JSONB` for translatable fields) and the specific sequence-based primary key generation are characteristic of Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the pricing and sales management process by defining product pricelists. It acts as the header entity for price rules, allowing the business to manage multiple pricing strategies (e.g., wholesale, retail, seasonal discounts) associated with specific currencies and companies.

## Description
One row represents a single pricelist configuration, which defines the currency and organizational scope for a set of pricing rules. This is a raw landed copy of the Odoo `product.pricelist` model, intended to serve as the base for downstream pricing dimensions in the data warehouse.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.product_pricelist_id_seq` for generation. |
| sequence | INTEGER | true | Display order | Used for sorting pricelists in the UI. |
| currency_id | INTEGER | false | Foreign key to currency | Links to the currency used for this pricelist. |
| company_id | INTEGER | true | Foreign key to company | Links to the owning company; null implies global access. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the record. |
| name | JSONB | false | Pricelist name | Odoo stores multi-language names in JSONB format. |
| active | BOOLEAN | true | Soft-delete flag | If false, the pricelist is hidden from selection. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `currency_id` → `res_currency.id` (Standard Odoo relation for currency definitions).
    - `company_id` → `res_company.id` (Standard Odoo relation for multi-company scoping).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo relation for system users).
- **Natural keys (inferred):** Not confidently inferable. While `name` is descriptive, Odoo often allows duplicate names for pricelists; no unique business key is explicitly defined.

## Caveats for downstream consumers

- **PII/Sensitivity:** Contains no direct PII, but `create_uid` and `write_uid` link to internal user identities.
- **Timestamps:** All `TIMESTAMP` columns are stored in UTC.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing audit or historical analysis.
- **JSONB:** The `name` column is a `JSONB` object; use `name->>'en_US'` or similar syntax to extract specific language values in downstream transformations.