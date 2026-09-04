# odoo_mrp_workorder

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention (`mrp_workorder`) and the presence of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's PostgreSQL schema structure.

## Functional process 
This table supports the manufacturing execution process, specifically tracking the progress of individual work orders within a production order. It captures the scheduling, execution, and performance metrics of manufacturing operations performed at specific work centers, feeding into production planning and cost accounting workflows.

## Description
One row in this table represents a single work order operation within a manufacturing production order. It tracks the status, timing, and output quantities of a specific task performed at a work center. As a staging table, it serves as a raw, landed copy of the Odoo `mrp.workorder` model, intended for ingestion into downstream analytical models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses `staging.mrp_workorder_id_seq`. |
| sequence | INTEGER | true | Display order sequence | Used for ordering work steps. |
| workcenter_id | INTEGER | false | Foreign key to work center | References the resource performing the work. |
| product_id | INTEGER | true | Foreign key to product | The item being processed. |
| product_uom_id | INTEGER | false | Foreign key to unit of measure | Defines the unit for `qty_produced`. |
| production_id | INTEGER | false | Foreign key to production order | Links to the parent manufacturing order. |
| leave_id | INTEGER | true | Foreign key to resource leave | Links to scheduling calendar exceptions. |
| duration_percent | INTEGER | true | Progress percentage | Expected vs actual duration ratio. |
| operation_id | INTEGER | true | Foreign key to routing operation | Links to the predefined manufacturing step. |
| create_uid | INTEGER | true | Creator user ID | Audit field for record creation. |
| write_uid | INTEGER | true | Last modifier user ID | Audit field for record updates. |
| name | VARCHAR | false | Work order name | Descriptive label of the operation. |
| barcode | VARCHAR | true | Barcode identifier | Used for scanning in the shop floor app. |
| production_availability | VARCHAR | true | Material availability status | e.g., 'waiting', 'assigned'. |
| state | VARCHAR | true | Lifecycle state | e.g., 'pending', 'ready', 'progress', 'done'. |
| qty_produced | NUMERIC | true | Quantity completed | Units produced in this work order. |
| duration_expected | NUMERIC | true | Expected duration | Planned time in minutes. |
| qty_reported_from_previous_wo | NUMERIC | true | Previous step output | Quantity carried over from prior steps. |
| date_start | TIMESTAMP | true | Actual start time | Recorded in UTC. |
| date_finished | TIMESTAMP | true | Actual end time | Recorded in UTC. |
| production_date | TIMESTAMP | true | Scheduled production date | Target date for the operation. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp. |
| write_date | TIMESTAMP | true | Record modification timestamp | Audit timestamp. |
| duration | DOUBLE PRECISION | true | Actual duration | Total time spent in minutes. |
| duration_unit | DOUBLE PRECISION | true | Duration per unit | Time spent per unit produced. |
| costs_hour | DOUBLE PRECISION | true | Hourly cost rate | Cost of the work center per hour. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Standard Odoo relation)
    - `product_id` → `product_product.id` (Standard Odoo relation)
    - `production_id` → `mrp_production.id` (Standard Odoo relation)
- **Natural keys (inferred):** Not confidently inferable. Odoo typically relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `create_uid` and `write_uid` which link to internal user tables; these should be masked if exposing user-level activity.
- **Timezones:** Timestamps are stored in UTC by Odoo; ensure conversion to local reporting timezones if required.
- **Soft Deletes:** Odoo typically performs hard deletes on records unless a specific `active` flag is present (not observed here).
- **Precision:** `NUMERIC` and `DOUBLE PRECISION` fields are used for durations and quantities; ensure downstream casting handles potential floating-point inaccuracies.