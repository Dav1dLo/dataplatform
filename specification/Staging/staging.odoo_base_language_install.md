# odoo_base_language_install

## Source system
This table originates from Odoo ERP. The naming convention `base_language_install` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal module management and localization framework.

## Functional process 
This table supports the localization and internationalization process within the Odoo platform. It tracks which language packs have been installed or updated in the system, allowing the application to manage multi-language user interfaces and document translations.

## Description
One row represents a single language installation record within the Odoo environment. It acts as a raw landed copy of the system's language configuration state, capturing metadata about who performed the installation and when the record was last modified.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.base_language_install_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| overwrite | BOOLEAN | true | Flag to overwrite existing translations | If true, existing translations are replaced during install. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking creator identity).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking modifier identity).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Sensitive Data:** No PII is present in this table; it contains only system configuration and audit metadata.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD behavior.
- **Data Completeness:** As a staging table, ensure that downstream models handle potential nulls in `create_uid` and `write_uid` if the user account has been purged from the source system.