# odoo_mrp_production_mrp_production_backorder_rel

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `_rel` is a standard pattern used by the Odoo ORM to represent many-to-many relationship tables in the underlying PostgreSQL database.

## Functional process 
This table supports the manufacturing backorder process. It links backorder records to their parent production orders, allowing the system to track which specific production orders were split into backorders when the original manufacturing order could not be completed in a single batch.

## Description
One row in this table represents a single association between a manufacturing backorder record and a production order record. It serves as a raw junction table in the staging layer, facilitating the many-to-many relationship required by the Odoo MRP data model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_production_backorder_id | INTEGER | false | Foreign key to the backorder record | Links to the primary key of the backorder entity. |
| mrp_production_id | INTEGER | false | Foreign key to the production order | Links to the primary key of the manufacturing order. |

## Keys

- **Primary key (inferred):** The composite of (`mrp_production_backorder_id`, `mrp_production_id`).
- **Foreign keys (inferred):** 
    - `mrp_production_backorder_id` → `mrp_production_backorder.id` (Inferred from Odoo naming convention).
    - `mrp_production_id` → `mrp_production.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship identifiers.
- There are no timestamps or soft-delete flags; the existence of a row implies the relationship is active.
- Ensure joins to parent tables handle the potential for multiple backorders per production order.