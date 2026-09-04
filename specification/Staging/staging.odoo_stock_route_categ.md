# odoo_stock_route_categ

## Source system
This table originates from Odoo ERP. The naming convention `stock_route_categ` is characteristic of Odoo's inventory module, which manages routing rules and product categories.

## Functional process 
This table supports the inventory management and logistics process by defining the relationship between stock routes and product categories. It facilitates the mapping of specific product categories to designated routing paths within the warehouse management system.

## Description
One row in this table represents a many-to-many association between a stock route and a product category. It serves as a raw landing copy of the Odoo join table, used to determine which routing logic applies to products within a specific category.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| route_id | INTEGER | false | Foreign key to the stock route definition | References the primary key in the `stock_route` table. |
| categ_id | INTEGER | false | Foreign key to the product category definition | References the primary key in the `product_category` table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`route_id`, `categ_id`).
- **Foreign keys (inferred):** 
    - `route_id` → `stock_route.id`: Links to the specific inventory route configuration.
    - `categ_id` → `product_category.id`: Links to the specific product category hierarchy.
- **Natural keys (inferred):** The combination of (`route_id`, `categ_id`) acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on `updated_at` or `created_at` fields.
- Ensure that joins to `stock_route` and `product_category` are handled as inner joins if you only require valid, active mappings.