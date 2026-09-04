# odoo_product_document

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `ir_attachment_id`, `create_uid`, `write_uid`, `write_date`) is characteristic of Odoo's internal ORM structure, where `ir_attachment` is the standard model for file storage and `product_document` links these attachments to specific product-related business processes.

## Functional process 
This table supports the product lifecycle management and sales/manufacturing documentation process. It manages the association of digital assets (attachments) with product records, specifically controlling whether these documents are exposed or required during the Manufacturing (MRP) or Sales order processes.

## Description
One row in this table represents a link between a product document and its configuration settings, defining how that document behaves within the Odoo ecosystem. It acts as a staging layer record, providing a raw, un-transformed copy of the document-to-product association metadata as it exists in the source Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.product_document_id_seq`. |
| ir_attachment_id | INTEGER | false | Foreign key to the attachment record | Links to the actual file/binary metadata. |
| sequence | INTEGER | true | Display order index | Used for sorting documents in UI lists. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this link. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this link. |
| active | BOOLEAN | true | Soft-delete flag | If false, the document association is hidden. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo server. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo server. |
| attached_on_mrp | VARCHAR | false | MRP visibility flag | Indicates if the document is used in manufacturing. |
| attached_on_sale | VARCHAR | false | Sales visibility flag | Indicates if the document is used in sales orders. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_attachment_id` → `staging.ir_attachment.id` (Inferred based on Odoo standard naming conventions for attachment links).
    - `create_uid` → `staging.res_users.id` (Standard Odoo pattern for user tracking).
    - `write_uid` → `staging.res_users.id` (Standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable. While `ir_attachment_id` is likely unique per document link, the business key depends on the parent product ID (not present in this table).

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** The `active` column should be filtered (`WHERE active = TRUE`) in all downstream queries to exclude logically deleted records.
- **Visibility Flags:** The `attached_on_mrp` and `attached_on_sale` columns are `VARCHAR` types; check for specific string values (e.g., 'auto', 'manual', or 'none') as these are often Odoo selection fields.
- **Data Integrity:** As a staging table, this data is raw; ensure joins to `ir_attachment` handle potential missing records if the source system has orphan attachments.