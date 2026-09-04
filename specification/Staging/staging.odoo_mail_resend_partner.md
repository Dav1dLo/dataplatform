# odoo_mail_resend_partner

## Source system
This table originates from Odoo ERP, specifically the mail module. The naming convention `mail_resend_partner` and the presence of `resend_wizard_id` are characteristic of Odoo's internal messaging and notification retry mechanisms.

## Functional process 
This table supports the email notification retry process within Odoo. It tracks which partners (recipients) failed to receive a message and are flagged for a retry attempt via a wizard interface, allowing users to manage failed communication delivery.

## Description
One row represents a single failed notification attempt for a specific partner associated with a mail message. It acts as a staging record for the "resend" wizard, capturing the state of the retry request and the associated error message or status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| notification_id | INTEGER | false | Foreign key to mail_notification | Links to the specific notification that failed. |
| resend_wizard_id | INTEGER | true | Foreign key to mail_resend_wizard | Links to the wizard session managing the retry. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| message | VARCHAR | true | Error or status message | Contains details regarding the delivery failure. |
| resend | BOOLEAN | true | Retry flag | Indicates if the partner is selected for a resend. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `notification_id` → `mail_notification.id`: Links to the specific notification record that failed.
    - `resend_wizard_id` → `mail_resend_wizard.id`: Links to the wizard instance managing the retry batch.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Sensitivity:** The `message` column may contain technical error details or potentially PII depending on the nature of the delivery failure.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume standard CRUD operations.
- **Precision:** `VARCHAR` length is not explicitly defined in the source; downstream consumers should handle variable-length strings appropriately.