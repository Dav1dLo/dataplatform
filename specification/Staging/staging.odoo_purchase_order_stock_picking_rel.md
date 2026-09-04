# odoo_purchase_order_stock_picking_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the column pattern linking `purchase_order_id` to `stock_picking_id` are characteristic of Odoo's internal many-to-many relationship tables used to associate purchase orders with their corresponding inventory movements (pickings).

## Functional process 
This table supports the procurement and inventory management process, specifically the link between purchasing and logistics. It maps purchase orders to the specific stock picking operations (receipts) generated to fulfill those orders, enabling traceability from the procurement request to the physical arrival of goods.

## Description
One row in this table represents a single association between a purchase order and a stock picking record. It serves as a raw junction table in the staging layer, facilitating the resolution of the many-to-many relationship between the purchasing and inventory modules.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_id | INTEGER | false | Foreign key to the purchase order | References the primary key of the purchase order table. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking | References the primary key of the stock picking table. |

## Keys

- **Primary key (inferred):** The composite key `(purchase_order_id, stock_picking_id)` is the inferred primary key, as this is a standard junction table structure.
- **Foreign keys (inferred):** 
    - `purchase_order_id` → `staging.purchase_order.id` (inferred based on Odoo standard schema).
    - `stock_picking_id` → `staging.stock_picking.id` (inferred based on Odoo standard schema).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent tables for ingestion metadata.
- Ensure inner joins are used when resolving these relationships to avoid orphaned records if the source system has inconsistent referential integrity.