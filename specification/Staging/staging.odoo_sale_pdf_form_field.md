# odoo_sale_pdf_form_field

## Source system
This table originates from Odoo ERP. The naming convention (`odoo_sale_pdf_form_field`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the document management and sales automation process, specifically tracking the configuration of form fields within PDF templates used for sales documentation. It maps specific data points (fields) to their locations or paths within generated PDF documents, likely used to dynamically populate sales contracts or quotes.

## Description
One row represents a single form field configuration associated with a specific PDF document type. It acts as a metadata registry for mapping system data to PDF placeholders. This is a raw landing table in the Staging layer, representing a direct snapshot of the Odoo database table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo. |
| create_uid | INTEGER | true | User ID who created the record | References `res_users.id`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res_users.id`. |
| name | VARCHAR | false | Field identifier or label | The name of the form field. |
| document_type | VARCHAR | false | Category of the PDF document | Defines which template this field belongs to. |
| path | VARCHAR | true | XPath or internal field path | The technical location of the field in the PDF structure. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo typically stores timestamps in UTC; verify against system configuration if precision to the millisecond is required.
- **Audit Columns:** `create_uid` and `write_uid` are internal Odoo user IDs and may not map to a human-readable name without joining to the `res_users` table.
- **Soft Deletes:** This table does not appear to have an `active` boolean column, which is common in Odoo; assume all records are currently active unless otherwise specified by business logic.
- **Data Quality:** The `path` column is nullable; ensure downstream logic handles cases where a field might be defined but lacks a mapped path.