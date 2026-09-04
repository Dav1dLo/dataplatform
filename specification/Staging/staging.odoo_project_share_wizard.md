# odoo_project_share_wizard

## Source system
This table originates from Odoo ERP. The naming convention `odoo_project_share_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) and polymorphic reference fields (`res_id`, `res_model`) are characteristic of Odoo's internal wizard/transient model architecture used for sharing project-related records.

## Functional process 
This table supports the project collaboration and sharing process within Odoo. It tracks the state of "share" wizards, which are temporary interfaces used to grant external or internal users access to specific project records (e.g., tasks or project documents) via generated links or email invitations.

## Description
One row represents a single instance of a project sharing wizard session initiated by a user. This is a raw landed copy of the transient model data from the Odoo database, capturing the target record reference, the associated note, and the audit trail of the wizard's creation and modification.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo. |
| res_id | INTEGER | false | Resource ID | The ID of the record being shared in the target model. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the user who initiated the share wizard. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the user who last updated the wizard. |
| res_model | VARCHAR | false | Resource model name | The technical name of the Odoo model being shared (e.g., 'project.project'). |
| note | TEXT | true | Sharing note | Optional message or context included in the share invitation. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the wizard was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the wizard was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: Standard Odoo pattern for user tracking).
    - `write_uid` → `res_users.id` (Guess: Standard Odoo pattern for user tracking).
- **Natural keys (inferred):** Not confidently inferable. The table represents transient wizard state rather than a persistent business entity with a unique natural identifier.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in UTC as per standard Odoo configuration.
- **Data Retention:** This table tracks transient wizard sessions; rows may be purged or archived by Odoo's internal cleanup routines.
- **Polymorphism:** The `res_id` and `res_model` columns form a polymorphic relationship. Queries joining against this table must filter by `res_model` to ensure the `res_id` is resolved against the correct target table.
- **Sensitivity:** The `note` column may contain free-text user input; ensure PII/GDPR compliance if this data is exposed to downstream reporting layers.