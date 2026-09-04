# odoo_spreadsheet_dashboard_share

## Source system
This table originates from Odoo ERP, specifically the spreadsheet module. The naming convention `odoo_spreadsheet_dashboard_share` and the use of `create_uid`/`write_uid` audit columns are characteristic of Odoo's internal ORM structure for tracking shared dashboard access tokens.

## Functional process 
This table supports the "Dashboard Sharing" business process, which allows users to generate secure, tokenized URLs to share spreadsheet dashboards with external or internal stakeholders. It manages the lifecycle of these access tokens, tracking who created or modified the share link and when.

## Description
One row in this table represents a single shared access instance for a specific spreadsheet dashboard. It acts as a raw landed copy of the Odoo `spreadsheet.dashboard.share` model, capturing the mapping between a dashboard and its unique security token.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `spreadsheet_dashboard_share_id_seq`. |
| dashboard_id | INTEGER | false | Foreign key to the dashboard | Links to the parent dashboard definition. |
| create_uid | INTEGER | true | Creator user ID | References the user who generated the share link. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated the share settings. |
| access_token | VARCHAR | false | Unique security token | Used in the URL to authenticate access to the dashboard. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server time (UTC). |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in server time (UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `dashboard_id` → `staging.odoo_spreadsheet_dashboard.id` (Inferred based on Odoo naming conventions for relational fields).
    - `create_uid` → `staging.odoo_res_users.id` (Inferred based on Odoo standard audit column naming).
    - `write_uid` → `staging.odoo_res_users.id` (Inferred based on Odoo standard audit column naming).
- **Natural keys (inferred):** 
    - `access_token` (This is the unique identifier for the share session used by the application).

## Caveats for downstream consumers

- **Sensitive Data:** The `access_token` column acts as a credential; ensure it is masked or excluded in non-production environments to prevent unauthorized dashboard access.
- **Timezone:** Timestamps are assumed to be in UTC, consistent with Odoo's standard database storage behavior.
- **Data Retention:** This table is a raw staging copy; it does not explicitly indicate soft-delete status, so assume all records are active unless a `deleted` or `active` flag is added in future schema versions.
- **Precision:** `VARCHAR` length is not explicitly defined in the source metadata; downstream systems should allocate sufficient buffer (e.g., 255 characters) for the `access_token`.