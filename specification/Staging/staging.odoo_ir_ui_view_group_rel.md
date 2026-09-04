# odoo_ir_ui_view_group_rel

## Source system
This table originates from Odoo ERP. The naming convention `ir_ui_view_group_rel` is characteristic of Odoo's internal metadata tables, specifically those managing many-to-many relationships between user interface views (`ir.ui.view`) and security groups (`res.groups`).

## Functional process 
This table supports the access control and authorization process for the Odoo user interface. It defines which security groups are granted access to specific UI views, ensuring that users only see the interface elements (such as menus, forms, or specific fields) permitted by their assigned roles.

## Description
One row in this table represents a single association between a specific UI view and a security group. It acts as a join table for the many-to-many relationship between the `ir.ui.view` and `res.groups` entities. As a staging table, it provides a raw, un-transformed copy of the relationship mapping as it exists in the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| view_id | INTEGER | false | Foreign key to the UI view definition | References `ir_ui_view.id`. |
| group_id | INTEGER | false | Foreign key to the security group definition | References `res_groups.id`. |

## Keys

- **Primary key (inferred):** The composite key `(view_id, group_id)` is the inferred primary key, as this is a standard join table structure.
- **Foreign keys (inferred):** 
    - `view_id` → `ir_ui_view.id`: This column maps to the primary identifier of the view definition table.
    - `group_id` → `res_groups.id`: This column maps to the primary identifier of the security group table.
- **Natural keys (inferred):** Not confidently inferable; the relationship is defined by the surrogate IDs of the parent entities.

## Caveats for downstream consumers

- This table contains no descriptive attributes, only relationship identifiers; it must be joined with `ir_ui_view` and `res_groups` to be meaningful.
- There are no timestamps or audit columns present in this table; it reflects the current state of the Odoo configuration.
- As a join table, expect high cardinality relative to the number of views and groups defined in the system.
- Ensure that joins to parent tables account for potential missing records if the source system has undergone partial data migration or cleanup.