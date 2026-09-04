# odoo_ir_act_server_res_partner_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_act_server_res_partner_rel` follows the standard Odoo pattern for a many-to-many join table, where `ir_act_server` refers to server-side actions and `res_partner` refers to the core partner/contact management module.

## Functional process 
This table supports the association between server-side actions and partner records. It is used to manage which specific partners are linked to or triggered by automated server actions within the Odoo framework, facilitating custom business logic execution or notification routing.

## Description
One row in this table represents a single link between a server action and a partner record. It serves as a raw landing copy of the many-to-many relationship table, capturing the association at the grain of one row per unique action-partner pair.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| ir_act_server_id | INTEGER | false | Foreign key to the server action definition | Links to the `ir_act_server` table. |
| res_partner_id | INTEGER | false | Foreign key to the partner record | Links to the `res_partner` table. |

## Keys

- **Primary key (inferred):** The combination of `(ir_act_server_id, res_partner_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `ir_act_server_id` → `ir_act_server.id`: This column references the primary key of the server actions table.
    - `res_partner_id` → `res_partner.id`: This column references the primary key of the partner/contact table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; tracking the creation or modification of these relationships is not possible from this table alone.
- Ensure that joins to `res_partner` or `ir_act_server` handle potential orphans if the source system has inconsistent referential integrity.