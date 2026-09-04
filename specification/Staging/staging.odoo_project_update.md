# odoo_project_update

## Source system
This table originates from Odoo ERP, specifically the Project module. The naming convention (e.g., `project_id`, `create_uid`, `write_uid`, `email_cc`) and the presence of standard Odoo audit fields (`create_date`, `write_date`) are characteristic of Odoo's internal ORM structure for tracking project status updates and progress reports.

## Functional process 
This table supports the project management and reporting process, specifically tracking periodic updates on project health, task completion metrics, and status changes. It facilitates the monitoring of project progress percentages and task throughput, allowing stakeholders to track the evolution of a project over time.

## Description
One row in this table represents a single project update record, capturing the state of a project at a specific point in time. It acts as a raw landed copy of the Odoo `project.update` model, providing a snapshot of progress, task counts, and descriptive status updates for downstream analytical reporting.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; unique identifier. |
| progress | INTEGER | true | Project completion percentage | Expected range 0-100. |
| user_id | INTEGER | false | Owner of the update | Reference to the user creating the update. |
| project_id | INTEGER | false | Associated project | Foreign key to the project entity. |
| task_count | INTEGER | true | Total tasks in project | Snapshot of total tasks at time of update. |
| closed_task_count | INTEGER | true | Completed tasks | Snapshot of closed tasks at time of update. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| email_cc | VARCHAR | true | CC email addresses | Comma-separated list of emails for notifications. |
| name | VARCHAR | false | Update title | Descriptive name or subject of the update. |
| status | VARCHAR | false | Project status | Categorical status (e.g., 'on_track', 'at_risk'). |
| date | DATE | true | Update date | Business date associated with the update. |
| description | TEXT | true | Update details | Rich text or plain text summary of progress. |
| create_date | TIMESTAMP | true | Record creation timestamp | Audit timestamp; timezone unspecified. |
| write_date | TIMESTAMP | true | Last modification timestamp | Audit timestamp; timezone unspecified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `project_id` → `staging.project.id` (Inferred from Odoo naming conventions).
    - `user_id` → `staging.res_users.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** `create_date` and `write_date` are standard Odoo timestamps; assume UTC unless otherwise specified by the Odoo instance configuration.
- **Data Sensitivity:** `email_cc` may contain PII (email addresses) and should be handled according to data privacy policies.
- **Soft Deletes:** This table represents a raw landing; it does not explicitly indicate if Odoo's soft-delete mechanism (if active) is represented here.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source; downstream consumers should account for potential long strings in `name` and `email_cc`.