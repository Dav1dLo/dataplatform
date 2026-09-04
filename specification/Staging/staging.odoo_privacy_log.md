# odoo_privacy_log

## Source system
This table originates from Odoo ERP, as evidenced by the characteristic naming convention of audit and user-tracking columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and the specific functional focus on privacy and data anonymization logs.

## Functional process 
This table supports the GDPR/data privacy compliance process, specifically tracking requests for data anonymization or deletion. It logs the execution of privacy-related tasks, linking the specific user whose data was processed (`user_id`) with the details of the anonymization action performed.

## Description
One row in this table represents a single privacy-related event or anonymization request executed within the Odoo system. It serves as a raw landing copy of the system's privacy audit trail, providing a historical record of when and how user data was anonymized.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.privacy_log_id_seq`. |
| user_id | INTEGER | false | Target user identifier | References the user whose data is being processed. |
| create_uid | INTEGER | true | Creator user ID | The ID of the user who initiated the log entry. |
| write_uid | INTEGER | true | Last modifier user ID | The ID of the user who last updated the log entry. |
| anonymized_name | VARCHAR | false | Anonymized display name | The masked version of the user's name. |
| anonymized_email | VARCHAR | false | Anonymized email address | The masked version of the user's email. |
| execution_details | TEXT | true | Process execution logs | Technical details regarding the anonymization execution. |
| records_description | TEXT | true | Affected records summary | Description of the specific records or modules affected. |
| additional_note | TEXT | true | Manual notes | Free-text field for administrative comments. |
| date | TIMESTAMP | false | Event timestamp | The date and time the privacy event occurred. |
| create_date | TIMESTAMP | true | Record creation timestamp | When this log entry was first created in the system. |
| write_date | TIMESTAMP | true | Record modification timestamp | When this log entry was last updated. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: Standard Odoo pattern for linking to user records).
    - `create_uid` → `res_users.id` (Guess: Standard Odoo audit column).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo audit column).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains `anonymized_name` and `anonymized_email`. While these are intended to be anonymized, ensure they are handled according to internal PII masking policies.
- **Timezones:** Timestamps (`date`, `create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Integrity:** The `anonymized_name` and `anonymized_email` columns are marked as `NOT NULL`, but verify if the source system populates these with placeholders (e.g., "Anonymized") or actual masked strings.
- **Soft Deletes:** This table appears to be an append-only audit log; there is no evidence of a soft-delete flag.