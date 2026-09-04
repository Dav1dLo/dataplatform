# odoo_mrp_consumption_warning_mrp_production_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the prefix `mrp_` strongly indicates a standard Odoo many-to-many join table used to link manufacturing consumption warnings to specific production orders.

## Functional process 
This table supports the manufacturing execution process, specifically the tracking of material consumption warnings. It maps instances where a production order has triggered a consumption warning (e.g., over-consumption or under-consumption of components) to the specific production order records.

## Description
One row in this table represents a single association between a manufacturing consumption warning record and a production order record. It serves as a raw landing copy of the Odoo join table, facilitating the resolution of many-to-many relationships between production monitoring and consumption alerts.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_consumption_warning_id | INTEGER | false | Foreign key to the consumption warning record | Links to the primary key of the `mrp_consumption_warning` table. |
| mrp_production_id | INTEGER | false | Foreign key to the production order record | Links to the primary key of the `mrp_production` table. |

## Keys

- **Primary key (inferred):** The combination of `(mrp_consumption_warning_id, mrp_production_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `mrp_consumption_warning_id` → `mrp_consumption_warning.id`: This column references the parent warning entity.
    - `mrp_production_id` → `mrp_production.id`: This column references the parent production order entity.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; it contains no business data other than the identifiers for the related entities.
- There are no timestamps or audit columns present in this table; rely on the parent tables for temporal context.
- As a raw staging table, it may contain orphaned references if the source system's referential integrity is not strictly enforced at the database level.
- No sensitive PII is contained within this table.