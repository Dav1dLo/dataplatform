# odoo_web_editor_converter_test_sub

## Source system
This table originates from Odoo ERP. The naming convention `web_editor_converter_test_sub` combined with standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) is characteristic of Odoo's internal ORM-managed tables, likely used for testing or specialized web editor functionality.

## Functional process 
This table supports internal testing or configuration processes related to the Odoo web editor's data conversion logic. It acts as a staging repository for sub-entities or test cases processed by the web editor module, tracking user-driven creation and modification events.

## Description
One row in this table represents a single test sub-entity or configuration record within the Odoo web editor framework. It serves as a raw landed copy of the source system's internal state, maintaining the audit trail of record creation and updates.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.web_editor_converter_test_sub_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res_users` table. |
| name | VARCHAR | true | Descriptive name or identifier | Content varies based on test case requirements. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC; Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC; Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking the last user to modify a record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** No explicit PII identified, though `name` fields in Odoo can occasionally contain user-entered data.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column); assume records are hard-deleted if missing from source.
- **Data Integrity:** As a staging table, this may contain transient data or test artifacts that do not represent core business transactions.