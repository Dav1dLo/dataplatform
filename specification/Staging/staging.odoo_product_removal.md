# odoo_product_removal

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the use of `JSONB` for fields that typically store localized or multi-value attributes in Odoo's ORM.

## Functional process 
This table supports the inventory management and warehouse operations process, specifically tracking the strategies or methods used for product removal (e.g., FIFO, LIFO, or Closest Location) during stock picking or inventory adjustments.

## Description
One row in this table represents a specific product removal strategy configuration defined within the Odoo inventory module. It serves as a raw landed copy of the `product.removal` model, capturing the metadata and method definitions required for warehouse stock movement logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; default uses `staging.product_removal_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| name | JSONB | false | Display name of the removal strategy | Likely contains localized strings; check for language keys. |
| method | JSONB | false | Logic definition for the removal | Stores the technical method identifier or configuration parameters. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming for audit fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming for audit fields).
- **Natural keys (inferred):** Not confidently inferable. While `name` might be unique in some instances, Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **Data format:** The `name` and `method` columns are `JSONB`. Downstream consumers must use PostgreSQL JSON operators (e.g., `->>`) to extract values.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with Odoo's internal storage.
- **Audit columns:** `create_uid` and `write_uid` may be null if the record was created via a system process or migration script rather than a user interface action.
- **Soft deletes:** This table does not appear to have an `active` boolean flag, which is common in Odoo; assume all records are currently active unless otherwise specified by business logic.