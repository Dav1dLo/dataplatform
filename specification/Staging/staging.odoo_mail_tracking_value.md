# odoo_mail_tracking_value

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention `mail_tracking_value` and the presence of columns like `mail_message_id` and various `old_value`/`new_value` fields are characteristic of Odoo's internal `mail.tracking.value` model, which logs changes to tracked fields on business records.

## Functional process 
This table supports the audit and history tracking process within the Odoo platform. It records specific field-level changes (deltas) associated with messages or notifications, allowing the system to maintain a history of how data values evolved over time across various business modules.

## Description
One row in this table represents a single field-level value change captured during an update to a record tracked by the Odoo mail system. It acts as a raw landing of the audit trail, storing both the previous and new values across multiple data types (integer, char, text, float, datetime) to accommodate the polymorphic nature of tracked fields.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| field_id | INTEGER | true | Reference to the tracked field | Links to the Odoo `ir.model.fields` table. |
| old_value_integer | INTEGER | true | Previous integer value | Used for integer-type fields. |
| new_value_integer | INTEGER | true | New integer value | Used for integer-type fields. |
| currency_id | INTEGER | true | Currency reference | Links to the Odoo `res.currency` table. |
| mail_message_id | INTEGER | false | Parent message reference | Links to the Odoo `mail.message` table. |
| create_uid | INTEGER | true | Creator user ID | Links to the Odoo `res.users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Links to the Odoo `res.users` table. |
| old_value_char | VARCHAR | true | Previous character value | Used for short text fields. |
| new_value_char | VARCHAR | true | New character value | Used for short text fields. |
| field_info | JSONB | true | Metadata about the field | Contains additional context for the tracked change. |
| old_value_text | TEXT | true | Previous long text value | Used for long text fields. |
| new_value_text | TEXT | true | New long text value | Used for long text fields. |
| old_value_datetime | TIMESTAMP | true | Previous datetime value | Stored in UTC. |
| new_value_datetime | TIMESTAMP | true | New datetime value | Stored in UTC. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp. |
| write_date | TIMESTAMP | true | Record modification timestamp | Audit timestamp. |
| old_value_float | DOUBLE PRECISION | true | Previous float value | Used for numeric/decimal fields. |
| new_value_float | DOUBLE PRECISION | true | New float value | Used for numeric/decimal fields. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):**
    - `mail_message_id` → `mail_message.id`: This column is mandatory and links the tracking value to its parent message.
    - `field_id` → `ir_model_fields.id`: This identifies which specific field definition was modified (guess).
    - `currency_id` → `res_currency.id`: This identifies the currency context if the field is monetary (guess).
    - `create_uid` / `write_uid` → `res_users.id`: These identify the users responsible for the change (guess).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Data Types:** This table is highly polymorphic; a single row will only have values populated in one of the `old_value_*` / `new_value_*` pairs depending on the data type of the field being tracked.
- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with Odoo's standard database configuration.
- **Sensitive Data:** `old_value_text` and `new_value_text` may contain PII or sensitive business information depending on which fields are configured for tracking in the source Odoo instance.
- **Soft Deletes:** This table represents an append-only audit log; there is no evidence of soft-delete flags.