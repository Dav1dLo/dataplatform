# odoo_mrp_workorder_dependencies_rel

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_workorder_dependencies_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are used to link work orders that have sequential or dependency-based constraints.

## Functional process 
This table supports the manufacturing execution process by defining the dependency graph for work orders. It ensures that specific manufacturing tasks cannot commence until their prerequisite work orders have been completed, facilitating proper scheduling and resource allocation within the production floor.

## Description
One row in this table represents a single dependency link between two work orders, where one work order is blocked by another. It serves as a raw, landed junction table capturing the many-to-many relationship between work orders in the Odoo staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| workorder_id | INTEGER | false | The ID of the work order that is being blocked. | References `mrp_workorder.id`. |
| blocked_by_id | INTEGER | false | The ID of the work order that must be completed first. | References `mrp_workorder.id`. |

## Keys

- **Primary key (inferred):** Not confidently inferable as a single column; likely a composite primary key on `(workorder_id, blocked_by_id)`.
- **Foreign keys (inferred):** 
    - `workorder_id` → `mrp_workorder.id`: This column identifies the dependent task in the manufacturing sequence.
    - `blocked_by_id` → `mrp_workorder.id`: This column identifies the prerequisite task that must finish before the dependent task can start.
- **Natural keys (inferred):** The combination of `(workorder_id, blocked_by_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This is a junction table; expect no other columns (like timestamps or status flags) to be present.
- There is no explicit primary key column; queries should treat the combination of both columns as the unique identifier.
- Ensure that any joins to `mrp_workorder` account for the possibility of circular dependencies if the source data is malformed.
- This table contains no PII or sensitive financial data.