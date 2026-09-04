# odoo_base_module_install_review

## Source system
This table originates from an Odoo ERP system. The naming convention `base_module_install_review` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal module management and installation tracking framework.

## Functional process 
This table supports the module lifecycle management process within Odoo. It tracks reviews or status checks associated with the installation of base modules, likely used by system administrators or automated processes to validate or audit module deployments within the ERP environment.

## Description
One row in this table represents a single review or audit record for a specific module installation event. It serves as a raw landing copy of the Odoo `base.module.install.review` model, capturing the audit trail of who performed the review and when it was created or modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.base_module_install_review_id_seq`. |
| module_id | INTEGER | false | Foreign key to the module being reviewed | References the Odoo `ir.module.module` table. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC as per Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC as per Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `ir_module_module.id` (Standard Odoo naming convention for module references).
    - `create_uid` → `res_users.id` (Standard Odoo naming convention for user references).
    - `write_uid` → `res_users.id` (Standard Odoo naming convention for user references).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage format.
- This table contains no PII, but `create_uid` and `write_uid` link to user identity data in other tables.
- There is no explicit soft-delete flag; Odoo typically handles deletions via record removal or active flags in other tables.
- Ensure joins to `res_users` or `ir_module_module` account for potential missing records if the staging layer is not fully synchronized.