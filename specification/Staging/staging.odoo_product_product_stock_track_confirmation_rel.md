# odoo_product_product_stock_track_confirmation_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the column names `stock_track_confirmation_id` and `product_product_id` is characteristic of Odoo's automated many-to-many relationship tables, which link core product entities to specific stock tracking confirmation records.

## Functional process 
This table supports the inventory management and supply chain process. It acts as a join table to associate specific product variants with stock tracking confirmation events, likely used to verify that inventory levels or stock movements have been acknowledged or reconciled within the warehouse management module.

## Description
One row in this table represents a single association between a product variant and a stock tracking confirmation record. It serves as a raw, landed junction table in the staging layer, enabling the reconstruction of many-to-many relationships between products and their respective stock tracking audit trails.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_track_confirmation_id | INTEGER | false | Foreign key to the stock tracking confirmation record. | Links to the primary key of the confirmation entity. |
| product_product_id | INTEGER | false | Foreign key to the product variant record. | Links to the primary key of the product variant entity. |

## Keys

- **Primary key (inferred):** Not confidently inferable. This is a junction table; the PK is likely a composite of both columns.
- **Foreign keys (inferred):** 
    - `stock_track_confirmation_id` → `stock_track_confirmation.id` (Inferred from Odoo naming conventions).
    - `product_product_id` → `product_product.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** The combination of `(stock_track_confirmation_id, product_product_id)` is the natural business key for this relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should use the composite of both columns for joins or deduplication.
- As a raw staging table, it may contain orphaned records if the upstream Odoo system has not enforced referential integrity during the export process.
- There are no timestamps or soft-delete flags; this table represents the state of the relationship as captured during the last ingestion run.