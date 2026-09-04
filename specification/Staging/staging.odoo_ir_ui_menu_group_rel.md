# odoo_ir_ui_menu_group_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_ui_menu_group_rel` is characteristic of Odoo's internal ORM (Object-Relational Mapping) layer, specifically representing a many-to-many relationship table between user interface menus and security groups.

## Functional process 
This table supports the Access Control List (ACL) management process within Odoo. It defines which security groups are granted visibility or access to specific menu items in the application's navigation structure, ensuring that users only see the modules and views permitted by their assigned roles.

## Description
One row in this table represents a single association between a specific UI menu item and a security group. It acts as a join table to facilitate the many-to-many relationship required for Odoo's menu-level permission system. As a staging table, it provides a raw, landed copy of the Odoo database's relational link table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| menu_id | INTEGER | false | Foreign key to the menu definition | References the `ir_ui_menu` table. |
| gid | INTEGER | false | Foreign key to the security group | References the `res_groups` table. |

## Keys

- **Primary key (inferred):** The composite key `(menu_id, gid)`.
- **Foreign keys (inferred):** 
    - `menu_id` → `ir_ui_menu.id`: This column links to the menu definition table in Odoo.
    - `gid` → `res_groups.id`: This column links to the security group definition table in Odoo.
- **Natural keys (inferred):** The combination of `menu_id` and `gid` acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; downstream models should use the composite `(menu_id, gid)` for joins.
- There are no timestamps or audit columns present; it is impossible to determine when a specific permission was granted or revoked from this table alone.
- This is a pure link table; it contains no descriptive attributes, only identifiers.
- Ensure that joins to `ir_ui_menu` and `res_groups` account for potential missing records if the source system has undergone partial data extraction.