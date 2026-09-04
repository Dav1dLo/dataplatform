# odoo_ir_demo

## Source system
This table originates from an Odoo ERP system. The naming convention `ir_` (Internal Resource) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal metadata tables used for tracking record lifecycle and user attribution.

## Functional process 
This table supports the internal audit and record-tracking process within the Odoo framework. It tracks which user created or last modified a specific record and when those actions occurred, facilitating traceability across the ERP's administrative and operational modules.

## Description
One row in this table represents a single internal resource entry within the Odoo system. It serves as a raw landed copy of the system's metadata, capturing the primary identifier and the audit trail for record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Primary key of the record | Sequence-generated; unique identifier. |
| create_uid | INTEGER | true | ID of the user who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC; Odoo standard format. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC; Odoo standard format. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Guessed based on Odoo naming conventions for user-tracking columns.
    - `write_uid` → `res_users.id`: Guessed based on Odoo naming conventions for user-tracking columns.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** `create_uid` and `write_uid` link to user identities; ensure access is restricted if user names or roles are considered PII.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This is a raw staging table; it likely contains the full history of records as they exist in the source, including potential soft-deleted records if the source system implements them via flags not present in this specific schema.
- **Audit:** The `write_date` should be used for incremental loading logic, as it reflects the most recent change to the record.