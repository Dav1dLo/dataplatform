# odoo_mail_canned_response

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `mail_canned_response` and the presence of standard Odoo audit columns like `create_uid`, `write_uid`, `create_date`, and `write_date` are characteristic of Odoo's internal ORM structure for managing canned email responses.

## Functional process 
This table supports the customer communication and support automation process. It stores predefined text snippets (canned responses) that agents can use to quickly reply to customer inquiries, facilitating consistent messaging and improved response times within the Odoo mail/helpdesk module.

## Description
One row in this table represents a single canned response template available for use in the system. As a staging table, it serves as a raw, direct copy of the Odoo database entity, capturing the content of the response, its usage metadata, and ownership/audit information.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created the response. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the response. |
| source | VARCHAR | false | Shortcut/Trigger text | The shorthand text used to trigger the canned response. |
| description | VARCHAR | true | Human-readable label | A brief description of the response's purpose. |
| substitution | TEXT | false | Response content | The actual body text of the canned response. |
| is_shared | BOOLEAN | true | Visibility flag | Indicates if the response is shared across the organization. |
| last_used | TIMESTAMP | true | Last usage timestamp | The date and time the response was last inserted into a message. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation date in the source system. |
| write_date | TIMESTAMP | true | Last update timestamp | Record last modification date in the source system. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification).
- **Natural keys (inferred):** `source` (Assuming the trigger shortcut is intended to be unique within the system context).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the source system's local time; verify if the Odoo instance is configured for UTC.
- **Sensitive Data:** The `substitution` column may contain PII or internal company templates; ensure appropriate masking if exposing to non-authorized users.
- **Data Integrity:** `create_uid` and `write_uid` may be null if the record was created via system migration or automated scripts.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all rows are currently active unless otherwise specified by Odoo's internal logic.