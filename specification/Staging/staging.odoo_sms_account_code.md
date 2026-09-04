# odoo_sms_account_code

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention of the columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the sequence-based primary key pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the SMS-based multi-factor authentication or account verification process. It stores the verification codes associated with specific user accounts, likely used to validate identity during login or sensitive account modifications.

## Description
One row represents a single SMS verification code generated for a specific account. This is a raw landing table in the Staging layer, capturing the state of verification records as they exist in the source Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.sms_account_code_id_seq`. |
| account_id | INTEGER | false | Foreign key to the account | Links to the user or account entity. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| verification_code | VARCHAR | false | The verification token | The actual code sent via SMS. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `res_users.id` (or `res_partner.id`): This is a guess based on standard Odoo schema patterns where `account_id` typically references a user or partner entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `verification_code` column contains security-sensitive information and should be masked or restricted in downstream reporting environments.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo PostgreSQL configurations.
- **Soft Deletes:** This table does not explicitly show a soft-delete flag (e.g., `active`), so assume all records are current unless otherwise specified by Odoo's internal logic.
- **Data Precision:** The `VARCHAR` type for `verification_code` does not specify a length; verify the source DDL if strict length validation is required for downstream ingestion.