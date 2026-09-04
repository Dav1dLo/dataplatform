# odoo_stock_valuation_layer_stock_valuation_layer_revaluation_re

## Source system
This table originates from Odoo ERP. The naming convention `stock_valuation_layer_revaluation_re` is characteristic of Odoo's internal ORM-to-database mapping, specifically relating to the inventory valuation module where stock revaluations are linked to specific valuation layers.

## Functional process 
This table supports the Inventory Valuation and Cost Accounting process. It acts as a join or association table that links specific stock valuation layers to revaluation events, ensuring that changes in product costs or inventory values are correctly attributed to the underlying stock movements.

## Description
One row in this table represents a single association between a stock valuation layer and a revaluation record. It serves as a raw landing copy of the Odoo relational link, used to maintain the integrity of cost adjustments within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_valuation_layer_revaluation_id | INTEGER | false | Foreign key to the revaluation event | Links to the parent revaluation record. |
| stock_valuation_layer_id | INTEGER | false | Foreign key to the valuation layer | Links to the specific stock valuation layer being adjusted. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(stock_valuation_layer_revaluation_id, stock_valuation_layer_id)`.
- **Foreign keys (inferred):** 
    - `stock_valuation_layer_revaluation_id` → `stock_valuation_layer_revaluation.id` (Guess: links to the revaluation header).
    - `stock_valuation_layer_id` → `stock_valuation_layer.id` (Guess: links to the specific inventory valuation record).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a link/association table; it contains no business data other than the relationship between two entities.
- Expect high cardinality if revaluation events affect many stock layers.
- No audit timestamps (e.g., `create_date`, `write_date`) are present in this specific extract; rely on the parent tables for temporal context.