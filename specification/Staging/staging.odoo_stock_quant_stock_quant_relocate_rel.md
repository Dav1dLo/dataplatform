# odoo_stock_quant_stock_quant_relocate_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_quant_stock_quant_relocate_rel` is characteristic of Odoo's internal ORM-generated join tables, which manage many-to-many relationships between business objects—in this case, linking stock quant relocation events to specific stock quants.

## Functional process 
This table supports the inventory management and warehouse operations process. It facilitates the tracking of stock movements by mapping specific inventory quants (the smallest unit of stock tracking in Odoo) to relocation requests or relocation batches, ensuring that inventory adjustments or transfers are correctly associated with their source quant records.

## Description
One row in this table represents a single association between a stock quant relocation record and a specific stock quant. It serves as a raw, junction-table copy from the Odoo database, used to resolve the many-to-many relationship between inventory relocation events and individual stock quants.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_quant_relocate_id | INTEGER | false | Foreign key to the relocation event | Links to the primary key of the `stock_quant_relocate` table. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant | Links to the primary key of the `stock_quant` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable as a single column; likely a composite primary key on (`stock_quant_relocate_id`, `stock_quant_id`).
- **Foreign keys (inferred):** 
    - `stock_quant_relocate_id` → `stock_quant_relocate.id`: This column references the parent relocation event record.
    - `stock_quant_id` → `stock_quant.id`: This column references the specific inventory quant being relocated.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; expect high cardinality and frequent joins to the parent tables.
- There is no audit timestamp or soft-delete flag present in this table; it reflects the current state of the relationship as captured during the last ingestion.
- Ensure that joins to `stock_quant` and `stock_quant_relocate` are handled as inner joins if you only require records with valid, existing associations.