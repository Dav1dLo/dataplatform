# odoo_stock_route_product

## Source system
This table originates from Odoo ERP. The naming convention `stock_route_product` is characteristic of Odoo's inventory management module, which uses join tables to map many-to-many relationships between stock routes and product records.

## Functional process 
This table supports the inventory routing and logistics configuration process. It defines which specific products are associated with which stock routes (e.g., "Make to Order", "Dropship", or "Buy"), enabling the system to determine the correct procurement or movement strategy for a given product.

## Description
One row represents a single association between a product and a stock route. This is a raw landing of a join table, serving as the bridge to resolve the many-to-many relationship between inventory products and their applicable routing rules within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Foreign key to the stock route definition | Links to the primary key of the stock route table. |
| product_id | INTEGER | false | Foreign key to the product definition | Links to the primary key of the product master table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of (`route_id`, `product_id`).
- **Foreign keys (inferred):** 
    - `route_id` → `stock_route.id`: Guessed based on Odoo standard schema naming conventions.
    - `product_id` → `product_product.id`: Guessed based on Odoo standard schema naming conventions.
- **Natural keys (inferred):** The combination of (`route_id`, `product_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no audit timestamps (e.g., `created_at` or `updated_at`) present in this staging extract, making it impossible to determine the recency of the relationship without joining to parent tables.
- This table does not implement soft deletes; it represents the current state of the relationship as extracted from the source.