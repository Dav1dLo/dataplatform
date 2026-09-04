# odoo_mrp_production_picking_label_type_rel

## Source system
This table originates from Odoo ERP. The naming convention `mrp_production_id` and the `_rel` suffix are characteristic of Odoo's internal PostgreSQL schema, which uses join tables to manage many-to-many relationships between manufacturing production orders and custom picking label configurations.

## Functional process 
This table supports the manufacturing execution process, specifically the link between production orders and the specific label types required for picking operations. It ensures that when a manufacturing order is processed, the system knows which label templates or types are associated with the materials or finished goods being picked.

## Description
One row in this table represents a single association between a manufacturing production order and a specific picking label type. This is a raw landing table acting as a junction entity to resolve a many-to-many relationship in the Odoo ERP source system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| picking_label_type_id | INTEGER | false | Foreign key to the picking label type definition. | Links to the master definition of label formats. |
| mrp_production_id | INTEGER | false | Foreign key to the manufacturing production order. | Identifies the specific production batch. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(picking_label_type_id, mrp_production_id)`.
- **Foreign keys (inferred):** 
    - `picking_label_type_id` → `picking_label_type.id` (Inferred from Odoo naming convention).
    - `mrp_production_id` → `mrp_production.id` (Inferred from Odoo naming convention).
- **Natural keys (inferred):** The combination of `(picking_label_type_id, mrp_production_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; ensure your join logic accounts for the composite nature of the relationship.
- As a raw staging table, it does not contain soft-delete flags; assume records are removed if the relationship is severed in the source system.
- There is no audit timestamp (e.g., `created_at` or `updated_at`) present in this table; rely on the ingestion metadata for record freshness.