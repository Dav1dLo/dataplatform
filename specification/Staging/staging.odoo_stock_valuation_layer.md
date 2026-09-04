# odoo_stock_valuation_layer

## Source system
This table originates from Odoo ERP, specifically the Inventory/Warehouse management module. The naming convention (`stock_valuation_layer`, `stock_move_id`, `product_id`) is characteristic of Odoo's internal data model for tracking real-time inventory accounting and valuation.

## Functional process 
This table supports the inventory valuation and accounting process. It records the financial impact of stock movements, tracking how inventory value changes as products enter or leave the warehouse, and links these movements to corresponding accounting entries (`account_move_id`) to ensure the general ledger reflects current stock assets.

## Description
One row in this table represents a single valuation event for a specific product, capturing the quantity moved, the unit cost, and the resulting change in inventory value. This is a raw landed copy of the Odoo `stock.valuation.layer` model, serving as the primary source for calculating inventory asset balances and cost of goods sold (COGS) in downstream reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| company_id | INTEGER | false | Company identifier | Links the record to a specific legal entity. |
| product_id | INTEGER | false | Product identifier | Foreign key to the product master table. |
| categ_id | INTEGER | true | Product category identifier | Used for grouping inventory valuation reports. |
| stock_valuation_layer_id | INTEGER | true | Parent valuation layer ID | Used for recursive valuation structures or adjustments. |
| stock_move_id | INTEGER | true | Stock move identifier | Links to the physical inventory movement record. |
| account_move_id | INTEGER | true | Accounting move identifier | Links to the corresponding journal entry. |
| account_move_line_id | INTEGER | true | Accounting move line identifier | Links to the specific line item in the journal entry. |
| lot_id | INTEGER | true | Lot/Serial number identifier | Identifies the specific batch of the product. |
| create_uid | INTEGER | true | Creator user ID | Audit trail for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit trail for record updates. |
| description | VARCHAR | true | Valuation description | Human-readable context for the valuation event. |
| quantity | NUMERIC | true | Quantity moved | The amount of product involved in this valuation. |
| unit_cost | NUMERIC | true | Unit cost | The cost per unit at the time of valuation. |
| value | NUMERIC | true | Total value | The total financial impact (quantity * unit_cost). |
| remaining_qty | NUMERIC | true | Remaining quantity | The stock balance after this movement. |
| remaining_value | NUMERIC | true | Remaining value | The total asset value after this movement. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| price_diff_value | DOUBLE PRECISION | true | Price difference | Variance between expected and actual cost. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `product_id` → `product_product.id` (Standard Odoo relation for product identification)
    - `stock_move_id` → `stock_move.id` (Links to the physical movement event)
    - `account_move_id` → `account_move.id` (Links to the financial ledger entry)
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Data Integrity:** This table is a raw dump; `remaining_qty` and `remaining_value` are calculated fields in Odoo and may be subject to recalculation logic during inventory revaluation events.
- **Precision:** `NUMERIC` types do not have explicit scale/precision defined in the source schema; assume standard financial precision (e.g., 16, 4) but verify against actual data samples.
- **Soft Deletes:** Odoo typically does not use soft deletes for valuation layers; records are generally immutable once posted to the ledger.