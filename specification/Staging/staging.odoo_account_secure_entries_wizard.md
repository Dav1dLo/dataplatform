# odoo_account_secure_entries_wizard

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention `account_secure_entries_wizard` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the financial accounting module's security process, specifically the "Secure Entries" wizard used to lock or hash accounting entries to ensure data integrity and audit compliance. It tracks the execution of the hashing process for specific companies at a given date.

## Description
One row in this table represents a single execution instance of the accounting entry security wizard. It serves as a raw landing copy of the wizard's configuration and audit metadata, capturing which user initiated the process and when the entries were secured.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the organization for which entries were secured. |
| create_uid | INTEGER | true | User ID who created the record | References the user who initiated the wizard. |
| write_uid | INTEGER | true | User ID who last updated the record | References the user who last modified the wizard record. |
| hash_date | DATE | false | Date of the security hash | The business date for which entries were secured. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp for when the wizard was run. |
| write_date | TIMESTAMP | true | Record last update timestamp | Audit timestamp for the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo pattern for multi-company isolation).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user tables to resolve names.
- **Timestamps:** Timestamps are typically stored in UTC in Odoo; verify against the application server configuration.
- **Soft Deletes:** Odoo does not typically use soft-delete flags; records are usually hard-deleted or remain as permanent audit logs.
- **Data Integrity:** This table represents a "wizard" state; ensure queries account for the fact that this may be a transient configuration record rather than a transactional ledger entry.