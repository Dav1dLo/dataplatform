# odoo_picking_type_favorite_user_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names `picking_type` and `user` is characteristic of Odoo's internal many-to-many relationship tables used to manage user-specific UI preferences or access configurations.

## Functional process 
This table supports the "Inventory Management" or "Warehouse Operations" process. It tracks user-specific preferences for picking types, allowing individual users to mark specific warehouse operation types (e.g., "Receipts", "Internal Transfers", "Pickings") as "favorites" for quicker access within the Odoo interface.

## Description
One row in this table represents a single association between a user and a picking type, indicating that the user has marked that specific picking type as a favorite. As a staging table, it provides a raw, landed copy of the Odoo many-to-many join table, capturing the link between the `res.users` and `stock.picking.type` models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| picking_type_id | INTEGER | false | Foreign key to the picking type definition | References the primary key of the `stock_picking_type` table. |
| user_id | INTEGER | false | Foreign key to the user definition | References the primary key of the `res_users` table. |

## Keys

- **Primary key (inferred):** The combination of (`picking_type_id`, `user_id`) forms the composite primary key.
- **Foreign keys (inferred):** 
    - `picking_type_id` → `staging.stock_picking_type.id`: Links to the specific warehouse operation type.
    - `user_id` → `staging.res_users.id`: Links to the specific system user.
- **Natural keys (inferred):** The tuple (`picking_type_id`, `user_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes other than the two foreign keys.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this staging extract, making it impossible to determine when the favorite relationship was established or last modified.
- Ensure that joins to `res_users` or `stock_picking_type` handle potential missing records if the upstream Odoo instance has referential integrity gaps.
- No PII is present in this table, as it only contains integer identifiers.