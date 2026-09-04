# odoo_stock_traceability_report

## Source system
This table originates from Odoo ERP, as indicated by the naming convention `odoo_stock_traceability_report` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the inventory management and supply chain traceability process. It tracks the movement and provenance of stock items, likely capturing the audit trail for stock moves or inventory adjustments within the Odoo warehouse management module.

## Description
One row in this table represents a single audit or traceability event record within the Odoo stock management system. It serves as a raw landed copy of the Odoo `stock.traceability.report` model, capturing metadata about record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.stock_traceability_report_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for modifier tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The table contains audit metadata; ensure user IDs are joined against the appropriate `res_users` dimension for human-readable names.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table represents a raw staging layer; it may contain multiple versions of a record if the source system performs updates, or it may be a snapshot depending on the ingestion pipeline configuration.
- No PII is immediately evident in these columns, but downstream joins to user tables may expose sensitive employee information.