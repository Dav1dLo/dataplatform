# odoo_rule_group_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `rule_group_id` and `group_id` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link security rule groups to user groups.

## Functional process 
This table supports the Odoo access control and security framework. It defines the many-to-many relationship between security rule groups (which define record-level access constraints) and user groups (which define functional access rights), ensuring that the correct security policies are applied to specific user roles.

## Description
One row in this table represents a single association between a specific security rule group and a user group. It serves as a raw landing copy of the Odoo join table, facilitating the reconstruction of the security matrix in downstream analytical layers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| rule_group_id | INTEGER | false | Foreign key to the security rule group definition. | Links to the primary key of the `ir_rule_group` table. |
| group_id | INTEGER | false | Foreign key to the user group definition. | Links to the primary key of the `res_groups` table. |

## Keys

- **Primary key (inferred):** The combination of `(rule_group_id, group_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `rule_group_id` → `ir_rule_group.id`: This column references the security rule definition table.
    - `group_id` → `res_groups.id`: This column references the user group definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this staging extract, so incremental loading based on time is not possible without joining to the parent tables.
- As a raw staging table, it reflects the state of the Odoo database at the time of extraction; it does not track historical changes to security assignments.