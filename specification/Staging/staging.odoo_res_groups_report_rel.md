# odoo_res_groups_report_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_groups_report_rel` is characteristic of Odoo's internal ORM-generated many-to-many relationship tables, which link security groups (`res_groups`) to report definitions (`ir_actions_report`).

## Functional process 
This table supports the Access Control List (ACL) management process within Odoo. It defines which user groups have permission to access or generate specific system reports, ensuring that sensitive business documents are restricted to authorized roles.

## Description
Each row represents a single association between a specific user group and a report definition. This is a raw landing of a join table used to enforce report-level security permissions within the Odoo application.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| uid | INTEGER | false | Foreign key to the user group | Represents the `id` of the `res_groups` record. |
| gid | INTEGER | false | Foreign key to the report definition | Represents the `id` of the `ir_actions_report` record. |

## Keys

- **Primary key (inferred):** The combination of `(uid, gid)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `uid → res_groups.id`: This column links to the Odoo groups table.
    - `gid → ir_actions_report.id`: This column links to the Odoo report actions table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags; this represents the current state of the relationship as captured during the last ingestion.
- Ensure joins to `res_groups` and `ir_actions_report` are handled as inner joins if you only require active, valid associations.