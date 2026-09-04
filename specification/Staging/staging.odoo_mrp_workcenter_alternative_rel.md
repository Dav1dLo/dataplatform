# odoo_mrp_workcenter_alternative_rel

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `_rel` is characteristic of Odoo's ORM-generated many-to-many relationship tables, which link records between two entities in the underlying PostgreSQL database.

## Functional process 
This table supports the manufacturing routing and capacity planning process. It defines the relationship between a primary work center and its designated alternative work centers, allowing the system to automatically reroute production tasks if the primary work center is unavailable or at capacity.

## Description
Each row represents a single association between a primary work center and an alternative work center. This is a junction table used to resolve a many-to-many relationship, enabling the Odoo MRP engine to identify fallback resources for production operations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| workcenter_id | INTEGER | false | Foreign key to the primary work center | References `mrp_workcenter.id`. |
| alternative_workcenter_id | INTEGER | false | Foreign key to the alternative work center | References `mrp_workcenter.id`. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata (likely a composite PK on `(workcenter_id, alternative_workcenter_id)`).
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id`: Links to the primary resource definition.
    - `alternative_workcenter_id` → `mrp_workcenter.id`: Links to the resource designated as a fallback.
- **Natural keys (inferred):** The combination of `(workcenter_id, alternative_workcenter_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should use the composite pair for joins or deduplication.
- As a raw staging table, it reflects the Odoo database schema directly; ensure that downstream models handle potential circular references if a work center is defined as its own alternative.
- There are no timestamps or audit columns present; incremental loading logic must rely on external metadata or full-table refreshes.