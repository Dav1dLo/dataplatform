# odoo_sms_resend

## Source system
This table originates from Odoo ERP, specifically the SMS marketing or communication module. The naming convention `odoo_sms_resend` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the SMS communication retry mechanism. It tracks messages that failed to send and are queued for a resend attempt, linking specific mail messages to the retry logic managed by the Odoo communication framework.

## Description
One row in this table represents a single SMS resend request associated with a specific mail message. It serves as a raw staging record capturing the state of failed SMS delivery attempts before they are processed or cleared by the Odoo background workers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.sms_resend_id_seq`. |
| mail_message_id | INTEGER | false | Foreign key to the mail message | Links to the parent message record. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the resend record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard practices. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard practices. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id` (Guess: standard Odoo relation to the core messaging table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** Contains system-level audit IDs; no direct PII (like phone numbers or message content) is present in this specific table, though it links to tables that likely contain such data.
- **Soft Deletes:** This table does not appear to implement a `deleted` or `active` flag; assume standard CRUD operations.
- **Grain:** One row per resend attempt per message. If a message fails multiple times, check if this table maintains history or updates existing records.