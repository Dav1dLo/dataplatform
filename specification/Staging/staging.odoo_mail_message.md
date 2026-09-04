# odoo_mail_message

## Source system
This table originates from Odoo ERP, specifically the `mail.message` model. The naming conventions (e.g., `res_id`, `create_uid`, `write_uid`, `model`) and the specific sequence generator `mail_message_id_seq` are characteristic of the Odoo framework's ORM layer.

## Functional process 
This table supports the Odoo communication and collaboration module. It acts as the central repository for all system notifications, emails, and internal chatter logs linked to various business objects (such as sales orders, invoices, or CRM leads) across the organization.

## Description
One row represents a single communication event, such as an email sent, a system notification, or a comment posted in the chatter. It captures the content, metadata, and relational context of the message. As a staging table, it provides a raw, landed copy of the Odoo `mail_message` table, serving as the foundation for downstream communication analytics and audit trails.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `mail_message_id_seq`. |
| parent_id | INTEGER | true | Reference to parent message | Used for threading/replies. |
| res_id | INTEGER | true | Related record ID | ID of the object the message is linked to. |
| record_alias_domain_id | INTEGER | true | Alias domain ID | Odoo multi-company/multi-domain context. |
| record_company_id | INTEGER | true | Company ID | The company associated with the message. |
| subtype_id | INTEGER | true | Message subtype ID | Categorizes the message (e.g., note, email). |
| mail_activity_type_id | INTEGER | true | Activity type ID | Links to specific activity definitions. |
| author_id | INTEGER | true | Author partner ID | Reference to `res.partner`. |
| author_guest_id | INTEGER | true | Author guest ID | Reference for non-registered users. |
| mail_server_id | INTEGER | true | Mail server ID | The SMTP server used for sending. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the record. |
| subject | VARCHAR | true | Message subject line | Often null for internal chatter notes. |
| model | VARCHAR | true | Related model name | The Odoo technical name (e.g., 'sale.order'). |
| record_name | VARCHAR | true | Display name of record | Human-readable name of the linked object. |
| message_type | VARCHAR | false | Type of message | e.g., 'email', 'comment', 'notification'. |
| email_from | VARCHAR | true | Sender email address | The 'From' field of the message. |
| message_id | VARCHAR | true | External message ID | The RFC 5322 Message-ID header. |
| reply_to | VARCHAR | true | Reply-to email address | Address used for incoming replies. |
| email_layout_xmlid | VARCHAR | true | Email template XML ID | Reference to the layout template used. |
| body | TEXT | true | Message content | HTML or plain text body of the message. |
| is_internal | BOOLEAN | true | Internal flag | True if the message is hidden from external partners. |
| reply_to_force_new | BOOLEAN | true | Force new thread flag | Forces a new thread for replies. |
| email_add_signature | BOOLEAN | true | Add signature flag | Whether to append user signature. |
| date | TIMESTAMP | true | Message date | The timestamp of the message creation. |
| pinned_at | TIMESTAMP | true | Pinned timestamp | When the message was pinned in the UI. |
| create_date | TIMESTAMP | true | Record creation date | Audit timestamp. |
| write_date | TIMESTAMP | true | Record modification date | Audit timestamp. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `staging.odoo_mail_message.id` (Self-referencing for message threads).
    - `author_id` → `staging.odoo_res_partner.id` (Guess: links to the partner who authored the message).
    - `create_uid` → `staging.odoo_res_users.id` (Guess: links to the user who created the record).
- **Natural keys (inferred):** 
    - `message_id` (The RFC 5322 Message-ID is globally unique for email-based messages).

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `body`, `email_from`, and `subject` columns may contain PII or sensitive business communications; ensure appropriate masking for non-authorized users.
- **Timezones:** Timestamps are generally stored in UTC in Odoo; verify against system configuration if local time offsets are observed.
- **Soft Deletes:** Odoo typically performs hard deletes on `mail.message` records; if a record is missing, it has likely been purged from the source.
- **Content:** The `body` column contains raw HTML; downstream consumers may need to strip tags for text analysis.