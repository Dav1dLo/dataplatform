# odoo_stock_move_line_consume_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_stock_move_line_consume_rel` indicates a many-to-many relationship table (often suffixed with `_rel` in Odoo's ORM) linking stock move lines used in production consumption processes.

## Functional process 
This table supports the manufacturing and inventory management process, specifically tracking the consumption of raw materials or components against finished goods production. It maps which specific stock move lines (components) were consumed to produce specific stock move lines (finished products).

## Description
One row in this table represents a single link between a consumed stock move line and a produced stock move line. As a staging table, it provides a raw, normalized view of the many-to-many relationship defined in the Odoo database, facilitating the reconstruction of production consumption traceability.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| consume_line_id | INTEGER | false | Foreign key to the consumed stock move line | References the component being used. |
| produce_line_id | INTEGER | false | Foreign key to the produced stock move line | References the finished or semi-finished product. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`consume_line_id`, `produce_line_id`).
- **Foreign keys (inferred):** 
    - `consume_line_id` → `stock_move_line.id`: Guessed based on Odoo naming conventions for stock movement tracking.
    - `produce_line_id` → `stock_move_line.id`: Guessed based on Odoo naming conventions for stock movement tracking.
- **Natural keys (inferred):** The combination of (`consume_line_id`, `produce_line_id`) acts as the unique business identifier for this relationship.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it is a pure join table.
- There are no sensitive PII columns in this table.
- As a relationship table, it does not contain soft-delete flags; if a link is removed in the source system, the row is typically deleted.
- Ensure joins to `stock_move_line` are handled carefully, as Odoo IDs are often scoped to specific database instances.