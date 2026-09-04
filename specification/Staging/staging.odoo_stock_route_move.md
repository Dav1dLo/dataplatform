# odoo_stock_route_move

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_route_move` and the use of `_id` suffixes for relational keys are characteristic of Odoo's PostgreSQL-based backend schema, specifically within the Inventory (Stock) module.

## Functional process 
This table supports the inventory routing and logistics process. It acts as a link table (many-to-many relationship) between stock moves and defined inventory routes, ensuring that specific stock movements are associated with the correct logistical paths or procurement rules configured in the system.

## Description
One row in this table represents a single association between a specific stock movement and an inventory route. It serves as a raw landed copy of the Odoo join table, capturing the mapping required to track how inventory movements are routed through the warehouse.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| move_id | INTEGER | false | Foreign key to the stock move | References the primary key of the stock move record. |
| route_id | INTEGER | false | Foreign key to the stock route | References the primary key of the stock route definition. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`move_id`, `route_id`).
- **Foreign keys (inferred):** 
    - `move_id` → `stock_move.id`: Links to the specific inventory movement record.
    - `route_id` → `stock_route.id`: Links to the specific routing configuration.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; expect many-to-many relationships between moves and routes.
- No audit timestamps (e.g., `create_date`, `write_date`) are present in this staging extract; temporal analysis of these associations is not possible without joining to the parent tables.
- Ensure inner joins are used when filtering for active associations, as this table contains only the relational mapping.