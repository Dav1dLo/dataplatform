# odoo_sms_account_phone

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention of audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the sequence-based primary key pattern typical of Odoo's PostgreSQL backend.

## Functional process 
This table supports the SMS communication module within the Odoo ecosystem, specifically managing the association between internal accounts and verified or registered phone numbers. It facilitates the routing and validation of SMS messages sent from the platform.

## Description
One row represents a single phone number associated with a specific account entity. It serves as a raw landed copy of the Odoo `sms_account_phone` table, capturing the relationship between account identifiers and their corresponding contact numbers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.sms_account_phone_id_seq`. |
| account_id | INTEGER | false | Foreign key to the parent account | Links to the account owning this phone number. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| phone_number | VARCHAR | false | The registered phone number | Format may vary; check for E.164 compliance. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC as per Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC as per Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id → account.id`: This column represents the owner of the phone number record.
    - `create_uid → res_users.id`: Tracks the system user responsible for the initial record creation.
    - `write_uid → res_users.id`: Tracks the system user responsible for the most recent modification.
- **Natural keys (inferred):** 
    - `account_id` + `phone_number`: The combination of an account and a specific phone number is expected to be unique within the Odoo SMS module.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with Odoo's internal storage.
- **Soft Deletes:** This table does not appear to have an `active` or `deleted_at` flag; assume standard Odoo behavior where records are either present or removed.
- **Data Quality:** The `phone_number` column is a `VARCHAR` without a specified length; expect inconsistent formatting (e.g., presence or absence of leading '+', spaces, or parentheses).
- **PII:** The `phone_number` column contains PII and should be handled according to data privacy policies.