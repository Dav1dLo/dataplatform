# odoo_account_move_send_wizard

## Source system
This table originates from Odoo ERP. The naming convention `account_move_send_wizard` and the presence of columns like `move_id`, `mail_template_id`, and `sending_method_checkboxes` are characteristic of Odoo's internal wizard models used to manage the sending of accounting documents (invoices/credit notes) via email or EDI.

## Functional process 
This table supports the "Order-to-Cash" or "Procure-to-Pay" business processes by tracking the state and configuration of the document-sending wizard. It captures the user's choices regarding how an accounting document (`move_id`) should be dispatched, including email templates, attachments, and EDI integration settings.

## Description
One row represents a single execution instance of the document-sending wizard for a specific accounting move. It acts as a transient staging record that stores the configuration, email content, and metadata selected by a user before the final dispatch of an invoice or accounting document.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_move_send_wizard_id_seq`. |
| move_id | INTEGER | false | Foreign key to account move | Links to the specific accounting document being processed. |
| pdf_report_id | INTEGER | true | Foreign key to report definition | The specific PDF report template selected for the document. |
| mail_template_id | INTEGER | true | Foreign key to mail template | The email template used for the communication. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the wizard settings. |
| mail_subject | VARCHAR | true | Email subject line | The subject text configured for the outgoing email. |
| sending_method_checkboxes | JSONB | true | Dispatch method configuration | Stores boolean flags for selected sending methods (e.g., email, print). |
| extra_edi_checkboxes | JSONB | true | EDI configuration | Stores settings for electronic data interchange formats. |
| mail_attachments_widget | JSONB | true | Attachment metadata | Stores references or metadata for files attached to the email. |
| mail_body | TEXT | true | Email body content | The HTML or plain text content of the email. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard was first opened/created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the wizard configuration was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `move_id` → `account_move.id` (Inferred from Odoo naming convention for accounting entries).
    - `mail_template_id` → `mail_template.id` (Standard Odoo reference for email templates).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Data Sensitivity:** The `mail_body` and `mail_subject` columns may contain PII or sensitive business communication; ensure appropriate masking if exposed to non-authorized users.
- **Timezones:** Odoo typically stores timestamps in UTC; however, verify if the ingestion process has applied any local timezone offsets.
- **JSONB Complexity:** The `sending_method_checkboxes`, `extra_edi_checkboxes`, and `mail_attachments_widget` columns contain nested JSON structures. Querying these will require PostgreSQL `->>` or `jsonb_path_query` operators.
- **Transient Nature:** As a "wizard" table, records may be short-lived or represent incomplete states depending on the Odoo cleanup/vacuum policies.