# odoo_header_footer_quotation_template_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific column names `quotation_document_id` and `sale_order_template_id` indicates this is a standard Odoo many-to-many join table used to link quotation document templates to sale order templates.

## Functional process 
This table supports the Sales and Quotation management process. It facilitates the association of specific header/footer document configurations with sale order templates, ensuring that when a quotation is generated from a template, the correct document formatting and branding are applied.

## Description
One row in this table represents a single association between a quotation document template and a sale order template. It serves as a raw junction table in the staging layer, enabling the many-to-many relationship required for flexible document template management in Odoo.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| quotation_document_id | INTEGER | false | Foreign key to the quotation document template definition. | Links to the primary key of the document template table. |
| sale_order_template_id | INTEGER | false | Foreign key to the sale order template definition. | Links to the primary key of the sale order template table. |

## Keys

- **Primary key (inferred):** The combination of `quotation_document_id` and `sale_order_template_id` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `quotation_document_id` → `quotation_document_template.id` (Inferred based on Odoo naming conventions for relational tables).
    - `sale_order_template_id` → `sale_order_template.id` (Inferred based on Odoo naming conventions for relational tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship between two entities.
- There are no timestamps or audit columns present in this table; incremental loading based on `updated_at` is not possible.
- Ensure that joins to the parent tables handle potential orphans if the source system's referential integrity is not strictly enforced.