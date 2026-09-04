# odoo_quotation_document_sale_order_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the presence of two foreign key identifiers strongly indicate this is a standard Odoo many-to-many join table used to link quotation documents to sale orders.

## Functional process 
This table supports the Sales and Document Management processes. It maintains the relationship between specific sales orders and the associated quotation documents (e.g., PDF templates, terms and conditions, or custom quotes) generated within the Odoo ecosystem.

## Description
One row in this table represents a single association between a sale order and a quotation document. It serves as a raw landing copy of the join table from the Odoo database, facilitating the reconstruction of document-to-order relationships in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_id | INTEGER | false | Foreign key to the sale order | Links to the primary sale order record. |
| quotation_document_id | INTEGER | false | Foreign key to the quotation document | Links to the specific document record. |

## Keys

- **Primary key (inferred):** The composite of (`sale_order_id`, `quotation_document_id`).
- **Foreign keys (inferred):** 
    - `sale_order_id` → `sale_order.id` (Inferred from Odoo standard naming conventions).
    - `quotation_document_id` → `quotation_document.id` (Inferred from Odoo standard naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a link table; it contains no descriptive attributes, only identifiers.
- Ensure inner joins are used when filtering for active relationships, as this table may contain orphaned IDs if the source system does not enforce strict referential integrity during data extraction.
- No PII is present in this table.