# odoo_spreadsheet_dashboard_group

## Source system
This table originates from Odoo ERP. The naming convention (`odoo_spreadsheet_dashboard_group`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the Odoo Spreadsheet Dashboard module, specifically managing the grouping or categorization of dashboard entities. It facilitates the organization and ordering of dashboard views within the user interface, likely used to structure how users navigate or group their analytical reports.

## Description
One row in this table represents a single dashboard group definition within the Odoo spreadsheet module. It acts as a raw landed copy of the Odoo database table, capturing the metadata and organizational sequence for dashboard groupings. The grain is one row per dashboard group.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.spreadsheet_dashboard_group_id_seq`. |
| sequence | INTEGER | true | Display order index | Used to determine the UI sort order of groups. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo `res_users` table. |
| name | JSONB | false | Group display name | Likely contains localized strings (e.g., `{"en_US": "Sales", "fr_FR": "Ventes"}`). |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on standard Odoo behavior. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on standard Odoo behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- The `name` column is a `JSONB` object; downstream consumers must parse this to extract human-readable strings, typically by selecting the appropriate language key.
- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo database configurations.
- This table contains no explicit soft-delete flag (e.g., `active`), so it is assumed that records are either hard-deleted or that all rows present are currently active.
- `create_uid` and `write_uid` refer to internal Odoo user IDs and will not resolve to meaningful names without joining against the `res_users` table.