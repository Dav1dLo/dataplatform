# odoo_project_project_stage_delete_wizard

## Source system
This table originates from Odoo, an open-source ERP and business management suite. The naming convention `odoo_project_project_stage_delete_wizard` is characteristic of Odoo's internal "wizard" models, which are transient objects used to manage user interactions during specific workflows—in this case, the deletion of project stages.

## Functional process 
This table supports the project management module's lifecycle, specifically the "Project Stage Deletion" workflow. It acts as a temporary state container for the wizard interface that prompts users to confirm the removal of a project stage and handle the reassignment or deletion of associated tasks.

## Description
One row in this table represents a single execution instance of the project stage deletion wizard. It tracks the audit metadata for the wizard session, including who initiated the process and when it was last modified. As a staging table, it serves as a raw, landed copy of the transient wizard state from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence ID. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo `res_users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo `res_users` table. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last modification timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit pattern for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable. Wizard tables in Odoo are often transient and may not have a unique business key beyond the surrogate ID.

## Caveats for downstream consumers

- **Transient Data:** As a "wizard" table, this data is often short-lived in the source system; ensure your ingestion process accounts for high churn or truncation of these records.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo deployment configurations.
- **PII:** While this table contains no direct PII, the `create_uid` and `write_uid` link to user identities which may be considered sensitive in some compliance contexts.
- **Soft Deletes:** This table does not implement soft-delete flags; it reflects the state of the wizard object as it exists in the source database.