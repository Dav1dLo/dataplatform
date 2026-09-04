# odoo_account_report_column

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention (e.g., `create_uid`, `write_uid`, `create_date`, `write_date`) and the presence of `JSONB` fields for localized names are characteristic of Odoo's PostgreSQL-based ORM layer.

## Functional process 
This table supports the financial reporting engine within Odoo. It defines the structure and configuration of columns within custom financial reports, determining how specific expressions are rendered, whether figures are sortable, and how zero values should be handled in report outputs.

## Description
One row represents a single column configuration within a specific financial report definition. It acts as a raw landed copy of the Odoo `account.report.column` model, capturing the metadata required to render report columns in the user interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Determines column positioning in reports. |
| report_id | INTEGER | true | Foreign key to parent report | Links to the report definition. |
| custom_audit_action_id | INTEGER | true | Audit action reference | Links to custom audit configurations. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| expression_label | VARCHAR | false | Expression identifier | The label used to map data to this column. |
| figure_type | VARCHAR | false | Data type of the figure | Defines the format (e.g., 'float', 'monetary'). |
| name | JSONB | false | Column display name | Multilingual label stored as a JSON object. |
| sortable | BOOLEAN | true | Sortability flag | Indicates if the column can be sorted in the UI. |
| blank_if_zero | BOOLEAN | true | Zero-suppression flag | If true, hides the value if it equals zero. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `report_id` → `staging.odoo_account_report.id` (Inferred from Odoo naming conventions linking columns to parent reports).
    - `create_uid` → `staging.odoo_res_users.id` (Standard Odoo audit field pattern).
    - `write_uid` → `staging.odoo_res_users.id` (Standard Odoo audit field pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user tables to resolve PII (names/emails).
- **Timestamps:** Assumed to be in UTC, consistent with Odoo's internal storage standard.
- **JSONB:** The `name` column contains localized strings; ensure your downstream transformation layer handles JSON extraction (e.g., `name->>'en_US'`).
- **Soft Deletes:** Odoo typically does not use soft-delete flags in this model; records are usually physically deleted from the source.
- **Data Integrity:** As a staging table, this represents a direct dump; expect potential nulls in foreign key fields if the parent records were deleted or not ingested.