# odoo_spreadsheet_dashboard

## Source system
This table originates from Odoo ERP, specifically the spreadsheet or dashboarding module. The presence of columns like `create_uid`, `write_uid`, `company_id`, and `JSONB` fields for localized names is characteristic of Odoo's internal ORM structure for managing dashboard configurations.

## Functional process 
This table supports the configuration and management of spreadsheet-based dashboards within the Odoo ecosystem. It tracks the organizational grouping, publication status, and administrative metadata (creation/modification logs) for dashboard assets used in business reporting and data visualization.

## Description
One row represents a single spreadsheet dashboard configuration record. It serves as a raw landed copy of the Odoo dashboard metadata, capturing the dashboard's identity, its association with a company, and its current publication state.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.spreadsheet_dashboard_id_seq`. |
| dashboard_group_id | INTEGER | false | Foreign key to dashboard group | Links the dashboard to a specific category or group. |
| sequence | INTEGER | true | Display order | Used for sorting dashboards in the UI. |
| company_id | INTEGER | true | Owning company ID | Multi-company context identifier. |
| create_uid | INTEGER | true | Creator user ID | References the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the record. |
| sample_dashboard_file_path | VARCHAR | true | File system path | Path to the template or sample file associated with the dashboard. |
| name | JSONB | false | Dashboard name | Localized name stored as a JSON object. |
| is_published | BOOLEAN | true | Publication status | Flag indicating if the dashboard is visible to end users. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dashboard_group_id` → `staging.odoo_spreadsheet_dashboard_group.id` (Inferred from standard Odoo naming conventions for relational links).
    - `company_id` → `staging.odoo_res_company.id` (Standard Odoo pattern for multi-company isolation).
    - `create_uid` / `write_uid` → `staging.odoo_res_users.id` (Standard Odoo pattern for audit trails).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column contains JSONB data; ensure queries use appropriate PostgreSQL operators (e.g., `->>`) to extract values.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume rows are physically removed if deleted in the source.
- **Data Sensitivity:** `create_uid` and `write_uid` link to user records; ensure access controls are applied if joining with user identity tables.