# odoo_calendar_event_type

## Source system
This table originates from Odoo, an open-source ERP and CRM platform. The naming convention (`odoo_calendar_event_type`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's PostgreSQL schema structure.

## Functional process 
This table supports the calendar and scheduling module within Odoo. It defines the categories or "types" of calendar events (e.g., "Meeting", "Call", "Internal Training"), allowing users to classify and color-code their scheduled activities for better visibility in the calendar interface.

## Description
One row in this table represents a single calendar event category definition. It serves as a lookup table in the staging layer, providing the descriptive labels and UI color associations used to organize calendar events across the platform.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.calendar_event_type_id_seq`. |
| color | INTEGER | true | UI color index | Represents the color code assigned to this event type in the Odoo frontend. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who created this event type. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated this event type. |
| name | VARCHAR | false | Event type label | The human-readable name of the calendar event category. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation; timezone typically UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last record modification; timezone typically UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creation).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modification).
- **Natural keys (inferred):** 
    - `name` (Assuming event type names are unique within the Odoo instance).

## Caveats for downstream consumers

- **Sensitive Data:** No PII or sensitive financial data is present in this table.
- **Timestamps:** Timestamps are stored in the Odoo application time (typically UTC). Ensure conversion if localizing for specific reporting regions.
- **Soft Deletes:** This table does not appear to implement a `deleted` or `active` flag; assume all rows present are currently active in the source system.
- **Data Integrity:** `create_uid` and `write_uid` may be null if the record was created via a system process or migration script rather than a specific user action.