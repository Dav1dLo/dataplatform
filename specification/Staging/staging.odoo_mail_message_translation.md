# odoo_mail_message_translation

## Source system
This table originates from Odoo ERP, as indicated by the naming convention `odoo_mail_message_translation` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the multi-language communication module within Odoo, specifically tracking translated versions of email or chatter messages. It facilitates the storage of localized content mapped to a parent message, enabling the system to display communications in the user's preferred language.

## Description
Each row represents a specific language translation of a message body associated with a parent record. This table serves as a raw landing copy of the Odoo `mail.message.translation` model, capturing the content and metadata for localized message delivery.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.mail_message_translation_id_seq`. |
| message_id | INTEGER | false | Foreign key to the parent message | Links to the source message record. |
| create_uid | INTEGER | true | User ID who created the translation | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the translation | References the Odoo `res.users` table. |
| source_lang | VARCHAR | false | Source language code | e.g., 'en_US'. |
| target_lang | VARCHAR | false | Target language code | e.g., 'fr_FR'. |
| body | TEXT | false | Translated message content | Contains the actual text body. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `message_id` → `staging.mail_message.id`: This column links the translation to the primary message record in the Odoo mail system.
    - `create_uid` → `staging.res_users.id`: Tracks the user responsible for the initial translation entry.
    - `write_uid` → `staging.res_users.id`: Tracks the user responsible for the most recent modification.
- **Natural keys (inferred):** Not confidently inferable; likely a combination of `message_id` and `target_lang`.

## Caveats for downstream consumers

- **Sensitive Data:** The `body` column may contain PII or sensitive communication content; ensure appropriate masking if exposing to non-authorized users.
- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Retention:** This is a staging table; it reflects the state of the source system at the time of ingestion. It does not explicitly indicate soft-delete status, so assume it contains only active records unless otherwise specified by the ingestion pipeline.
- **Precision:** `VARCHAR` lengths for language codes are not explicitly defined in the metadata; expect standard ISO language codes (e.g., 5-10 characters).