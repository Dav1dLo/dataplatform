# odoo_change_password_own

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the specific table name structure are characteristic of Odoo's internal ORM-managed tables used for tracking user-initiated password change requests.

## Functional process 
This table supports the user account security and authentication management process. It logs the transient state of password change requests initiated by users within the Odoo platform, capturing the proposed new credentials before they are processed and committed to the core user authentication tables.

## Description
One row in this table represents a single password change request event initiated by a user. It serves as a raw landing staging entity, capturing the state of the password change attempt at a specific point in time. The grain of the table is one row per password change request attempt.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.change_password_own_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the Odoo `res_users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the Odoo `res_users` table. |
| new_password | VARCHAR | true | The proposed new password | Sensitive PII/Security data; likely stored as a hash or plaintext depending on Odoo version. |
| confirm_password | VARCHAR | true | The confirmation of the new password | Sensitive PII/Security data. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit field for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Security/PII:** This table contains `new_password` and `confirm_password`. These columns must be masked or excluded from any non-privileged reporting environments.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** As a staging table for password changes, this may contain transient data; verify if rows are purged after the password change is successfully committed to the core user table.
- **Type Precision:** `VARCHAR` lengths are not explicitly defined in the source; assume standard Odoo field limits (typically 255 or unlimited depending on the specific Odoo version).