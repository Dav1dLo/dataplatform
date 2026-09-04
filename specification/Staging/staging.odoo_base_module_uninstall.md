# odoo_base_module_uninstall

## Source system
This table originates from Odoo ERP. The naming convention `base_module_uninstall` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal module management and metadata tracking system.

## Functional process 
This table supports the module lifecycle management process within the Odoo platform. It tracks the uninstallation requests or configurations for specific modules, likely capturing the state of whether all dependencies or related data should be processed during an uninstallation event.

## Description
One row in this table represents a specific module uninstallation configuration or event record. It serves as a raw landed copy of the Odoo `base.module.uninstall` model, providing a historical audit trail of module removal actions within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.base_module_uninstall_id_seq` for generation. |
| module_id | INTEGER | false | Foreign key to the module being uninstalled | References the `ir.module.module` table. |
| create_uid | INTEGER | true | User ID who initiated the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| show_all | BOOLEAN | true | Flag to display all modules | Likely controls UI visibility during the uninstallation wizard. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC; Odoo standard audit field. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC; Odoo standard audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `staging.ir_module_module.id` (Inferred from Odoo standard naming conventions for module references).
    - `create_uid` → `staging.res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `staging.res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user records; ensure appropriate access controls are in place if joining with user PII.
- **Soft Deletes:** This table represents an audit/configuration log; it does not explicitly implement a soft-delete flag, but records are generally immutable once created in this context.
- **Schema:** This is a raw staging table; ensure that downstream models handle potential duplicates or schema evolution if the source Odoo instance undergoes frequent module updates.