# odoo_mail_activity_type

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `mail_activity_type` and the presence of Odoo-specific columns like `res_model`, `create_uid`, and `write_uid` are characteristic of the Odoo framework's internal mail and activity tracking module.

## Functional process 
This table supports the CRM and task management business processes by defining the configuration for activity types (e.g., "Call", "Email", "Meeting"). It dictates how activities are scheduled, their default durations, and the automated chaining of subsequent tasks within the Odoo workflow engine.

## Description
One row represents a single configuration definition for an activity type available within the Odoo system. This is a raw landing table in the Staging layer, capturing the full metadata and localization settings for activity types as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to res_users. |
| delay_count | INTEGER | true | Duration value | Used with delay_unit. |
| triggered_next_type_id | INTEGER | true | Chained activity type ID | Self-referencing FK to this table. |
| default_user_id | INTEGER | true | Default assigned user ID | Foreign key to res_users. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to res_users. |
| delay_unit | VARCHAR | false | Time unit for deadline | e.g., 'days', 'weeks', 'months'. |
| delay_from | VARCHAR | false | Deadline calculation anchor | e.g., 'current_date', 'previous_activity'. |
| icon | VARCHAR | true | UI icon identifier | FontAwesome or Odoo icon name. |
| decoration_type | VARCHAR | true | UI styling class | e.g., 'alert', 'warning'. |
| res_model | VARCHAR | true | Target Odoo model | Restricts activity to specific entities. |
| chaining_type | VARCHAR | false | Chaining behavior | 'suggest' or 'trigger'. |
| category | VARCHAR | true | Functional category | e.g., 'default', 'meeting'. |
| name | JSONB | false | Activity type label | Multilingual support via JSON. |
| summary | JSONB | true | Default activity summary | Multilingual support via JSON. |
| default_note | JSONB | true | Default activity description | Multilingual support via JSON. |
| active | BOOLEAN | true | Soft-delete flag | True if the type is enabled. |
| keep_done | BOOLEAN | true | Retention flag | Whether to keep done activities. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field)
    - `write_uid` → `res_users.id` (Standard Odoo audit field)
    - `default_user_id` → `res_users.id` (Standard Odoo assignment field)
    - `triggered_next_type_id` → `odoo_mail_activity_type.id` (Self-referencing link for workflow automation)
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the surrogate `id` for internal references.

## Caveats for downstream consumers

- **PII/Sensitive Data:** None identified; this table contains configuration metadata rather than transactional user data.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should filter by `WHERE active = TRUE` to retrieve only current configurations.
- **JSONB Fields:** The `name`, `summary`, and `default_note` columns contain JSONB data. Downstream consumers will need to extract specific language keys (e.g., `name->>'en_US'`) to use these values in reporting.