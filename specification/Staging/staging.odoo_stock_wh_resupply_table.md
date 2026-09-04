# odoo_stock_wh_resupply_table

## Source system
This table originates from Odoo ERP, specifically the Inventory/Warehouse management module. The naming convention `odoo_stock_wh_resupply` is characteristic of Odoo's internal database schema for managing inter-warehouse replenishment routes.

## Functional process 
This table supports the warehouse replenishment process, defining the supply chain relationships between different warehouse locations. It facilitates the logic for automated stock transfers where one warehouse acts as a supplier to another, ensuring inventory availability across a multi-site distribution network.

## Description
Each row represents a defined resupply relationship between two warehouse entities. It acts as a raw landed mapping table that dictates which warehouse (the supplier) is responsible for replenishing stock for another warehouse (the supplied).

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| supplied_wh_id | INTEGER | false | Unique identifier of the warehouse receiving the stock. | Foreign key to the warehouse master table. |
| supplier_wh_id | INTEGER | false | Unique identifier of the warehouse providing the stock. | Foreign key to the warehouse master table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of `(supplied_wh_id, supplier_wh_id)`.
- **Foreign keys (inferred):** 
    - `supplied_wh_id` → `stock_warehouse.id`: This column identifies the destination warehouse in the replenishment route.
    - `supplier_wh_id` → `stock_warehouse.id`: This column identifies the source warehouse in the replenishment route.
- **Natural keys (inferred):** The combination of `(supplied_wh_id, supplier_wh_id)` acts as the business key defining a unique resupply route.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it represents the current state of replenishment configurations.
- The table is highly denormalized; it is a mapping table and does not contain descriptive attributes of the warehouses themselves.
- Ensure joins to the master warehouse table are handled carefully, as both columns reference the same entity type.