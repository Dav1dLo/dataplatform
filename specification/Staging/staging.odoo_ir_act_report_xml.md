# odoo_ir_act_report_xml

## Source system
This table originates from Odoo ERP, specifically the `ir_act_report_xml` model within the Odoo framework's internal registry. The presence of Odoo-specific naming conventions such as `create_uid`, `write_uid`, `JSONB` fields for translatable strings, and the `ir_` prefix strongly indicates a direct extraction from an Odoo PostgreSQL database.

## Functional process 
This table supports the Odoo Reporting Engine configuration process. It defines the metadata for report actions, including how reports are generated, which models they are bound to, and their associated paper formats or file paths. It is critical for the "Print-to-PDF" and document generation workflows within the ERP.

## Description
One row in this table represents a single report action definition within the Odoo system. It captures the configuration settings, such as the report type, the target model, and the file path for the report template. This table serves as a raw landed copy of the Odoo system's report action registry, used to track how and where reports are rendered across the platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.ir_actions_id_seq` sequence. |
| binding_model_id | INTEGER | true | Foreign key to the model this report is bound to | Links to `ir_model`. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res_users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res_users`. |
| type | VARCHAR | false | Action type identifier | Usually 'ir.actions.report'. |
| path | VARCHAR | true | URL path for the report | Used for web-based report access. |
| binding_type | VARCHAR | false | Binding category | Defines if the report appears in the 'Print' menu. |
| binding_view_types | VARCHAR | true | View types where the report is available | Comma-separated list (e.g., 'list,form'). |
| name | JSONB | false | Display name of the report | Translatable field. |
| help | JSONB | true | Help text for the report action | Translatable field. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| paperformat_id | INTEGER | true | Foreign key to paper format | Links to `report_paperformat`. |
| model | VARCHAR | false | Target Odoo model name | The business object the report acts upon. |
| report_type | VARCHAR | false | Format of the report | e.g., 'qweb-pdf', 'qweb-html'. |
| report_name | VARCHAR | false | Internal report name | Used for template lookup. |
| report_file | VARCHAR | true | Path to the report template file | Often a QWeb template path. |
| attachment | VARCHAR | true | Attachment storage path | Used for cached report files. |
| domain | VARCHAR | true | Filter domain for report availability | Odoo domain expression. |
| print_report_name | JSONB | true | Expression for generated filename | Translatable field. |
| multi | BOOLEAN | true | Whether the report supports multi-selection | If true, allows printing for multiple records. |
| attachment_use | BOOLEAN | true | Whether to use cached attachments | If true, saves report to database after first print. |
| is_invoice_report | BOOLEAN | true | Flag for invoice-specific reports | Used for specialized invoice processing logic. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `binding_model_id` → `ir_model.id` (Inferred from Odoo naming convention).
    - `create_uid` → `res_users.id` (Standard Odoo audit field).
    - `write_uid` → `res_users.id` (Standard Odoo audit field).
    - `paperformat_id` → `report_paperformat.id` (Links to report layout settings).
- **Natural keys (inferred):** `report_name` (In Odoo, the internal report name is typically unique).

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with `res_users` to identify specific personnel.
- **Timestamps:** Timestamps are stored in the Odoo system's native format, typically UTC.
- **JSONB Fields:** Fields like `name`, `help`, and `print_report_name` are `JSONB`. Query writers must use the `->>` operator to extract text values (e.g., `name->>'en_US'`).
- **Soft Deletes:** This table does not implement a soft-delete flag; records are typically hard-deleted in the source Odoo system.
- **Data Integrity:** `binding_view_types` is a string representation of a list; parsing may be required for filtering.