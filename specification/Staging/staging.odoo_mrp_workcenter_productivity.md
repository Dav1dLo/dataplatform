# odoo_mrp_workcenter_productivity

## Source system
This table originates from Odoo ERP, specifically the Manufacturing (MRP) module. The naming convention `mrp_workcenter_productivity` and the presence of columns like `workcenter_id`, `workorder_id`, and `loss_id` are characteristic of Odoo's internal schema for tracking machine and labor efficiency in manufacturing operations.

## Functional process 
This table supports the manufacturing performance and efficiency tracking process. It records productivity logs for work centers, capturing time spent on specific work orders, associated loss reasons (e.g., downtime, maintenance, or inefficiency), and the duration of these events. It is essential for calculating Overall Equipment Effectiveness (OEE) and analyzing production bottlenecks.

## Description
One row in this table represents a single productivity log entry for a specific work center, capturing the start and end times of a work session or downtime event. This is a raw landed copy of the Odoo `mrp.workcenter.productivity` model, serving as the base for downstream manufacturing analytics and performance reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated identifier. |
| workcenter_id | INTEGER | false | Foreign key to the work center | Identifies the machine or station where the activity occurred. |
| company_id | INTEGER | false | Foreign key to the company | Multi-company context identifier. |
| workorder_id | INTEGER | true | Foreign key to the work order | Links the productivity log to a specific production task. |
| user_id | INTEGER | true | Foreign key to the user | The operator or employee associated with the activity. |
| loss_id | INTEGER | false | Foreign key to the loss reason | Categorizes the type of productivity loss or activity. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| loss_type | VARCHAR | true | Loss category | Describes the nature of the loss (e.g., 'productive', 'availability', 'performance'). |
| description | TEXT | true | Activity description | Free-text notes regarding the productivity event. |
| date_start | TIMESTAMP | false | Start timestamp | The beginning of the productivity or downtime event. |
| date_end | TIMESTAMP | true | End timestamp | The conclusion of the productivity or downtime event. |
| create_date | TIMESTAMP | true | Creation timestamp | Audit timestamp for record creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Audit timestamp for the last modification. |
| duration | DOUBLE PRECISION | true | Event duration | Time elapsed in minutes or hours (verify against Odoo config). |
| account_move_line_id | INTEGER | true | Accounting link | Links the productivity cost to a specific accounting entry. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `workcenter_id` → `mrp_workcenter.id` (Inferred from Odoo naming conventions)
    - `workorder_id` → `mrp_workorder.id` (Inferred from Odoo naming conventions)
    - `user_id` → `res_users.id` (Standard Odoo user reference)
    - `loss_id` → `mrp_workcenter_productivity_loss.id` (Inferred from Odoo naming conventions)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `user_id` which links to personnel data; ensure appropriate access controls are applied.
- **Timezone:** Timestamps are typically stored in UTC in Odoo; verify if your ingestion process has applied any local timezone offsets.
- **Soft Deletes:** Odoo typically uses hard deletes for this model; however, check for `active` flags if they exist in the source system (not present in this schema).
- **Duration:** The `duration` column unit should be validated against the Odoo `mrp.workcenter.productivity` configuration (usually minutes).
- **Data Integrity:** `workorder_id` is nullable, implying some productivity logs (like general maintenance) may not be tied to a specific production order.