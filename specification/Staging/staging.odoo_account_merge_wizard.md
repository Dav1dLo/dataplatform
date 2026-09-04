# odoo_account_merge_wizard

## Source system
This table originates from Odoo ERP. The naming convention `account_merge_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal wizard models used to manage temporary state during record-merging operations.

## Functional process 
This table supports the "Data Cleansing" or "Record Consolidation" business process within the accounting module. It tracks the state of wizard sessions used to merge duplicate account records, specifically managing whether the merge logic should group records by name.

## Description
One row represents a single execution instance or session of an account merge wizard. It acts as a transient staging record that captures the configuration and audit metadata for a specific merge operation initiated by a user within the Odoo interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_merge_wizard_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the wizard session | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last modified the wizard session | References `res.users`. |
| is_group_by_name | BOOLEAN | true | Flag indicating if records are grouped by name | Used to toggle merge logic behavior. |
| create_date | TIMESTAMP | true | Timestamp of session creation | Assumed UTC. |
| write_date | TIMESTAMP | true | Timestamp of last session modification | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking record creators.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking record modifiers.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory to resolve names.
- **Timestamps:** Timestamps are stored in the system's native format; assume UTC unless otherwise specified by the Odoo instance configuration.
- **Data Lifecycle:** As a "wizard" table, this data is often transient. Expect high churn or potential truncation if the upstream system performs periodic cleanup of temporary wizard tables.
- **Nullability:** Most fields are nullable as they represent the state of an interactive UI session which may be abandoned before completion.