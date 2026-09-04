# odoo_ir_cron_progress

## Source system
This table originates from Odoo ERP, specifically tracking the execution progress of scheduled actions (cron jobs). The naming convention `ir_cron` is a standard Odoo internal module prefix for the "Ir" (Internal Resources) framework, which manages background tasks and automated processes within the Odoo application.

## Functional process 
This table supports the background task management and monitoring process. It tracks the state of long-running scheduled actions, allowing the system to monitor how many items are remaining or completed for a specific cron job, and identifying tasks that may be timing out.

## Description
One row in this table represents the current execution progress and status of a specific scheduled background task. It serves as a raw landing copy of the Odoo `ir.cron.progress` model, providing visibility into the lifecycle and performance of automated system jobs.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Unique surrogate primary key | Managed by `staging.ir_cron_progress_id_seq`. |
| cron_id | INTEGER | false | Foreign key to the scheduled action | Links to the `ir_cron` definition table. |
| remaining | INTEGER | true | Count of items left to process | Indicates work-in-progress volume. |
| done | INTEGER | true | Count of items successfully processed | Cumulative count for the current task. |
| timed_out_counter | INTEGER | true | Number of timeout occurrences | Tracks failures due to execution limits. |
| create_uid | INTEGER | true | ID of the user who created the record | References `res.users`. |
| write_uid | INTEGER | true | ID of the user who last updated the record | References `res.users`. |
| deactivate | BOOLEAN | true | Flag to disable the progress tracking | If true, the task may be ignored by the scheduler. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `cron_id` → `staging.odoo_ir_cron.id` (Evidence: Standard Odoo naming convention for linking to the parent cron definition).
    - `create_uid` → `staging.odoo_res_users.id` (Evidence: Standard Odoo audit column pattern).
    - `write_uid` → `staging.odoo_res_users.id` (Evidence: Standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against user dimension tables to resolve names.
- **Timezones:** Odoo stores timestamps in UTC; ensure downstream transformations account for this if local time reporting is required.
- **Soft Deletes:** This table does not explicitly show a `deleted` flag; however, the `deactivate` column acts as a functional soft-delete for the progress tracking logic.
- **Data Freshness:** As a staging table, this represents a snapshot of the Odoo database; verify the ingestion frequency to understand the latency of the `remaining` and `done` counts.