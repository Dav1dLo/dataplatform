# odoo_calendar_recurrence

## Source system
This table originates from Odoo ERP, specifically the calendar module. The naming convention (e.g., `rrule`, `write_uid`, `create_date`) and the structure of recurrence patterns are characteristic of Odoo's internal calendar management system.

## Functional process 
This table supports the scheduling and recurrence logic for calendar events. It defines the rules for repeating meetings or tasks, such as frequency, end conditions, and specific days of the week, which are then applied to individual event instances within the Odoo calendar module.

## Description
One row in this table represents a single recurrence rule definition associated with a base calendar event. It acts as a raw landed copy of the Odoo `calendar.recurrence` model, storing the configuration parameters required to generate recurring event instances.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| base_event_id | INTEGER | true | Reference to the parent event | Links to the primary event triggering this recurrence. |
| interval | INTEGER | true | Recurrence interval | Frequency multiplier (e.g., every 2 weeks). |
| count | INTEGER | true | Number of occurrences | Used when recurrence is limited by count. |
| day | INTEGER | true | Specific day of month | Used for monthly recurrence patterns. |
| trigger_id | INTEGER | true | Trigger reference | Internal Odoo reference for automation triggers. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the rule. |
| name | VARCHAR | true | Rule display name | Human-readable description of the recurrence. |
| event_tz | VARCHAR | true | Timezone | IANA timezone string for the event. |
| rrule | VARCHAR | true | RFC 5545 RRULE string | The full iCalendar recurrence rule specification. |
| rrule_type | VARCHAR | true | Recurrence frequency | e.g., 'daily', 'weekly', 'monthly', 'yearly'. |
| end_type | VARCHAR | true | Termination condition | e.g., 'count', 'until', or 'forever'. |
| month_by | VARCHAR | true | Monthly recurrence mode | Defines if monthly recurrence is by date or day. |
| weekday | VARCHAR | true | Weekday identifier | Specific day for weekly/monthly recurrence. |
| byday | VARCHAR | true | By-day rule component | Complex recurrence logic for specific days. |
| until | DATE | true | End date | The date after which the recurrence stops. |
| mon | BOOLEAN | true | Monday flag | Boolean flag for weekly recurrence. |
| tue | BOOLEAN | true | Tuesday flag | Boolean flag for weekly recurrence. |
| wed | BOOLEAN | true | Wednesday flag | Boolean flag for weekly recurrence. |
| thu | BOOLEAN | true | Thursday flag | Boolean flag for weekly recurrence. |
| fri | BOOLEAN | true | Friday flag | Boolean flag for weekly recurrence. |
| sat | BOOLEAN | true | Saturday flag | Boolean flag for weekly recurrence. |
| sun | BOOLEAN | true | Sunday flag | Boolean flag for weekly recurrence. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `base_event_id` → `calendar_event.id` (Guess: links to the source event definition).
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined with user tables to resolve names.
- **Timestamps:** `create_date` and `write_date` are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not appear to have an `active` flag; check if Odoo's standard `active` column is missing or if this table uses hard deletes.
- **RRULE Complexity:** The `rrule` column contains raw iCalendar strings; parsing these for downstream analytics requires an RFC 5545 compliant library.