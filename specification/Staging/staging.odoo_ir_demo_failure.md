# odoo_ir_demo_failure

## Source system
This table originates from Odoo ERP. The naming convention `ir_demo_failure` (Internal Resource demo failure) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal metadata tables used to track module installation or demonstration data loading errors.

## Functional process 
This table supports the system administration and module management process within Odoo. It tracks failures encountered during the loading or execution of demonstration data for specific modules, allowing administrators to debug installation issues or failed data imports.

## Description
One row in this table represents a single recorded failure event associated with a specific Odoo module or wizard process. As a staging table, it serves as a raw, direct copy of the Odoo internal database table, capturing the error message and the audit trail of who created or modified the failure record.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| module_id | INTEGER | false | Foreign key to the module | References the module that triggered the demo failure. |
| wizard_id | INTEGER | true | Foreign key to the wizard | References the specific wizard process that failed. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| error | VARCHAR | true | Error description | The text of the failure message encountered. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the failure was recorded. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification to this record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `module_id` → `ir_module_module.id` (Guess: Standard Odoo pattern for linking to module definitions).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo pattern for user audit trails).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo pattern for user audit trails).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `error` column may contain stack traces or database paths that could be considered sensitive; ensure appropriate masking if exposing to non-technical users.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo; verify against the source system configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all rows represent active or historical failure records.
- **Data Quality:** As a raw staging table, `error` messages may be unstructured and vary significantly in length and content.