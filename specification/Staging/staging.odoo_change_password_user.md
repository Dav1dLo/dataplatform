# odoo_change_password_user

## Source system
This table originates from Odoo ERP, as indicated by the naming convention `odoo_change_password_user` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`). It represents a transient record created during the password reset wizard process within the Odoo framework.

## Functional process 
This table supports the user account management and security process, specifically tracking the password change wizard workflow. It captures the association between a specific password reset session (the wizard) and the target user account, storing the requested new password and the user's login identifier during the transaction.

## Description
One row in this table represents a single entry within a password change wizard session, linking a specific user to a pending password update. It serves as a raw landed staging record of the Odoo `change.password.user` model, capturing the state of the password reset request before it is committed to the core user authentication system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo ORM. |
| wizard_id | INTEGER | false | Foreign key to the parent wizard | Links to the `change.password.wizard` record. |
| user_id | INTEGER | false | Foreign key to the target user | Links to the `res.users` table. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the record creation. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| user_login | VARCHAR | true | User login identifier | The username/email associated with the user at the time of the request. |
| new_passwd | VARCHAR | true | Encrypted/Plain password | Sensitive data; contains the new password value. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the ingestion job; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded by the ingestion job; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `staging.odoo_change_password_wizard.id` (Inferred from Odoo naming patterns for wizard models).
    - `user_id` → `staging.odoo_res_users.id` (Standard Odoo reference to the user table).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `new_passwd` column contains sensitive authentication information and should be masked or excluded from non-privileged reporting.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This table represents a transient wizard state; records may be ephemeral and purged by Odoo after the password change process completes.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream consumers should account for variable-length strings.