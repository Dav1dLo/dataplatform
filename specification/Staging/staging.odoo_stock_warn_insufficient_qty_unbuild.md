# odoo_stock_warn_insufficient_qty_unbuild

## Source system
This table originates from Odoo ERP, specifically the Inventory/Manufacturing module. The naming convention `stock_warn_insufficient_qty_unbuild` and the presence of columns like `product_id`, `location_id`, and `unbuild_id` are characteristic of Odoo's internal data structures for handling manufacturing unbuild operations.

## Functional process 
This table supports the manufacturing "unbuild" process by capturing warning logs or transient data when an unbuild operation attempts to process a quantity that exceeds the available stock in a specific location. It acts as a validation or notification buffer during the unbuild workflow.

## Description
One row in this table represents a single instance of an insufficient quantity warning triggered during an unbuild operation. It records the product, the location, the associated unbuild order, and the specific quantity that caused the validation failure. This is a raw landed copy of the Odoo staging table, intended for auditing or troubleshooting inventory discrepancies.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.stock_warn_insufficient_qty_unbuild_id_seq`. |
| product_id | INTEGER | false | Foreign key to product | References the product involved in the unbuild. |
| location_id | INTEGER | false | Foreign key to location | References the inventory location where stock was checked. |
| unbuild_id | INTEGER | true | Foreign key to unbuild order | References the specific unbuild operation that triggered the warning. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| product_uom_name | VARCHAR | false | Unit of measure label | The human-readable name of the product's unit of measure. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of when the warning was generated. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to this record. |
| quantity | DOUBLE PRECISION | false | Insufficient quantity | The amount that triggered the insufficient stock warning. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Guess: standard Odoo product reference)
    - `location_id` → `stock_location.id` (Guess: standard Odoo inventory location reference)
    - `unbuild_id` → `mrp_unbuild.id` (Guess: standard Odoo manufacturing unbuild reference)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against an employee or user table to resolve names.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's default database storage behavior.
- **Data Lifecycle:** This table represents a "warning" state; rows may be transient or purged depending on Odoo's internal cleanup routines for wizard/transient models.
- **Precision:** `quantity` is stored as `DOUBLE PRECISION`; ensure appropriate rounding is applied if aggregating for financial or inventory reporting.