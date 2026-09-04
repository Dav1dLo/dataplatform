# odoo_stock_route_packaging

## Source system
This table originates from Odoo ERP, specifically the Inventory/Warehouse management module. The naming convention `odoo_stock_route_packaging` is characteristic of Odoo's relational mapping tables that link stock routes to specific packaging configurations.

## Functional process 
This table supports the inventory routing and logistics process. It defines the many-to-many relationship between stock routes (which dictate how products move through a warehouse) and packaging types (which dictate how products are contained or bundled), ensuring that specific packaging constraints are applied to specific routing workflows.

## Description
One row in this table represents a single association between a stock route and a packaging definition. It serves as a raw landing copy of the Odoo join table, capturing the link required to validate packaging availability within defined inventory routes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| "route_id" | INTEGER | false | Foreign key to the stock route definition | Links to the primary key of the stock route table. |
| "packaging_id" | INTEGER | false | Foreign key to the packaging definition | Links to the primary key of the packaging table. |

## Keys

- **Primary key (inferred):** ("route_id", "packaging_id") — This is a composite key representing the unique relationship between the two entities.
- **Foreign keys (inferred):** 
    - "route_id" → "odoo_stock_route"."id" (Inferred from Odoo standard naming conventions).
    - "packaging_id" → "odoo_product_packaging"."id" (Inferred from Odoo standard naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this staging extract; incremental loading logic cannot rely on `updated_at` fields.
- Ensure referential integrity checks are performed against the parent `stock_route` and `product_packaging` tables, as this staging table may contain orphaned IDs if the upstream extraction process is not synchronized.