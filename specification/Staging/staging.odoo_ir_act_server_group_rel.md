# odoo_ir_act_server_group_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_act_server_group_rel` follows Odoo's internal naming pattern for many-to-many relationship tables, specifically linking server actions (`ir_act_server`) to user groups (`res_groups`).

## Functional process 
This table supports the Odoo security and authorization framework. It manages the many-to-many association between server-side actions and the security groups authorized to execute them, ensuring that only users belonging to specific groups can trigger particular server-side automated actions.

## Description
One row in this table represents a single association between a specific server action and a security group. It is a raw landing copy of an Odoo join table, serving as the bridge to enforce access control policies for automated server-side processes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| act_id | INTEGER | false | Foreign key to the server action definition. | References `ir_act_server.id`. |
| gid | INTEGER | false | Foreign key to the security group definition. | References `res_groups.id`. |

## Keys

- **Primary key (inferred):** The combination of `(act_id, gid)` acts as the composite primary key for this relationship table.
- **Foreign keys (inferred):** 
    - `act_id` → `ir_act_server.id`: Links to the definition of the server action being restricted.
    - `gid` → `res_groups.id`: Links to the security group granted access to the action.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata; this is a pure join table.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine when a relationship was created or modified from this table alone.
- As a raw staging table, it reflects the current state of the Odoo database; historical tracking is not available here.