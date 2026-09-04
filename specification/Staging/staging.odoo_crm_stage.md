# odoo_crm_stage

## Source system
This table originates from Odoo ERP, specifically the CRM module. The naming convention (e.g., `team_id`, `create_uid`, `write_uid`, `is_won`, `fold`) and the use of `JSONB` for localized fields are characteristic of Odoo's PostgreSQL-based backend architecture.

## Functional process 
This table supports the Sales Pipeline management process. It defines the stages (e.g., "New", "Qualified", "Proposition", "Won") within a CRM sales funnel, tracking the progression of opportunities and determining whether a stage represents a successful outcome (`is_won`) or a collapsed view in the UI (`fold`).

## Description
One row in this table represents a single stage definition within a CRM sales pipeline. It acts as a raw landed copy of the Odoo `crm.stage` model, capturing the configuration, sequence, and metadata for each stage in the sales process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.crm_stage_id_seq`. |
| sequence | INTEGER | true | Display order index | Determines the order of stages in the UI. |
| team_id | INTEGER | true | Sales team identifier | Foreign key to the sales team configuration. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this stage record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| name | JSONB | false | Stage name | Multilingual name stored as a JSON object. |
| requirements | TEXT | true | Stage requirements | Description of criteria needed to move to this stage. |
| is_won | BOOLEAN | true | Success flag | Indicates if this stage marks an opportunity as won. |
| fold | BOOLEAN | true | UI fold status | If true, the stage is collapsed in the Kanban view. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `team_id` → `crm_team.id` (Guess: links to the sales team owning this stage).
    - `create_uid` → `res_users.id` (Guess: links to the system user who created the record).
    - `write_uid` → `res_users.id` (Guess: links to the system user who last modified the record).
- **Natural keys (inferred):** Not confidently inferable; Odoo typically relies on the internal `id` for stage identification.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may need to be joined against a user directory for PII masking.
- **Timestamps:** Timestamps are stored in the Odoo application server time (typically UTC), but verify against the source system configuration.
- **Data Format:** The `name` column is `JSONB`; downstream consumers must parse this (e.g., `name->>'en_US'`) to extract human-readable strings.
- **Soft Deletes:** This table represents a raw dump; it does not explicitly implement soft-delete flags, but Odoo records are often archived rather than deleted. Check for an `active` column if it appears in future schema updates.