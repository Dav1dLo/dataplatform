# odoo_ir_exports_line

## Source system
This table originates from Odoo ERP. The naming convention `ir_exports_line` (Internal Resource Exports Line) is characteristic of Odoo's metadata and configuration framework, which manages data export templates and their associated field mappings.

## Functional process 
This table supports the configuration and management of data export definitions within the Odoo platform. It tracks individual field lines assigned to specific export templates, allowing users to define which fields from a model are included in a custom export file.

## Description
One row in this table represents a single field definition line associated with a specific data export template. It serves as a raw landed copy of the Odoo `ir.exports.line` model, capturing the structural configuration of export files at the grain of one row per field per export template.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.ir_exports_line_id_seq`. |
| export_id | INTEGER | true | Foreign key to the parent export template | Links to the `ir.exports` table. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| name | VARCHAR | true | Field name or path | The technical field name being exported. |
| create_date | TIMESTAMP | true | Creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `export_id` → `staging.odoo_ir_exports.id`: This column links the line item to its parent export configuration.
    - `create_uid` → `staging.odoo_res_users.id`: Tracks the creator of the configuration line.
    - `write_uid` → `staging.odoo_res_users.id`: Tracks the last user to update the configuration line.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo stores all timestamps in UTC; ensure downstream transformations account for this if local time conversion is required.
- **Soft Deletes:** This table does not appear to implement a `deleted` or `active` flag; assume standard Odoo behavior where records are either present or removed from the source.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user records, which may contain PII; ensure appropriate access controls are applied when joining to user dimension tables.
- **Precision:** The `VARCHAR` type for `name` does not specify a length; assume standard Odoo field path lengths (typically up to 255 characters).