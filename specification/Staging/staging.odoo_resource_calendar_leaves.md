# odoo_resource_calendar_leaves

## Source system
This table originates from Odoo ERP, as indicated by the naming convention `resource_calendar_leaves` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the Human Resources and Scheduling modules by tracking time-off, leave requests, or calendar exceptions for specific resources. It defines periods where a resource is unavailable or assigned to a specific non-standard activity, directly impacting capacity planning and scheduling calculations.

## Description
One row in this table represents a single leave or calendar exception period for a specific resource or calendar. It acts as a raw landed copy of the Odoo `resource.calendar.leaves` model, capturing the start and end timestamps of the leave and the associated resource or calendar context.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| company_id | INTEGER | true | Foreign key to company | Links the leave to a specific organizational entity. |
| calendar_id | INTEGER | true | Foreign key to calendar | The calendar associated with this leave entry. |
| resource_id | INTEGER | true | Foreign key to resource | The specific resource (e.g., employee) taking the leave. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| name | VARCHAR | true | Leave description | Human-readable label for the leave event. |
| time_type | VARCHAR | true | Type of time entry | Categorization of the leave (e.g., 'leave', 'other'). |
| date_from | TIMESTAMP | false | Start timestamp | Beginning of the leave period. |
| date_to | TIMESTAMP | false | End timestamp | Conclusion of the leave period. |
| create_date | TIMESTAMP | true | Creation timestamp | Record creation date/time. |
| write_date | TIMESTAMP | true | Modification timestamp | Last record update date/time. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `calendar_id` → `resource_calendar.id` (Links to the parent calendar definition).
    - `resource_id` → `resource_resource.id` (Links to the specific resource entity).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo typically stores timestamps in UTC; verify against application settings if local time conversion is required.
- **Sensitive Data:** The `name` column may contain descriptive text regarding the reason for leave, which could include PII (e.g., medical reasons). Masking is recommended for non-HR reporting roles.
- **Soft Deletes:** This table does not appear to have an explicit `active` flag; assume all records are current unless Odoo's internal logic dictates otherwise.
- **Data Precision:** `VARCHAR` lengths are not explicitly defined in the source; downstream consumers should account for variable-length strings.