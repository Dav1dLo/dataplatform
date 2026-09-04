# odoo_product_combo

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_uid`, `company_id`) and the use of sequence-based primary keys are characteristic of the Odoo framework's underlying PostgreSQL database schema.

## Functional process 
This table supports the product configuration and bundling process, likely managing "combo" products where multiple items are grouped together for sale. It tracks the metadata and sequencing of these product combinations within the Odoo inventory or sales modules.

## Description
One row represents a single product combo definition within the Odoo system. This is a raw landed copy of the Odoo `product.combo` model, capturing the administrative metadata and display sequence for product bundles.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.product_combo_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to determine the sort order of combos in the UI. |
| company_id | INTEGER | true | Foreign key to company | Links the combo to a specific Odoo company entity. |
| create_uid | INTEGER | true | Creator user ID | References the user who initially created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| name | VARCHAR | false | Combo display name | The descriptive label for the product combination. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application layer. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application layer. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `create_uid` → `res_users.id` (Standard Odoo audit trail).
    - `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft deletes; records are usually physically deleted from the source table.
- **PII:** This table contains administrative metadata and is unlikely to contain PII, though `create_uid` and `write_uid` link to user identities.
- **Data Integrity:** As a staging table, this may contain duplicates or partial updates if the ingestion process is not idempotent; ensure you filter by the latest `write_date` if necessary.