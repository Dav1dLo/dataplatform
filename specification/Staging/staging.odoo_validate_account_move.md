# odoo_validate_account_move

## Source system
This table originates from Odoo ERP. The naming convention `odoo_validate_account_move` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of the Odoo framework's internal transient or wizard models used to manage accounting operations.

## Functional process 
This table supports the accounting validation process, specifically the "Post Journal Entries" workflow. It captures the configuration and user-defined overrides (such as ignoring abnormal dates or amounts) used when a user triggers the validation of account moves in the Odoo general ledger.

## Description
One row in this table represents a single execution or configuration state of an account move validation request. It serves as a staging layer record reflecting the raw parameters passed to the Odoo validation engine. This table acts as a transient record of the validation intent rather than the ledger entries themselves.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.validate_account_move_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users` in Odoo. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users` in Odoo. |
| force_post | BOOLEAN | true | Flag to force posting of entries | Used to bypass standard validation checks. |
| ignore_abnormal_date | BOOLEAN | true | Flag to bypass date validation | Allows posting entries with non-standard dates. |
| ignore_abnormal_amount | BOOLEAN | true | Flag to bypass amount validation | Allows posting entries with unusual amounts. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC assumed; Odoo standard audit field. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed; Odoo standard audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for creator tracking).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for updater tracking).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** `create_uid` and `write_uid` identify internal system users; ensure these are mapped to appropriate user dimension tables if PII masking is required.
- **Lifecycle:** This table likely contains transient data; verify if the source system performs periodic cleanup or truncation of this staging table.
- **Nullability:** Most configuration flags (`force_post`, `ignore_abnormal_*`) are nullable; treat `NULL` as `FALSE` in business logic unless otherwise specified by Odoo documentation.