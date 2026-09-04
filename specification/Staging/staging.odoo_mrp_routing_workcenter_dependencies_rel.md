# odoo_mrp_routing_workcenter_dependencies_rel

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_routing_workcenter_dependencies_rel` is characteristic of Odoo's internal many-to-many relationship tables, which are used to link manufacturing operations to their dependencies.

## Functional process 
This table supports the manufacturing production scheduling process. It defines the dependency graph for work orders, ensuring that specific manufacturing operations cannot commence until their prerequisite operations (the "blocked by" operations) have been completed.

## Description
One row in this table represents a single dependency relationship between two manufacturing operations. It is a raw landing of an Odoo join table, mapping an operation to the specific operation that must be completed before it can proceed.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| operation_id | INTEGER | false | The ID of the operation that is being blocked. | References `mrp.routing.workcenter` ID. |
| blocked_by_id | INTEGER | false | The ID of the prerequisite operation. | References `mrp.routing.workcenter` ID. |

## Keys

- **Primary key (inferred):** The combination of `(operation_id, blocked_by_id)` acts as the composite primary key for this relationship table.
- **Foreign keys (inferred):** 
    - `operation_id` → `mrp_routing_workcenter.id`: This column identifies the dependent operation.
    - `blocked_by_id` → `mrp_routing_workcenter.id`: This column identifies the prerequisite operation.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only foreign keys.
- There are no timestamps or audit columns present; incremental loading must rely on source-side logic or full-table replacement.
- Ensure that joins to the parent `mrp_routing_workcenter` table handle the potential for missing records if the source system has performed cascading deletes.