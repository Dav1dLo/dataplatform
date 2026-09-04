# odoo_mail_wizard_invite

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `mail_wizard_invite` and the presence of `res_model` and `res_id` are characteristic of Odoo's internal messaging and notification framework, which uses "wizards" to handle user interactions for record-specific invitations or notifications.

## Functional process 
This table supports the internal communication and notification process within Odoo. It tracks the state of "invite" wizards, which allow users to invite other partners or users to follow or participate in discussions related to specific records (e.g., a Sales Order or a CRM Lead).

## Description
One row in this table represents a single instance of an invitation wizard session initiated by a user. It captures the context of the invitation, including the target record, the message content, and the notification preferences. This is a raw landing copy of the Odoo `mail.wizard.invite` model, intended for staging purposes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| res_id | INTEGER | true | Target record ID | The ID of the record being referenced in the invitation. |
| create_uid | INTEGER | true | Creator user ID | The ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | The ID of the user who last updated the wizard record. |
| res_model | VARCHAR | false | Target model name | The technical name of the Odoo model (e.g., 'crm.lead'). |
| message | TEXT | true | Invitation message | The body text of the invitation sent to recipients. |
| notify | BOOLEAN | true | Notification flag | Indicates if the target users should receive a notification. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the wizard was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: links to the Odoo users table).
    - `write_uid` → `res_users.id` (Guess: links to the Odoo users table).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** The `message` column may contain free-text communication that could include PII or sensitive business information; ensure appropriate masking if exposed to non-authorized users.
- **Timezones:** Odoo typically stores timestamps in UTC; however, verify if the ingestion process has performed any local-time conversions.
- **Data Integrity:** As a staging table, this contains raw Odoo data; `res_id` and `res_model` are polymorphic, meaning `res_id` refers to different tables depending on the value in `res_model`.
- **Soft Deletes:** This table does not appear to have a dedicated `active` or `deleted_at` flag; assume all records are current unless Odoo's internal logic dictates otherwise.