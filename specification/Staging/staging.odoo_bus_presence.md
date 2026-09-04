# odoo_bus_presence

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention `bus_presence` and the presence of columns like `user_id`, `last_poll`, and `last_presence` are characteristic of Odoo's internal "Bus" module, which manages real-time communication and user session tracking within the Odoo web client.

## Functional process 
This table supports the real-time user presence and session management process. It tracks whether users are currently active, idle, or offline within the Odoo interface, facilitating features like instant messaging (Discuss module) and real-time notification delivery.

## Description
One row in this table represents the current presence status of a specific user or guest session within the Odoo application. It serves as a raw landing copy of the system's session heartbeat data, capturing the most recent interaction timestamps and status flags for active connections.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.bus_presence_id_seq`. |
| user_id | INTEGER | true | Foreign key to the Odoo user | Nullable if the session belongs to a guest. |
| status | VARCHAR | true | Current presence status | Likely values: 'online', 'away', 'offline'. |
| last_poll | TIMESTAMP | true | Timestamp of the last server poll | Indicates when the client last checked for updates. |
| last_presence | TIMESTAMP | true | Timestamp of the last user activity | Indicates the last time the user interacted with the UI. |
| guest_id | INTEGER | true | Foreign key to the Odoo guest | Nullable if the session belongs to a registered user. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Guess: standard Odoo user reference).
    - `guest_id` → `mail_guest.id` (Guess: standard Odoo guest reference).
- **Natural keys (inferred):** 
    - `user_id` (when present, identifies the user's presence record).
    - `guest_id` (when present, identifies the guest's presence record).

## Caveats for downstream consumers

- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Data Volatility:** This table is highly volatile; it represents transient state and is frequently updated or truncated by the Odoo bus service.
- **Soft Deletes:** There is no explicit soft-delete flag; records are likely managed via direct updates or deletions by the source application.
- **Sensitivity:** Contains user activity patterns which may be considered PII in certain compliance contexts.