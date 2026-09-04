# odoo_quotation_document_sale_pdf_form_field_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal ORM mechanism for managing many-to-many relationship tables between two entities, in this case, quotation documents and PDF form fields.

## Functional process 
This table supports the document management and sales quotation process. It maps specific PDF form fields to quotation documents, likely used to dynamically populate or extract data from PDF templates during the sales quotation generation workflow.

## Description
One row in this table represents a single association between a quotation document and a PDF form field. It is a raw landing of a many-to-many join table, serving as the bridge to resolve the relationship between document headers and their constituent form field definitions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| quotation_document_id | INTEGER | false | Foreign key to the quotation document entity. | Represents the parent document record. |
| sale_pdf_form_field_id | INTEGER | false | Foreign key to the PDF form field definition. | Represents the specific field mapped to the document. |

## Keys

- **Primary key (inferred):** The composite of `(quotation_document_id, sale_pdf_form_field_id)`.
- **Foreign keys (inferred):** 
    - `quotation_document_id` → `staging.odoo_quotation_document.id` (inferred from naming convention).
    - `sale_pdf_form_field_id` → `staging.odoo_sale_pdf_form_field.id` (inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; assume this table reflects the current state of relationships as captured during the last ingestion.
- Ensure joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced during the extraction process.