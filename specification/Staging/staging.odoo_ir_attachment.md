# odoo_ir_attachment

## Source system
This table originates from Odoo ERP, as evidenced by the `ir_attachment` naming convention, which is the standard technical name for the attachment management model in the Odoo framework. The presence of columns like `res_model`, `res_id`, `create_uid`, and `write_uid` is characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the document and media management process across the ERP. It acts as a central repository for files linked to various business entities (e.g., invoices, product images, or email attachments), mapping binary data or external URLs to specific records in other Odoo modules via the `res_model` and `res_id` fields.

## Description
One row in this table represents a single file attachment, which may be stored as binary data in the database or referenced via a URL. This table serves as a raw landing copy of the Odoo `ir.attachment` model, capturing metadata, access controls, and storage pointers for all system-wide attachments.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| res_id | INTEGER | true | ID of the related record | Links to the record in `res_model`. |
| company_id | INTEGER | true | Owning company ID | Multi-company context. |
| file_size | INTEGER | true | Size of the file in bytes | - |
| create_uid | INTEGER | true | User ID who created the record | References `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users`. |
| name | VARCHAR | false | Display name of the attachment | - |
| res_model | VARCHAR | true | Technical name of the related model | e.g., 'account.move'. |
| res_field | VARCHAR | true | Specific field name on the model | Used if attached to a specific field. |
| type | VARCHAR | false | Storage type | 'binary' or 'url'. |
| url | VARCHAR(1024) | true | External URL for the file | Populated if type is 'url'. |
| access_token | VARCHAR | true | Security token for public access | - |
| store_fname | VARCHAR | true | Filename in the filestore | Path/name on disk if not in DB. |
| checksum | VARCHAR(40) | true | SHA1 or similar file hash | Used for integrity checks. |
| mimetype | VARCHAR | true | MIME type of the file | e.g., 'application/pdf'. |
| description | TEXT | true | User-provided description | - |
| index_content | TEXT | true | Extracted text for search | Used for full-text indexing. |
| public | BOOLEAN | true | Public access flag | If true, accessible without auth. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |
| db_datas | BYTEA | true | Binary file content | Stored directly in DB if type is 'binary'. |
| original_id | INTEGER | true | Reference to original attachment | Used for versioning/cloning. |
| website_id | INTEGER | true | Related website ID | Contextual to Odoo Website module. |
| theme_template_id | INTEGER | true | Related theme template ID | Contextual to Odoo Website/Theme. |
| key | VARCHAR | true | Unique key identifier | Often used for system-specific assets. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming for creator fields).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming for modifier fields).
    - `company_id` → `res_company.id` (Inferred from Odoo standard multi-company architecture).
- **Natural keys (inferred):** Not confidently inferable; Odoo attachments are typically referenced by their surrogate `id`.

## Caveats for downstream consumers

- **Sensitive Data:** The `db_datas` column contains raw binary data which may include PII or sensitive business documents; ensure appropriate masking or access control.
- **Timestamps:** Timestamps (`create_date`, `write_date`) are stored in UTC as per standard Odoo configuration.
- **Storage Strategy:** The `type` column is critical; if `type = 'binary'`, the file content is in `db_datas`. If `type = 'url'`, the file is external and `db_datas` will be null.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are typically hard-deleted in Odoo.