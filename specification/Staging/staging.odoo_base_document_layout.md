# odoo_base_document_layout

## Source system
This table originates from Odoo ERP. The naming convention `base_document_layout` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo framework's base module, which manages document styling and layout configurations.

## Functional process 
This table supports the document configuration and reporting process. It defines the layout settings applied to generated documents (such as invoices or reports) for specific companies, determining how these documents are rendered or formatted within the Odoo ecosystem.

## Description
One row in this table represents a specific document layout configuration associated with a company. It acts as a raw landing record in the staging layer, capturing the relationship between a company, its chosen report layout, and whether the layout is derived from an invoice context.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.base_document_layout_id_seq`. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the organization this layout belongs to. |
| report_layout_id | INTEGER | true | Foreign key to report layout | References the specific layout template used. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |
| from_invoice | BOOLEAN | true | Invoice context flag | Indicates if the layout configuration originated from an invoice. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company architecture).
    - `report_layout_id` → `ir_actions_report.id` (Likely reference to report action definitions).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail for user accounts).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active`); assume records are hard-deleted if removed from the source.
- **Data Integrity:** `report_layout_id` is nullable, implying some companies may not have a custom layout assigned or are using system defaults.
- **Sensitivity:** Contains no direct PII, though user IDs (`create_uid`, `write_uid`) link to internal system users.