# odoo_quotation_document

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `ir_attachment_id`, `create_uid`, `write_uid`) and the use of PostgreSQL sequences for primary keys are characteristic of Odoo's internal ORM structure, where `ir_attachment` is the standard model for file storage.

## Functional process 
This table supports the document management process within the Sales/Quotation module. It acts as a link between quotation records and their associated binary attachments (such as PDFs, terms and conditions, or signed contracts), tracking the metadata and sequence of these documents.

## Description
One row represents a single document association linked to a quotation or sales record. It serves as a raw landed copy of the Odoo `ir_attachment` or related custom document model, capturing the audit trail and lifecycle status of the attachment within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.quotation_document_id_seq`. |
| ir_attachment_id | INTEGER | false | Reference to the core attachment record | Links to the Odoo `ir.attachment` table. |
| sequence | INTEGER | true | Display order index | Used to sort documents in the UI. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last updated the record | References `res.users`. |
| document_type | VARCHAR | false | Category of the document | Defines the business purpose (e.g., 'quote', 'contract'). |
| active | BOOLEAN | true | Soft-delete flag | If false, the document is hidden from the UI. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_attachment_id` → `ir_attachment.id`: This column is a standard Odoo reference to the central attachment repository.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record ownership.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modification.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` fields are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** The `active` column indicates a soft-delete pattern; queries should filter by `WHERE active = TRUE` unless historical analysis of deleted records is required.
- **PII:** While this table contains metadata, the associated `ir_attachment` records may contain sensitive customer data or legal documents; ensure appropriate access controls are applied to the underlying file storage.
- **Data Precision:** `VARCHAR` length is not explicitly defined in the source; downstream transformations should handle potential truncation if mapping to fixed-width fields.