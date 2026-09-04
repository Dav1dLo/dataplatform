# odoo_res_config

## Source system
This table originates from Odoo ERP. The naming convention `res_config` and the presence of audit columns like `create_uid` and `write_uid` are characteristic of the Odoo `res.config` model, which manages system-wide configuration settings.

## Functional process 
This table supports the system configuration and administrative settings management process. It tracks the audit trail of who modified system parameters and when, serving as the base for tracking configuration changes across the Odoo environment.

## Description
One row in this table represents a single configuration record or a snapshot of system settings within the Odoo instance. As a staging table, it provides a raw, landed copy of the Odoo `res_config` table, intended for use in downstream transformation pipelines to build configuration dimensions or audit logs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.res_config_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res_users` table. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `staging.res_users.id` (Guess: standard Odoo audit pattern for creator).
    - `write_uid` → `staging.res_users.id` (Guess: standard Odoo audit pattern for modifier).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user tables to resolve PII (names/emails).
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag (e.g., `active`), but Odoo often uses such columns; check for missing records if filtering by `active = true` in upstream systems.
- **Data Grain:** This is a raw staging table; expect potential duplicates or multiple versions of configuration records if the ingestion process performs full dumps.