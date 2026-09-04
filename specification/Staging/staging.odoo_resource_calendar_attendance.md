# odoo_resource_calendar_attendance

## Source system
This table originates from Odoo ERP, specifically the resource management module. The naming convention (`resource_calendar_attendance`) and the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the human resources and project management time-tracking processes. It defines the recurring working hours or attendance slots for specific resource calendars, which are subsequently used to calculate resource availability, capacity planning, and project scheduling.

## Description
One row in this table represents a single attendance interval (a specific time block on a specific day of the week) within a resource calendar. It acts as a raw landed copy of the Odoo `resource.calendar.attendance` model, capturing the operational rules for when resources are expected to be working.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| calendar_id | INTEGER | false | Foreign key to the parent calendar | Links to `resource.calendar`. |
| resource_id | INTEGER | true | Foreign key to a specific resource | Optional; if null, applies to the whole calendar. |
| sequence | INTEGER | true | Display order index | Used for UI sorting. |
| create_uid | INTEGER | true | ID of user who created the record | Links to `res.users`. |
| write_uid | INTEGER | true | ID of user who last updated the record | Links to `res.users`. |
| name | VARCHAR | false | Descriptive name of the attendance slot | Often a human-readable label. |
| dayofweek | VARCHAR | false | Day of the week | Typically '0'-'6' (Monday-Sunday). |
| day_period | VARCHAR | false | Morning or afternoon indicator | Values like 'morning', 'afternoon'. |
| week_type | VARCHAR | true | Week rotation type | Used for bi-weekly or alternating schedules. |
| display_type | VARCHAR | true | UI display category | Used for section headers or line types. |
| date_from | DATE | true | Start date of validity | Inclusive start date. |
| date_to | DATE | true | End date of validity | Inclusive end date. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Record last update timestamp | UTC assumed. |
| hour_from | DOUBLE PRECISION | false | Start time in decimal hours | e.g., 9.0 = 09:00. |
| hour_to | DOUBLE PRECISION | false | End time in decimal hours | e.g., 17.5 = 17:30. |
| duration_days | DOUBLE PRECISION | true | Duration in days | Calculated field for capacity. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `calendar_id` → `resource_calendar.id` (Required for grouping attendance rules).
    - `resource_id` → `resource_resource.id` (Optional link to specific employee/equipment).
    - `create_uid` / `write_uid` → `res_users.id` (Standard Odoo audit trail).
- **Natural keys (inferred):** Not confidently inferable; Odoo tables typically rely on the surrogate `id` for uniqueness.

## Caveats for downstream consumers

- **Timezone:** Timestamps (`create_date`, `write_date`) are stored in UTC by Odoo.
- **Decimal Hours:** `hour_from` and `hour_to` are stored as decimal values (e.g., 14.5 represents 14:30). Ensure conversion logic is applied for time-based calculations.
- **Soft Deletes:** This table does not implement soft deletes; it is a direct reflection of the Odoo database state.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user records which may contain PII; ensure appropriate access controls are in place when joining to user tables.