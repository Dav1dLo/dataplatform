# odoo_stock_inventory_conflict

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_inventory_conflict` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables, specifically within the Inventory (Stock) module.

## Functional process 
This table supports inventory reconciliation and conflict resolution processes. It tracks discrepancies identified during stock counts or inventory adjustments, likely capturing instances where system-recorded stock levels conflict with physical counts or concurrent transaction updates.

## Description
One row represents a single inventory conflict event or record within the Odoo stock management module. It serves as a raw landing copy of the Odoo database table, capturing the audit trail for when a conflict record was created or last modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.stock_inventory_conflict_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: Standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **PII/Sensitive Data:** While this table contains user IDs, it does not contain direct PII (like emails or names) unless joined with user metadata tables.
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** Odoo tables typically do not use soft-delete flags; if a record is deleted in the source, it may disappear from this staging table upon the next full refresh.
- **Data Completeness:** As a staging table, ensure that the ingestion process captures the full history if the source system performs hard deletes.