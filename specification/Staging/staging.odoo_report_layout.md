# odoo_report_layout

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention of columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`, which are standard audit fields in the Odoo ORM. The table name `report_layout` corresponds to the internal Odoo model `report.layout` used for managing document report templates.

## Functional process 
This table supports the document reporting and template management process within the ERP. It stores configuration data for report layouts, including references to view definitions and associated visual assets (images or PDF templates) used when generating business documents like invoices or purchase orders.

## Description
One row in this table represents a single report layout configuration record. It acts as a raw landed copy of the Odoo `report.layout` model, capturing the metadata, sequence, and associated file paths for report templates. This table serves as the staging layer entity for downstream reporting and document generation pipelines.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.report_layout_id_seq`. |
| view_id | INTEGER | false | Foreign key to the view definition | References the underlying QWeb view template. |
| sequence | INTEGER | true | Display order index | Used to sort layouts in the UI. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| image | VARCHAR | true | Image file path or binary reference | Path or identifier for the layout preview image. |
| pdf | VARCHAR | true | PDF file path or binary reference | Path or identifier for the PDF template file. |
| name | VARCHAR | true | Layout name | Human-readable label for the report layout. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `view_id → ir_ui_view.id` (Guess: standard Odoo pattern linking layouts to view definitions).
    - `create_uid → res_users.id` (Guess: standard Odoo audit field).
    - `write_uid → res_users.id` (Guess: standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` fields are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume records are hard-deleted if removed from the source.
- **Data Integrity:** The `image` and `pdf` columns contain `VARCHAR` types; verify if these contain file paths or base64-encoded binary strings before processing.
- **Audit Fields:** `create_uid` and `write_uid` are internal Odoo IDs and may not map directly to external identity systems without joining against `res_users`.