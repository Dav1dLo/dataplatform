# odoo_mail_message_subtype

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention (`mail_message_subtype`) and the presence of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and JSONB fields for multi-language support are characteristic of the Odoo framework's messaging and notification architecture.

## Functional process 
This table supports the Odoo messaging and notification system, specifically defining the types of message subtypes available for different business objects (e.g., "Task Created", "Stage Changed"). It controls which notifications are internal, default, or hidden, and maps these subtypes to specific models via the `res_model` column, facilitating the subscription and notification logic across the platform.

## Description
One row in this table represents a single message subtype configuration, defining the behavior and visibility of specific notification types within the Odoo system. It serves as a raw landed copy of the Odoo `mail.message.subtype` model, capturing the hierarchical structure and configuration settings for system-wide messaging.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| parent_id | INTEGER | true | Self-referencing parent subtype | Used for hierarchical subtype structures. |
| sequence | INTEGER | true | Display order index | Used for sorting in UI dropdowns. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to `res_users`. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to `res_users`. |
| relation_field | VARCHAR | true | Field name for subscription | The field on `res_model` that holds followers. |
| res_model | VARCHAR | true | Target model name | The Odoo model (e.g., 'project.task') this subtype applies to. |
| name | JSONB | false | Subtype display name | Multi-language string stored as JSON. |
| description | JSONB | true | Subtype description | Multi-language description stored as JSON. |
| internal | BOOLEAN | true | Internal-only flag | If true, only visible to internal users. |
| default | BOOLEAN | true | Default subscription flag | If true, users are subscribed by default. |
| hidden | BOOLEAN | true | Hidden flag | If true, the subtype is hidden from the UI. |
| track_recipients | BOOLEAN | true | Track recipients flag | If true, tracks who receives the notification. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC timestamp. |
| write_date | TIMESTAMP | true | Record modification timestamp | UTC timestamp. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `parent_id` → `staging.odoo_mail_message_subtype.id`: References the parent subtype in a hierarchy.
    - `create_uid` → `staging.odoo_res_users.id` (guess): Tracks the user who created the subtype.
    - `write_uid` → `staging.odoo_res_users.id` (guess): Tracks the user who last modified the subtype.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Fields:** The `name` and `description` columns are `JSONB`. Query writers must use PostgreSQL JSON operators (e.g., `->>`) to extract specific language values.
- **Timestamps:** All timestamps are assumed to be in UTC, consistent with Odoo's standard database storage.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume all records are active unless otherwise specified by business logic.
- **Sensitivity:** No direct PII is present, but `create_uid` and `write_uid` link to user identity tables.