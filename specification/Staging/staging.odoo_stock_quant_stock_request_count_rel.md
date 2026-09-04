# odoo_stock_quant_stock_request_count_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link two distinct business entities within the inventory and procurement modules.

## Functional process 
This table supports the inventory management and procurement process by mapping stock quant records (specific inventory items in a location) to stock request counts (records tracking the quantity requested for procurement or replenishment). It facilitates the association between physical inventory availability and pending supply requests.

## Description
One row in this table represents a single link between a stock quant and a stock request count. It serves as a raw junction table in the staging layer, enabling the resolution of many-to-many relationships between inventory levels and procurement requests.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| stock_request_count_id | INTEGER | false | Foreign key to the stock request count entity | Represents the identifier for the procurement request. |
| stock_quant_id | INTEGER | false | Foreign key to the stock quant entity | Represents the identifier for the specific inventory quant. |

## Keys

- **Primary key (inferred):** The combination of `(stock_request_count_id, stock_quant_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `stock_request_count_id` → `staging.odoo_stock_request_count.id` (inferred from naming convention).
    - `stock_quant_id` → `staging.odoo_stock_quant.id` (inferred from naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the foreign keys.
- Ensure that joins to the parent tables handle potential orphans if the staging load process is not perfectly synchronized.
- No sensitive PII or financial data is contained within this table.