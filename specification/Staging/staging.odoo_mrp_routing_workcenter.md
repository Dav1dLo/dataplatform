# odoo_mrp_routing_workcenter

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_routing_workcenter` and the presence of Odoo-specific audit columns like `create_uid`, `write_uid`, and `time_cycle_manual` are characteristic of Odoo's internal database schema for managing manufacturing routings.

## Functional process 
This table supports the manufacturing production process by defining the sequence of operations (routings) performed at specific work centers for a given Bill of Materials (BOM). It links production steps to physical work centers, allowing the system to calculate lead times and manage operational instructions via the `worksheet` columns.

## Description
One row represents a single step or operation within a manufacturing routing assigned to a specific Bill of Materials. It acts as a raw landed copy of the Odoo `mrp.routing.workcenter` model, capturing the configuration of work center tasks, including sequence, time estimation modes, and associated documentation links.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| workcenter_id | INTEGER | false | Foreign key to work center | Links to the physical work center definition. |
| sequence | INTEGER | true | Display order | Determines the order of operations in the routing. |
| bom_id | INTEGER | false | Foreign key to BOM | Links to the parent Bill of Materials. |
| time_mode_batch | INTEGER | true | Batch size for time calculation | Used when calculating cycle times for multiple units. |
| create_uid | INTEGER | true | Creator user ID | Odoo internal user ID who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | Odoo internal user ID who last updated the record. |
| name | VARCHAR | false | Operation name | Descriptive name of the routing step. |
| worksheet_type | VARCHAR | true | Worksheet format | Defines the type of instructions (e.g., 'pdf', 'google_slide'). |
| worksheet_google_slide | VARCHAR | true | Google Slide URL | Link to external instruction documentation. |
| time_mode | VARCHAR | true | Time calculation mode | Method used to estimate cycle time. |
| note | TEXT | true | Operational notes | Additional instructions for the operator. |
| active | BOOLEAN | true | Soft-delete flag | Indicates if the routing step is currently active. |
| create_date | TIMESTAMP | true | Creation timestamp | UTC timestamp of record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC timestamp of last modification. |
| time_cycle_manual | DOUBLE PRECISION | true | Manual cycle time | Estimated time in minutes for the operation. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `staging.mrp_workcenter.id` (Inferred based on Odoo standard naming conventions).
    - `bom_id` → `staging.mrp_bom.id` (Inferred based on Odoo standard naming conventions).
- **Natural keys (inferred):** Not confidently inferable. While `bom_id` and `sequence` often act as a business key, Odoo internal IDs are typically used for relational integrity.

## Caveats for downstream consumers

- **Soft Deletes:** The `active` column should be filtered (`WHERE active = TRUE`) in most downstream queries to exclude deprecated or deleted routing steps.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's standard storage format.
- **Data Sensitivity:** No direct PII is present, though `create_uid` and `write_uid` link to internal user identities which may be considered sensitive in some compliance contexts.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; downstream systems should allow for variable length strings.