# odoo_project_collaborator

## Source system
This table originates from Odoo ERP, specifically the Project management module. The naming convention (`project_collaborator`, `partner_id`, `create_uid`) is characteristic of Odoo's internal ORM structure, where `partner_id` typically references the `res.partner` table and `project_id` references the `project.project` table.

## Functional process 
This table supports the project collaboration and access control process. It tracks which external partners or internal users are assigned as collaborators to specific projects, defining the scope of their involvement and access rights within the project management lifecycle.

## Description
One row in this table represents a single assignment of a collaborator to a specific project. It acts as a link entity between projects and partners, capturing the audit trail of who created or modified the collaboration record and whether the collaborator has restricted access. This is a raw landed copy of the Odoo `project.collaborator` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.project_collaborator_id_seq`. |
| project_id | INTEGER | false | Foreign key to project | References the project being collaborated on. |
| partner_id | INTEGER | false | Foreign key to partner | References the collaborator (res.partner). |
| create_uid | INTEGER | true | Creator user ID | References the internal user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | References the internal user who last updated the record. |
| limited_access | BOOLEAN | true | Access restriction flag | Indicates if the collaborator has restricted project access. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `project_id` → `project.project.id`: Links the collaborator to the specific project entity.
    - `partner_id` → `res.partner.id`: Links the record to the contact/partner entity.
- **Natural keys (inferred):** 
    - The combination of `(project_id, partner_id)` is the business-level unique constraint in Odoo for this model.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and user IDs (`create_uid`, `write_uid`) which may be considered PII or internal system identifiers; ensure appropriate masking if exposing to non-admin roles.
- **Timezones:** Timestamps (`create_date`, `write_date`) are typically stored in UTC by Odoo; verify against system configuration if local time offsets are required.
- **Soft Deletes:** Odoo typically performs hard deletes on this model; if a row is missing, it has likely been removed from the source system.
- **Data Integrity:** `limited_access` is nullable; treat `NULL` as `FALSE` or "Full Access" depending on the specific Odoo version logic.