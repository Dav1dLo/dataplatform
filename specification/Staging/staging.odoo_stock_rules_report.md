# odoo_stock_rules_report

## Source system
This table originates from Odoo ERP, specifically the inventory or supply chain management module. The naming convention `stock_rules_report` and the presence of `product_id` and `product_tmpl_id` are characteristic of Odoo's internal reporting tables used to track stock replenishment rules and product configuration.

## Functional process 
This table supports the inventory replenishment and product configuration process. It tracks the reporting state of stock rules associated with specific products and product templates, allowing the system to audit how replenishment logic is applied across different product variants.

## Description
One row in this table represents a snapshot or record of a stock rule configuration for a specific product or product template. It serves as a raw landed copy of Odoo's internal reporting data, capturing the state of product-level stock rules at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.stock_rules_report_id_seq`. |
| product_id | INTEGER | false | Foreign key to the product variant | Identifies the specific product variant. |
| product_tmpl_id | INTEGER | false | Foreign key to the product template | Identifies the base product template. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the rule report. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the record. |
| product_has_variants | BOOLEAN | false | Flag for variant existence | Indicates if the product template has multiple variants. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; verify against Odoo server settings. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Assumed UTC; verify against Odoo server settings. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `staging.product_product.id` (Guess: standard Odoo product reference).
    - `product_tmpl_id` → `staging.product_template.id` (Guess: standard Odoo template reference).
    - `create_uid` / `write_uid` → `staging.res_users.id` (Guess: standard Odoo user reference).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored as `TIMESTAMP` without timezone; assume UTC unless Odoo configuration specifies otherwise.
- **Data Freshness:** This is a staging table; it may contain duplicate records if the ingestion process performs full loads rather than incremental updates.
- **Sensitivity:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names, but contains no direct PII.
- **Soft Deletes:** Odoo typically uses `active` flags for soft deletes; check if an `active` column exists in the source system if you are missing expected records.