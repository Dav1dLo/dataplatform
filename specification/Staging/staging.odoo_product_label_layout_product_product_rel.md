# odoo_product_label_layout_product_product_rel

## Source system
This table originates from Odoo ERP. The naming convention `<table>_<table_a>_<table_b>_rel` is the standard pattern used by the Odoo ORM to manage many-to-many relationship tables in its PostgreSQL backend.

## Functional process 
This table supports the product label printing process. It acts as a join table linking specific product label layout configurations to the individual product variants that are included in those layouts, enabling batch printing of labels for selected products.

## Description
One row in this table represents a single association between a product label layout and a product variant. It is a raw landing copy of an Odoo many-to-many link table, serving as the bridge to resolve the relationship between label configurations and the products they apply to.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| product_label_layout_id | INTEGER | false | Foreign key to the label layout definition | Links to the parent layout configuration. |
| product_product_id | INTEGER | false | Foreign key to the product variant | Links to the specific product variant being labeled. |

## Keys

- **Primary key (inferred):** The composite key `(product_label_layout_id, product_product_id)`.
- **Foreign keys (inferred):** 
    - `product_label_layout_id` → `product_label_layout.id`: This column references the primary key of the layout configuration table.
    - `product_product_id` → `product_product.id`: This column references the primary key of the product variant table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; incremental loading logic should rely on the source system's transaction logs if full-table refreshes are not feasible.
- As an Odoo `_rel` table, it is managed automatically by the ORM; expect rows to be deleted and re-inserted during layout updates rather than updated in place.