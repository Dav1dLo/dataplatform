# odoo_mrp_workcenter_mrp_workcenter_tag_rel

## Source system
This table originates from Odoo ERP. The naming convention `mrp_workcenter_mrp_workcenter_tag_rel` is a standard pattern used by the Odoo ORM to represent a many-to-many relationship table (a "relation" table) between manufacturing work centers and their associated tags.

## Functional process 
This table supports the Manufacturing (MRP) module by managing the categorization of work centers. It allows multiple tags to be assigned to a single work center, facilitating filtering, reporting, or scheduling based on work center attributes (e.g., "clean room", "high precision", "maintenance required").

## Description
One row in this table represents a single association between a specific work center and a specific tag. It acts as a join table to resolve the many-to-many relationship between the `mrp.workcenter` and `mrp.workcenter.tag` entities. As a staging table, it provides a raw, unjoined view of these link records as they exist in the source database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| mrp_workcenter_id | INTEGER | false | Foreign key to the work center. | References the primary key of the work center table. |
| mrp_workcenter_tag_id | INTEGER | false | Foreign key to the work center tag. | References the primary key of the work center tag table. |

## Keys

- **Primary key (inferred):** The composite key `(mrp_workcenter_id, mrp_workcenter_tag_id)`.
- **Foreign keys (inferred):** 
    - `mrp_workcenter_id` → `mrp_workcenter.id`: Links to the manufacturing work center definition.
    - `mrp_workcenter_tag_id` → `mrp_workcenter_tag.id`: Links to the tag definition.
- **Natural keys (inferred):** Not confidently inferable; this is a pure association table.

## Caveats for downstream consumers

- This table contains no descriptive data, only integer identifiers; it must be joined with the corresponding master tables to be meaningful.
- There are no timestamps or soft-delete flags; this table reflects the current state of associations in the source system.
- As a join table, it does not contain sensitive PII, but ensure that downstream joins respect the security access levels of the linked master tables.