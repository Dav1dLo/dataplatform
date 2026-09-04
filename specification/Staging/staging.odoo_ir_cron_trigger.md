# odoo_ir_cron_trigger

## Source system
This table originates from Odoo ERP, specifically the `ir_cron_trigger` model. The naming convention `ir_cron_trigger` is a standard Odoo internal table name used to manage scheduled action triggers within the Odoo framework.

## Functional process 
This table supports the background task scheduling and automation engine. It tracks specific trigger events for scheduled actions (cron jobs), determining when a particular automated task is queued to execute.

## Description
One row represents a single pending execution trigger for a scheduled background task. It serves as a raw landing copy of the Odoo internal trigger queue, capturing the timing and audit metadata for automated processes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo. |
| cron_id | INTEGER | true | Foreign key to the scheduled action | Links to the definition of the task to be run. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this trigger record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| call_at | TIMESTAMP | true | Scheduled execution time | The timestamp when the task is intended to run. |
| create_date | TIMESTAMP | true | Record creation timestamp | Timestamp of when the trigger was inserted. |
| write_date | TIMESTAMP | true | Last modification timestamp | Timestamp of the last update to this trigger record. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `cron_id` → `ir_cron.id`: Links to the scheduled action definition (guess based on Odoo naming patterns).
    - `create_uid` → `res_users.id`: Links to the user who created the trigger (guess based on Odoo naming patterns).
    - `write_uid` → `res_users.id`: Links to the user who last modified the trigger (guess based on Odoo naming patterns).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`call_at`, `create_date`, `write_date`) are typically stored in UTC by Odoo, but verify against the Odoo server configuration.
- This table is highly volatile; rows are typically deleted or processed rapidly by the Odoo cron runner.
- No PII is explicitly identified, but `create_uid` and `write_uid` link to user records which may contain sensitive identity information.
- The table represents a transient state of the task queue; it is not a historical log of completed tasks.