# odoo_ir_exports

## Source system
This table originates from Odoo ERP. The naming convention `ir_exports` (Internal Resource Exports) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo `ir.exports` model, which stores configuration for data export profiles.

## Functional process 
This table supports the system's data export management process. It tracks the configuration of export profiles that allow users to define which fields are included when exporting records from the Odoo interface to formats like CSV or Excel.

## Description
One row in this table represents a single export profile configuration defined within the Odoo system. It acts as a raw landing copy of the `ir.exports` metadata table, capturing the name of the export profile and the associated resource (model) it applies to.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; default uses `staging.ir_exports_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| name | VARCHAR | true | Name of the export profile | Human-readable label for the export configuration. |
| resource | VARCHAR | true | Target Odoo model name | The technical name of the model (e.g., 'res.partner') being exported. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column linking to user records).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column linking to user records).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Retention:** This is a staging table; it is unclear if this represents a full snapshot or an incremental load. Check for duplicate `id` values if the ingestion process is not idempotent.
- **Sensitive Data:** While this table contains configuration metadata, ensure that `create_uid` and `write_uid` are handled according to internal PII policies if they map to identifiable employee records.
- **Precision:** `VARCHAR` columns do not have defined lengths in the source metadata; downstream consumers should account for variable-length strings.