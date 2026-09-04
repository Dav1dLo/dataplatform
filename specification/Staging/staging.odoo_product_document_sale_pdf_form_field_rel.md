# odoo_product_document_sale_pdf_form_field_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module references (`product_document` and `sale_pdf_form_field`) is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link records across different functional modules.

## Functional process 
This table supports the document management and sales automation process. It facilitates the mapping between specific product-related documents and the dynamic form fields required for sales PDF generation, ensuring that the correct data points are populated when a document is attached to a sales order or product quote.

## Description
One row in this table represents a single association between a product document and a sales PDF form field. This is a junction table used to resolve a many-to-many relationship, enabling the system to track which form fields are associated with which product documents. It serves as a raw landed copy of the Odoo relational mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_document_id | INTEGER | false | Foreign key to the product document record. | Links to the primary key of the product document table. |
| sale_pdf_form_field_id | INTEGER | false | Foreign key to the sales PDF form field definition. | Links to the primary key of the form field configuration table. |

## Keys

- **Primary key (inferred):** The composite of (`product_document_id`, `sale_pdf_form_field_id`).
- **Foreign keys (inferred):** 
    - `product_document_id` → `product_document.id`: This column references the parent document entity.
    - `sale_pdf_form_field_id` → `sale_pdf_form_field.id`: This column references the specific form field definition.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the creation or modification time of these relationships from this table alone.
- Ensure that joins to the target tables handle potential orphans if the source system's referential integrity is not strictly enforced during the extraction process.