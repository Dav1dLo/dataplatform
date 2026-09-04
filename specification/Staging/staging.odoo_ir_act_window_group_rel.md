# odoo_ir_act_window_group_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_act_window_group_rel` is characteristic of Odoo's internal metadata tables, specifically those managing the many-to-many relationship between window actions (`ir.actions.act_window`) and user groups (`res.groups`).

## Functional process 
This table supports the security and access control configuration process within Odoo. It defines which user groups are authorized to access specific window actions, effectively acting as a junction table that enforces UI visibility and menu access permissions based on user roles.

## Description
One row in this table represents a single association between a specific window action and a user group. It is a raw landed copy of a join table used to map security groups to UI actions, serving as the foundation for downstream access control reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| act_id | INTEGER | false | Foreign key to the window action definition | References the primary key of the `ir_act_window` table. |
| gid | INTEGER | false | Foreign key to the user group definition | References the primary key of the `res_groups` table. |

## Keys

- **Primary key (inferred):** The combination of (`act_id`, `gid`) forms the composite primary key.
- **Foreign keys (inferred):** 
    - `act_id` → `ir_act_window.id`: This column links to the action definition table.
    - `gid` → `res_groups.id`: This column links to the security group definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp or soft-delete flag present; this represents the current state of the Odoo security configuration as captured during the last ingestion.
- Ensure joins to `ir_act_window` and `res_groups` are handled as inner joins if you only require active, valid associations.