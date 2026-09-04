# odoo_mrp_workcenter_capacity

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_workcenter_capacity` and the presence of Odoo-standard audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal database schema.

## Functional process 
This table supports the production planning and capacity management process. It defines the specific production capacity and time constraints for a given product at a specific manufacturing work center, allowing the MRP engine to calculate lead times and schedule production orders based on available resources.

## Description
One row in this table represents a capacity configuration record for a specific product at a designated manufacturing work center. It serves as a raw landed copy of the Odoo `mrp.workcenter.capacity` model, capturing the throughput and time parameters used for scheduling.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| workcenter_id | INTEGER | false | Foreign key to the work center | Links to the manufacturing resource definition. |
| product_id | INTEGER | false | Foreign key to the product | The specific item being manufactured or processed. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |
| capacity | DOUBLE PRECISION | true | Production capacity | The quantity of the product the work center can handle. |
| time_start | DOUBLE PRECISION | true | Start time offset | Likely represents hours or minutes relative to shift start. |
| time_stop | DOUBLE PRECISION | true | Stop time offset | Likely represents hours or minutes relative to shift start. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Inferred from Odoo naming conventions).
    - `product_id` → `product_product.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are stored in UTC as per standard Odoo behavior.
- This table contains no explicit soft-delete flag; Odoo typically manages record lifecycle via `active` boolean columns, which are absent here.
- `time_start` and `time_stop` are `DOUBLE PRECISION` types; verify if these represent decimal hours or minutes before performing calculations.
- No PII is present in this table, as it contains only system-generated IDs and technical configuration parameters.