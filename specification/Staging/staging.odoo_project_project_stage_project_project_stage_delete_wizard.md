# odoo_project_project_stage_project_project_stage_delete_wizard_

## Source system
This table originates from Odoo ERP. The naming convention `project_project_stage_delete_wizard_` is characteristic of Odoo's transient model architecture, where "wizards" are used to manage temporary UI-driven workflows, in this case, the deletion of project stages.

## Functional process 
This table supports the project management module's lifecycle process, specifically the cleanup or removal of project stages. It tracks the association between a deletion wizard instance and the specific project stage targeted for removal.

## Description
One row in this table represents a single association between a transient deletion wizard session and a specific project stage ID. As a staging table, it provides a raw, landed copy of the wizard's internal state, likely used to facilitate the batch deletion of stages within the Odoo project management interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| "project_project_stage_delete_wizard_id" | INTEGER | false | Surrogate ID of the deletion wizard session | Primary key for the wizard instance. |
| "project_project_stage_id" | INTEGER | false | Foreign key to the project stage being deleted | References the stage record in the source system. |

## Keys

- **Primary key (inferred):** "project_project_stage_delete_wizard_id"
- **Foreign keys (inferred):** 
    - "project_project_stage_id" → "project_project_stage"."id" (Inferred based on Odoo naming conventions for relational fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table represents a transient wizard state; data here is likely ephemeral and may be purged by the source system after the deletion process completes.
- There are no audit timestamps (e.g., `create_date` or `write_date`) present, making it difficult to determine the age of these records without joining to parent wizard tables.
- The table name ends with an underscore, which is standard for Odoo's internal transient model tables; ensure your SQL parser handles the trailing underscore correctly.