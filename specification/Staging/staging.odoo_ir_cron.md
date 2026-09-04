# odoo_ir_cron

## Source system
This table originates from Odoo ERP, specifically the `ir_cron` model within the Odoo framework's internal registry. The naming convention `ir_cron` (Internal Registry - Cron) and the presence of columns like `ir_actions_server_id` and `interval_number` are characteristic of Odoo's scheduled action management system.

## Functional process 
This table supports the background task scheduling and automation process within the Odoo environment. It tracks the configuration, execution frequency, and health status of automated server actions, ensuring that recurring business processes (such as email queue processing, report generation, or data synchronization) are triggered at the correct intervals.

## Description
One row in this table represents a single scheduled background task (cron job) configured within the Odoo instance. It acts as a raw landed copy of the system's task registry, capturing the execution schedule, the associated server action, and the current state of the job, including failure counts and timestamps for the next and last execution.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.ir_cron_id_seq`. |
| ir_actions_server_id | INTEGER | false | Foreign key to the server action | Links to the specific action logic to be executed. |
| user_id | INTEGER | false | User ID executing the task | The system user context under which the task runs. |
| interval_number | INTEGER | false | Frequency multiplier | The numeric value for the interval (e.g., 5 in "5 minutes"). |
| priority | INTEGER | true | Execution priority | Lower values typically indicate higher priority. |
| failure_count | INTEGER | true | Consecutive failure counter | Tracks how many times the job has failed consecutively. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the cron job. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the cron job. |
| cron_name | VARCHAR | true | Descriptive name of the job | Human-readable label for the scheduled task. |
| interval_type | VARCHAR | false | Time unit for the interval | Values like 'minutes', 'hours', 'days', 'weeks', 'months'. |
| active | BOOLEAN | true | Status flag | Indicates if the cron job is enabled (true) or disabled (false). |
| nextcall | TIMESTAMP | false | Next scheduled execution time | The timestamp when the job is next expected to run. |
| lastcall | TIMESTAMP | true | Last execution time | The timestamp of the most recent execution attempt. |
| first_failure_date | TIMESTAMP | true | Timestamp of initial failure | Records when the current failure sequence began. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp for when the job was defined. |
| write_date | TIMESTAMP | true | Record modification timestamp | Audit timestamp for the last update to the job definition. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `ir_actions_server_id` → `ir_actions_server.id` (Inferred from Odoo architecture naming conventions).
    - `user_id` → `res_users.id` (Standard Odoo pattern for user-linked records).
- **Natural keys (inferred):** Not confidently inferable. While `cron_name` is descriptive, it is not guaranteed to be unique in the Odoo schema.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the Odoo server's configured timezone (typically UTC). Verify the source system's `timezone` setting if performing cross-system time calculations.
- **Soft Deletes:** Odoo often uses the `active` column as a soft-delete mechanism. Queries should generally filter by `WHERE active = true` unless auditing historical configurations.
- **Data Sensitivity:** The `user_id` column identifies the system user context, which may be sensitive depending on the permissions associated with that user.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo field lengths (often 255 characters) but validate against source DDL if truncations occur.