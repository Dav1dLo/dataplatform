# odoo_stock_picking_backorder_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_picking_backorder_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link backorder confirmation records to the specific stock picking operations they affect.

## Functional process 
This table supports the inventory management and order fulfillment process. It tracks the relationship between a backorder confirmation event and the individual stock picking records (shipments or internal transfers) that were split into a backorder due to partial availability of goods.

## Description
One row represents a single association between a backorder confirmation record and a specific stock picking operation. It serves as a raw landing copy of the Odoo join table, facilitating the reconstruction of backorder chains within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_backorder_confirmation_id | INTEGER | false | Foreign key to the backorder confirmation record | Links to the parent backorder event. |
| stock_picking_id | INTEGER | false | Foreign key to the stock picking record | Links to the specific picking operation involved. |

## Keys

- **Primary key (inferred):** Not confidently inferable; this is a join table and likely relies on a composite key of `(stock_backorder_confirmation_id, stock_picking_id)`.
- **Foreign keys (inferred):** 
    - `stock_backorder_confirmation_id` → `stock_backorder_confirmation.id`: This column references the header record for the backorder process.
    - `stock_picking_id` → `stock_picking.id`: This column references the specific inventory movement record.
- **Natural keys (inferred):** The combination of `(stock_backorder_confirmation_id, stock_picking_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table contains no timestamps or audit fields; it represents a snapshot of the relationship state.
- There is no soft-delete flag; records are typically inserted or removed by the Odoo ORM as the backorder state changes.
- Ensure joins to `stock_picking` are handled carefully, as this table only maps the relationship and does not contain the picking status or quantities.