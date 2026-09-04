# odoo_mail_message_schedule

## Source system
This table originates from Odoo ERP, specifically the mail module. The naming convention `mail_message_schedule` and the presence of `create_uid` and `write_uid` audit columns are characteristic of Odoo's ORM-based database schema.

## Functional process 
This table supports the automated communication and notification scheduling process within Odoo. It manages the queue for outgoing messages, ensuring that emails or notifications linked to specific business objects are dispatched at the intended `scheduled_datetime`.

## Description
One row represents a single scheduled instance of a mail message waiting to be processed by the Odoo mail server. It acts as a raw landing copy of the scheduling queue, capturing the timing and parameters required for the system to execute the message delivery.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| mail_message_id | INTEGER | false | Foreign key to the parent message | Links to the core message content. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who scheduled the message. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the schedule. |
| notification_parameters | TEXT | true | JSON/Serialized config | Contains specific delivery settings or metadata. |
| scheduled_datetime | TIMESTAMP | false | Execution timestamp | The planned time for message dispatch. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp for when the schedule was created. |
| write_date | TIMESTAMP | true | Record update timestamp | Audit timestamp for the last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `mail_message_id` → `mail_message.id`: This column links the schedule to the primary message record in the Odoo mail system.
    - `create_uid` → `res_users.id`: Standard Odoo pattern for tracking the user who created the record.
    - `write_uid` → `res_users.id`: Standard Odoo pattern for tracking the user who last modified the record.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `notification_parameters` column may contain serialized data that could include PII or internal system configuration details; inspect before exposing to non-admin users.
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify against the application server configuration if local time conversion is required.
- **Data Retention:** This table represents a queue; rows may be deleted or archived by the Odoo `ir.cron` cleanup jobs once the message is processed.
- **Precision:** `TIMESTAMP` columns in Odoo are generally stored without timezone info (naive) in the database; assume UTC unless otherwise specified by the Odoo instance settings.