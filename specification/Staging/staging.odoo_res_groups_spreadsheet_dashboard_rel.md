# odoo_res_groups_spreadsheet_dashboard_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_groups_spreadsheet_dashboard_rel` is characteristic of Odoo's internal ORM-generated many-to-many relationship tables, which link security groups (`res_groups`) to specific spreadsheet dashboard configurations.

## Functional process 
This table supports the Odoo Access Control List (ACL) management for the Spreadsheet module. It defines which user security groups are authorized to view or edit specific dashboard entities, ensuring that dashboard visibility is restricted based on the user's assigned roles within the ERP.

## Description
One row represents a single association between a security group and a spreadsheet dashboard. This is a junction table used to resolve a many-to-many relationship between dashboard records and group-based permissions. It serves as a raw landed copy of the Odoo database schema in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| spreadsheet_dashboard_id | INTEGER | false | Foreign key to the spreadsheet dashboard record | Links to the primary key of the dashboard definition. |
| res_groups_id | INTEGER | false | Foreign key to the security group record | Links to the primary key of the Odoo `res_groups` table. |

## Keys

- **Primary key (inferred):** The combination of `(spreadsheet_dashboard_id, res_groups_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `spreadsheet_dashboard_id` → `spreadsheet_dashboard.id` (Inferred from Odoo naming conventions).
    - `res_groups_id` → `res_groups.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table reflects the current state of the relationship as captured during the last ingestion.
- Ensure that joins to `res_groups` and `spreadsheet_dashboard` handle potential orphans if the upstream source has referential integrity gaps.