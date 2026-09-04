# odoo_bus_bus

## Source system
This table originates from Odoo ERP, specifically the `bus_bus` table within the Odoo framework. The naming convention, including the `create_uid` and `write_uid` audit columns and the `nextval` sequence default, is characteristic of the Odoo ORM's internal messaging and notification bus system.

## Functional process 
This table supports the Odoo real-time notification and messaging infrastructure. It acts as a message queue or buffer for the Odoo "bus," which facilitates real-time communication between the server and client-side web interfaces, such as instant messaging, system notifications, and UI updates.

## Description
One row in this table represents a single message or notification event transmitted through the Odoo bus system. This is a raw landing of the Odoo bus records, capturing the channel identifier, the message payload, and the audit timestamps for record creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.bus_bus_id_seq` for auto-increment. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the Odoo `res_users` table. |
| channel | VARCHAR | true | Target channel identifier | Defines the scope or recipient group for the message. |
| message | VARCHAR | true | The message payload | Contains the JSON or text content of the notification. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo server. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the Odoo server. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Inferred from Odoo standard naming conventions for audit columns).
    - `write_uid` → `res_users.id` (Inferred from Odoo standard naming conventions for audit columns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data Volatility:** This table represents a message bus; records are often short-lived and may be purged by Odoo's internal cleanup cron jobs.
- **Timestamps:** Timestamps are stored in UTC, consistent with standard Odoo server configurations.
- **Payload:** The `message` column typically contains serialized JSON strings; ensure your downstream parsing logic handles potential malformed JSON or empty strings.
- **PII:** The `message` column may contain sensitive user communication or system-level data; ensure appropriate masking if exposing to non-privileged users.