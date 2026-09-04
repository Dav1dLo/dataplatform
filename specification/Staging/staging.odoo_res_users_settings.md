# odoo_res_users_settings

## Source system
This table originates from Odoo ERP, specifically the `res.users.settings` model. The naming convention (e.g., `res_users_settings`, `create_uid`, `write_uid`) is characteristic of the Odoo framework's internal data structure for managing user-specific application preferences.

## Functional process 
This table supports the user preference and configuration management process within the Odoo Discuss and Calendar modules. It tracks individual user settings for communication features, such as push-to-talk configurations, notification preferences, and sidebar UI states, ensuring that user-specific application behavior persists across sessions.

## Description
One row in this table represents the unique set of application preferences for a single Odoo user. It serves as a raw landing copy of the Odoo `res.users.settings` model, capturing both system-generated audit metadata and user-defined configuration flags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| user_id | INTEGER | false | Foreign key to the user | Links to the `res_users` table. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC timestamp of last update. |
| voice_active_duration | INTEGER | true | Voice activity duration | Likely measured in milliseconds or seconds. |
| push_to_talk_key | VARCHAR | true | Push-to-talk shortcut key | The keyboard key assigned for PTT. |
| channel_notifications | VARCHAR | true | Notification preference | Configuration string for channel alerts. |
| is_discuss_sidebar_category_channel_open | BOOLEAN | true | Sidebar channel state | UI state for the channel category. |
| is_discuss_sidebar_category_chat_open | BOOLEAN | true | Sidebar chat state | UI state for the chat category. |
| use_push_to_talk | BOOLEAN | true | PTT enabled flag | Whether push-to-talk is active. |
| mute_until_dt | TIMESTAMP | true | Mute expiration | Timestamp until which notifications are muted. |
| calendar_default_privacy | VARCHAR | false | Calendar privacy level | Default visibility setting for calendar events. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `staging.res_users.id`: This column maps to the Odoo user entity.
    - `create_uid` → `staging.res_users.id`: References the user who performed the creation.
    - `write_uid` → `staging.res_users.id`: References the user who performed the last update.
- **Natural keys (inferred):** 
    - `user_id`: In Odoo, `res.users.settings` is typically a 1:1 relationship with `res.users`.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user-specific configuration and potentially identifiable activity patterns; ensure access is restricted according to internal PII policies.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database storage practices.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely managed via standard Odoo CRUD operations.
- **Data Integrity:** `create_uid` and `write_uid` may be null if the record was created via system processes rather than a direct user action.