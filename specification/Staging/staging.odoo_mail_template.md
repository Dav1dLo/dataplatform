# odoo_mail_template

## Source system
This table originates from Odoo ERP, as evidenced by the characteristic naming convention of columns such as `model_id`, `create_uid`, `write_uid`, and the use of `JSONB` for multi-language fields (e.g., `name`, `subject`, `body_html`), which is a standard pattern in Odoo's PostgreSQL backend.

## Functional process 
This table supports the automated communication and notification engine within the Odoo platform. It stores email templates used for system-generated alerts, transactional emails, and marketing communications, defining the structure, content, and routing logic for outgoing messages triggered by business events.

## Description
One row in this table represents a single email template configuration, including its subject line, HTML body, and recipient settings. It serves as a raw landed copy of the Odoo `mail.template` model, capturing the state of communication templates at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID from Odoo. |
| model_id | INTEGER | true | Related Odoo model ID | Foreign key to the business object (e.g., sale.order) this template applies to. |
| user_id | INTEGER | true | Owner user ID | The user responsible for this template. |
| mail_server_id | INTEGER | true | Outgoing mail server ID | Reference to the SMTP configuration used to send emails. |
| ref_ir_act_window | INTEGER | true | Window action reference | Link to the UI action associated with this template. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the record. |
| template_fs | VARCHAR | true | Filesystem path | Path to the template file if stored on the filesystem. |
| lang | VARCHAR | true | Language code | Default language for the template (e.g., 'en_US'). |
| model | VARCHAR | true | Model technical name | The technical name of the Odoo model (e.g., 'sale.order'). |
| email_from | VARCHAR | true | Sender email address | The 'From' address, often using placeholders. |
| email_to | VARCHAR | true | Recipient email address | The 'To' address, often using placeholders. |
| partner_to | VARCHAR | true | Partner ID string | String representation of partner IDs to receive the email. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list of CC recipients. |
| reply_to | VARCHAR | true | Reply-to email address | The address used for replies. |
| email_layout_xmlid | VARCHAR | true | Layout XML ID | Reference to the email layout template. |
| scheduled_date | VARCHAR | true | Scheduled date expression | Jinja2 expression for calculating the send date. |
| name | JSONB | true | Template name | Multi-language name of the template. |
| description | JSONB | true | Template description | Multi-language description. |
| subject | JSONB | true | Email subject | Multi-language subject line. |
| body_html | JSONB | true | Email body content | Multi-language HTML content of the email. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the template is currently enabled. |
| use_default_to | BOOLEAN | true | Use default recipient | Flag to use the default recipient from the model. |
| auto_delete | BOOLEAN | true | Auto-delete flag | If true, deletes the email record after sending. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `ir_model.id` (Likely reference to the Odoo model registry).
    - `create_uid` → `res_users.id` (Reference to the user who created the record).
    - `write_uid` → `res_users.id` (Reference to the user who last modified the record).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Fields:** The `name`, `description`, `subject`, and `body_html` columns contain `JSONB` data. You will need to use PostgreSQL JSON operators (e.g., `->>`) to extract specific language values.
- **Timestamps:** Timestamps are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure your queries filter by `active = true` if you only want currently enabled templates.
- **Placeholders:** Fields like `email_from` and `email_to` often contain Jinja2 placeholders (e.g., `{{ object.partner_id.email }}`) which are resolved at runtime by the Odoo mail engine, not at the database level.