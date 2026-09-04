# odoo_mail_resend_message

## Source system
This table originates from Odoo ERP, specifically the mail module. The naming convention `mail_resend_message` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's ORM-managed tables.

## Functional process 
This table supports the email communication retry mechanism within Odoo. It tracks instances where outgoing emails failed to send and require a manual or automated resend attempt, linking the retry event back to the original message record.

## Description
One row in this table represents a single retry request for a specific email message that failed to deliver. It serves as a staging-layer record capturing the state of message resend attempts, allowing for the tracking of communication failures and subsequent recovery actions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `mail_resend_message_id_seq`. |
| mail_message_id | INTEGER | true | Foreign key to the original mail message | Links to the primary `mail.message` record. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users`. |
| create_date | TIMESTAMP | true | Timestamp of record creation | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Timestamp of last record update | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: This column links the retry record to the specific message that failed.
    - `create_uid` → `res_users.id`: Standard Odoo audit field identifying the creator.
    - `write_uid` → `res_users.id`: Standard Odoo audit field identifying the last modifier.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo stores timestamps in UTC; ensure downstream transformations account for this if local time conversion is required.
- **PII:** While this table does not contain email addresses directly, it links to `mail_message` records which may contain sensitive communication content.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **Data Completeness:** As a staging table, this represents a raw dump; verify if `mail_message_id` is populated for all records, as nulls may indicate orphaned retry attempts.