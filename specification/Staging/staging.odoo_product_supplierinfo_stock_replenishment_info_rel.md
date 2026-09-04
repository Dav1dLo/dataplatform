# odoo_product_supplierinfo_stock_replenishment_info_rel

## Source system
This table originates from Odoo ERP. The naming convention `product_supplierinfo_stock_replenishment_info_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link core product supplier information to stock replenishment configurations.

## Functional process 
This table supports the inventory replenishment and procurement process. It acts as a bridge between supplier-specific product data (e.g., lead times, vendor prices) and stock replenishment rules, ensuring that the system knows which supplier information applies to specific replenishment triggers.

## Description
One row in this table represents a single association between a product supplier record and a stock replenishment configuration. It is a raw landing copy of a join table used to maintain a many-to-many relationship within the Odoo database schema.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_replenishment_info_id | INTEGER | false | Foreign key to the stock replenishment info entity | Links to the replenishment configuration. |
| product_supplierinfo_id | INTEGER | false | Foreign key to the product supplier info entity | Links to the vendor-specific product details. |

## Keys

- **Primary key (inferred):** The combination of `(stock_replenishment_info_id, product_supplierinfo_id)` is the inferred primary key, as this is a standard Odoo join table structure.
- **Foreign keys (inferred):** 
    - `stock_replenishment_info_id` → `stock_replenishment_info.id` (Inferred from Odoo naming conventions for join tables).
    - `product_supplierinfo_id` → `product_supplierinfo.id` (Inferred from Odoo naming conventions for join tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; queries should expect to perform `JOIN` operations against the parent tables to retrieve meaningful business attributes.
- There are no timestamps or audit columns present in this table; it represents the current state of the relationship as captured during the last ingestion.
- As a join table, this does not contain PII, but it is essential for mapping supply chain logic.