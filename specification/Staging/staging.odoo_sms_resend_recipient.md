# odoo_sms_resend_recipient

## Source system
This table originates from Odoo ERP, specifically the SMS marketing or communication module. The naming convention `odoo_sms_resend_recipient` and the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the SMS delivery retry mechanism. It tracks individual recipients associated with an SMS resend operation, allowing the system to manage failed delivery attempts and determine which specific phone numbers or partners require a re-transmission of an SMS notification.

## Description
One row in this table represents a single recipient record linked to a specific SMS resend event. It serves as a raw landing copy of the Odoo `sms.resend.recipient` model, capturing the status of delivery attempts and the associated partner information for auditing and retry logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by `staging.sms_resend_recipient_id_seq`. |
| sms_resend_id | INTEGER | false | Foreign key to the parent resend operation | Links to the `sms.resend` header record. |
| notification_id | INTEGER | false | Foreign key to the notification record | Links to the specific `mail.notification` being retried. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users`. |
| partner_name | VARCHAR | true | Name of the recipient partner | Denormalized display name from the partner record. |
| sms_number | VARCHAR | true | Recipient phone number | The number used for the SMS delivery attempt. |
| resend | BOOLEAN | true | Resend flag | Indicates if this recipient is marked for a retry. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time (usually UTC). |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time (usually UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `sms_resend_id` → `staging.odoo_sms_resend.id` (Inferred from Odoo naming conventions for parent-child relationships).
    - `notification_id` → `staging.odoo_mail_notification.id` (Inferred from Odoo's standard notification framework).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `sms_number` column contains PII (phone numbers) and should be masked or restricted according to data privacy policies.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo, but verify against the source system configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically deleted if removed in the source.
- **Data Integrity:** As a staging table, this may contain duplicate records if the ingestion process is not idempotent or if the source system performs frequent updates.