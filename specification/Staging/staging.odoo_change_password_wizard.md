# odoo_change_password_wizard

## Source system
This table originates from Odoo ERP. The naming convention `change_password_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's transient model architecture used for UI-driven workflows.

## Functional process 
This table supports the user account management process, specifically the "Change Password" wizard workflow. It tracks the transient state of password reset requests initiated by users or administrators within the Odoo platform.

## Description
One row in this table represents a single instance of a password change request session. It acts as a transient staging record that captures the metadata of a password update attempt. As a staging table, it provides a raw, landed copy of the wizard's state before any potential processing or archival.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.change_password_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References `res_users.id`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Assumed UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Timestamp of last modification | Assumed UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** While this table tracks the wizard session, ensure no plaintext passwords are being logged in associated audit logs or extended fields not captured here.
- **Timestamps:** All timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Transient Nature:** As a "wizard" table, rows may be short-lived or purged frequently by the source system's vacuuming processes; do not rely on this for long-term audit history of password changes.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.