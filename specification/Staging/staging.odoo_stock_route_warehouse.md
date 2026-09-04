# odoo_stock_route_warehouse

## Source system
This table originates from Odoo ERP. The naming convention `stock_route_warehouse` is characteristic of Odoo's inventory management module, which uses join tables to map many-to-many relationships between stock routes and warehouse locations.

## Functional process 
This table supports the inventory configuration and logistics routing process. It defines which stock routes (e.g., "Pick-Pack-Ship", "Cross-docking") are enabled or applicable for specific warehouses within the Odoo supply chain module.

## Description
One row in this table represents a single association between a stock route and a warehouse. It serves as a raw landing copy of the Odoo relational link table, used to resolve the many-to-many relationship between inventory routing logic and physical warehouse entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Foreign key to the stock route definition | Links to the primary key of the stock route table. |
| warehouse_id | INTEGER | false | Foreign key to the warehouse definition | Links to the primary key of the warehouse table. |

## Keys

- **Primary key (inferred):** The combination of (`route_id`, `warehouse_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `route_id` → `stock_route.id`: This column references the unique identifier for a stock route configuration.
    - `warehouse_id` → `stock_warehouse.id`: This column references the unique identifier for a warehouse location.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; expect no non-key attributes.
- Ensure joins to upstream tables handle the potential for missing records if the Odoo source system has referential integrity gaps.
- This table contains no timestamps; it represents the current state of configuration as captured during the last ingestion.