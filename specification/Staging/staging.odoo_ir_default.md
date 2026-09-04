# odoo_ir_default

## Source system
This table originates from Odoo ERP, specifically the `ir_default` table within the Odoo framework's internal registry. It is used to manage default values for fields across the application, typically populated by the Odoo ORM when users set "default" values for specific fields in the UI.

## Functional process 
This table supports the application configuration and user preference management process. It stores system-wide or user-specific default values for fields, allowing the Odoo framework to pre-populate forms or filter data based on stored `json_value` configurations linked to specific `field_id` and `company_id` contexts.

## Description
One row in this table represents a single default value configuration for a specific field within the Odoo system. It acts as a raw landing copy of the Odoo `ir_default` table, capturing the state of field defaults at the grain of one row per default setting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.ir_default_id_seq`. |
| field_id | INTEGER | false | Reference to the field definition | Links to `ir_model_fields`. |
| user_id | INTEGER | true | User ID for user-specific defaults | Null if the default is global. |
| company_id | INTEGER | true | Company ID for multi-company scoping | Null if the default applies to all companies. |
| create_uid | INTEGER | true | ID of the user who created the record | Audit field. |
| write_uid | INTEGER | true | ID of the user who last modified the record | Audit field. |
| condition | VARCHAR | true | JSON condition string | Defines logic for when the default applies. |
| json_value | VARCHAR | false | The default value stored as JSON | The actual value to be applied. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `field_id` → `ir_model_fields.id` (Inferred from Odoo naming conventions).
    - `user_id` → `res_users.id` (Inferred from Odoo naming conventions).
    - `company_id` → `res_company.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs and potentially sensitive configuration values in `json_value`; ensure access is restricted.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with standard Odoo database practices.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are current unless otherwise specified by the source system's logic.
- **Data Format:** The `json_value` column contains serialized data; downstream consumers will need to use `jsonb` parsing functions (e.g., `jsonb_extract_path_text`) if the data is cast to `jsonb` during transformation.