# odoo_sale_order_discount

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_uid`, `write_date`) and the specific schema structure are characteristic of Odoo's internal ORM-managed tables, which track record creation and modification metadata alongside business-specific fields.

## Functional process 
This table supports the sales order management process, specifically tracking manual or automated discounts applied to sales orders. It captures the configuration of price adjustments, allowing the system to distinguish between percentage-based and fixed-amount discounts applied to a specific order.

## Description
One row in this table represents a single discount record associated with a specific sales order. It acts as a raw landed copy of the Odoo `sale.order.discount` model, capturing the grain of one discount entry per sales order. Its purpose in the staging layer is to provide a persistent, immutable record of discount configurations before they are joined or aggregated into downstream sales fact tables.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.sale_order_discount_id_seq`. |
| sale_order_id | INTEGER | false | Foreign key to the parent sales order | Links to the `sale_order` table. |
| create_uid | INTEGER | true | ID of the user who created the record | References the Odoo `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the Odoo `res_users` table. |
| discount_type | VARCHAR | true | Categorization of the discount | Likely values include 'fixed' or 'percentage'. |
| discount_amount | NUMERIC | true | Fixed monetary discount value | Unit depends on the currency of the associated sales order. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |
| discount_percentage | DOUBLE PRECISION | true | Discount rate as a percentage | Value typically ranges from 0.0 to 100.0. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sale_order_id` → `staging.sale_order.id`: This column links the discount record to its parent sales order.
    - `create_uid` → `staging.res_users.id`: Tracks the creator of the record (guess).
    - `write_uid` → `staging.res_users.id`: Tracks the last modifier of the record (guess).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table represents a raw landing; it is unknown if Odoo's internal "active" flag logic is applied here. Assume all rows are current unless a specific `active` column is present in future schema updates.
- **Data Precision:** `discount_amount` is `NUMERIC` (precision/scale not specified in source), which is appropriate for currency. `discount_percentage` is `DOUBLE PRECISION`, which may introduce floating-point rounding artifacts; cast to `NUMERIC` for financial reporting.
- **Nullability:** Many fields are nullable; ensure your joins handle potential missing `discount_type` or `discount_amount` values if the discount record is incomplete.