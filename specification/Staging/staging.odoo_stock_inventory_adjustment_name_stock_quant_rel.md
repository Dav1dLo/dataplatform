# odoo_stock_inventory_adjustment_name_stock_quant_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names `stock_inventory_adjustment_name` and `stock_quant` indicates this is a standard Odoo many-to-many join table used to link inventory adjustment records to specific stock quantity records.

## Functional process 
This table supports the inventory management and stock reconciliation process. It maps specific inventory adjustment events (where physical counts are reconciled against system records) to the underlying stock quant records that were affected or included in that adjustment.

## Description
One row represents a single association between an inventory adjustment record and a specific stock quantity (quant) record. This is a junction table in the staging layer, providing a raw, un-transformed link between inventory adjustment headers and the granular stock quants they reference.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_inventory_adjustment_name_id | INTEGER | false | Foreign key to the inventory adjustment record | Links to the parent adjustment event. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant record | Links to the specific stock quantity being adjusted. |

## Keys

- **Primary key (inferred):** The combination of `(stock_inventory_adjustment_name_id, stock_quant_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_inventory_adjustment_name_id` → `staging.stock_inventory_adjustment_name.id` (Inferred from Odoo naming conventions).
    - `stock_quant_id` → `staging.stock_quant.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship between the two entities.
- Ensure that joins to parent tables handle potential orphans if the staging data is not fully synchronized.
- No timestamps or audit columns are present in this table; rely on the parent tables for ingestion metadata.