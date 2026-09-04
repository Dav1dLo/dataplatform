# odoo_ir_embedded_actions_res_groups_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_embedded_actions_res_groups_rel` follows the standard Odoo pattern for a many-to-many join table, where `ir_embedded_actions` represents the embedded action definitions and `res_groups` represents the security access groups within the Odoo framework.

## Functional process 
This table supports the Odoo security and authorization framework. It manages the many-to-many relationship between embedded actions (UI components or specific action triggers) and user security groups, determining which user groups have permission to access or view specific embedded actions within the application interface.

## Description
One row in this table represents a single association between an embedded action and a security group, granting the group access to that action. It serves as a raw landing of the Odoo join table, capturing the link between action definitions and access control lists at the grain of one row per unique action-group pair.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| ir_embedded_actions_id | INTEGER | false | Foreign key to the embedded action definition | Links to the primary key of the `ir_embedded_actions` table. |
| res_groups_id | INTEGER | false | Foreign key to the security group definition | Links to the primary key of the `res_groups` table. |

## Keys

- **Primary key (inferred):** The composite key `(ir_embedded_actions_id, res_groups_id)` is the inferred primary key, as this is a standard join table structure in Odoo.
- **Foreign keys (inferred):** 
    - `ir_embedded_actions_id` → `ir_embedded_actions.id`: This column references the specific action being restricted.
    - `res_groups_id` → `res_groups.id`: This column references the security group being granted access.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; it reflects the current state of the relationship as captured during the last ingestion.
- Queries should be performed using inner joins to the parent tables (`ir_embedded_actions` and `res_groups`) to retrieve meaningful business context.
- As a join table, it does not contain PII or sensitive data directly, but it defines the security posture of the application.