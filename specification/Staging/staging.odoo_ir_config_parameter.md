# odoo_ir_config_parameter

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention `ir_config_parameter` is a standard internal Odoo table name used to store system-wide configuration settings and parameters (the "ir" prefix stands for "Internal Resources").

## Functional process 
This table supports the application configuration and environment management process. It stores global key-value pairs that dictate system behavior, such as API endpoints, feature flags, or system-wide settings that are accessed by the Odoo framework at runtime.

## Description
One row represents a single configuration parameter defined within the Odoo system. This is a raw landing table containing the current state of system settings, used to track how the application environment is configured across different modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| create_uid | INTEGER | true | User ID who created the parameter | References the user who initially defined this setting. |
| write_uid | INTEGER | true | User ID who last updated the parameter | References the user who last modified this setting. |
| key | VARCHAR | false | Parameter name | The unique identifier for the configuration setting. |
| value | TEXT | false | Parameter value | The actual configuration value associated with the key. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the parameter was first created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the parameter was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Likely references the user table in Odoo).
    - `write_uid` → `res_users.id` (Likely references the user table in Odoo).
- **Natural keys (inferred):** 
    - `key` (In Odoo, the `key` column is typically unique and serves as the business identifier for the configuration parameter).

## Caveats for downstream consumers

- **Sensitive Data:** The `value` column may contain sensitive information such as API keys, secret tokens, or internal system URLs. Ensure this column is masked or restricted in downstream reporting layers.
- **Timestamps:** Timestamps are stored in the database's local time (typically UTC in Odoo deployments), but verify against the source system's `timezone` configuration.
- **Data Integrity:** As a staging table, this represents a snapshot. There is no explicit soft-delete flag; updates to existing keys will overwrite the `value` and update the `write_date`.
- **Precision:** `VARCHAR` and `TEXT` lengths are not explicitly constrained in the source metadata; assume standard Odoo defaults (usually 255 for keys, unlimited for values).