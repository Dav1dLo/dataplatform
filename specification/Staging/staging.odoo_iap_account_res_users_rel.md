# odoo_iap_account_res_users_rel

## Source system
Odoo ERP. The naming convention `res_users` and `iap_account` is characteristic of the Odoo framework, where `res_users` represents the core user management table and `iap_account` refers to In-App Purchase account configurations.

## Functional process 
This table supports the user-to-account access management process for Odoo In-App Purchase services. It functions as a junction table to manage the many-to-many relationship between system users and IAP accounts, ensuring that specific users are authorized to consume credits or manage settings for linked IAP services.

## Description
This table represents a join record between an Odoo system user and an IAP account. It is a raw landing copy of the association table used by the Odoo ORM to maintain relational integrity between the `res.users` and `iap.account` models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| iap_account_id | INTEGER | false | Foreign key to the IAP account | References the primary key of the IAP account table. |
| res_users_id | INTEGER | false | Foreign key to the system user | References the primary key of the `res_users` table. |

## Keys

- **Primary key (inferred):** Composite key of (`iap_account_id`, `res_users_id`).
- **Foreign keys (inferred):** 
    - `iap_account_id` → `iap_account.id`: Links to the specific IAP account configuration.
    - `res_users_id` → `res_users.id`: Links to the specific system user profile.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; it contains no descriptive attributes, only identifiers.
- Ensure joins to `res_users` and `iap_account` are handled as inner joins if you only require active associations.
- As a staging table, this reflects the raw state of the Odoo database; verify if the source system performs hard deletes on this table or if historical associations persist.