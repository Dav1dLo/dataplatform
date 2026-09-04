# odoo_calendar_filters

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`odoo_calendar_filters`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`).

## Functional process 
This table supports the calendar management module within Odoo, specifically tracking user-level visibility preferences for shared calendars or partner-related events. It manages which partners are currently "checked" or visible in a user's calendar view.

## Description
One row represents a specific filter configuration for a user, defining whether a particular partner's calendar events are active or visible for that user. This is a raw landing table in the Staging layer, capturing the state of the `calendar.filters` model from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.calendar_filters_id_seq`. |
| user_id | INTEGER | false | ID of the user owning the filter | References `res.users`. |
| partner_id | INTEGER | false | ID of the partner being filtered | References `res.partner`. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users`. |
| active | BOOLEAN | true | Soft-delete flag | If false, the filter is ignored by the application. |
| partner_checked | BOOLEAN | true | Visibility toggle | Indicates if the partner's events are currently checked/visible. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `user_id` → `res_users.id` (Standard Odoo pattern for user ownership)
    - `partner_id` → `res_partner.id` (Standard Odoo pattern for linked entities)
    - `create_uid` → `res_users.id` (Standard Odoo audit field)
    - `write_uid` → `res_users.id` (Standard Odoo audit field)
- **Natural keys (inferred):** 
    - `(user_id, partner_id)`: Represents the unique business relationship between a user and a partner's calendar visibility.

## Caveats for downstream consumers

- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; queries should generally filter by `WHERE active = TRUE` unless performing audit or recovery tasks.
- **Data Integrity:** As a staging table, this may contain duplicates or inconsistent states if the source Odoo instance has experienced synchronization issues.
- **PII:** While this table contains no direct PII (like emails or names), it links users to partners, which may be sensitive in certain regulatory contexts.