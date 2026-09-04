# odoo_project_share_collaborator_wizard

## Source system
This table originates from Odoo ERP. The naming convention `project_share_collaborator_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal transient models used for UI-driven workflows.

## Functional process 
This table supports the project collaboration sharing process. It acts as a temporary state holder (wizard) for the business process of inviting external partners to collaborate on specific project tasks or documents, managing the assignment of access rights and invitation triggers.

## Description
One row in this table represents a single instance of a collaboration invitation configuration within a project sharing wizard session. It serves as a raw landed copy of the transient wizard data used to facilitate the invitation of a partner to a project. The grain is one row per collaborator invitation attempt per wizard session.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; internal Odoo ID. |
| parent_wizard_id | INTEGER | true | Reference to parent wizard | Links this collaborator entry to the main wizard session. |
| partner_id | INTEGER | false | Partner ID | Foreign key to the partner being invited. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the wizard. |
| access_mode | VARCHAR | false | Permission level | Defines the level of access (e.g., 'read', 'edit'). |
| send_invitation | BOOLEAN | true | Invitation trigger | Flag indicating if an email invitation should be sent. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of wizard creation. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp of last modification. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Inferred from Odoo standard naming conventions for partner references).
    - `create_uid` → `res_users.id` (Standard Odoo audit column pattern).
    - `write_uid` → `res_users.id` (Standard Odoo audit column pattern).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `partner_id` and potentially user IDs; ensure appropriate access controls are applied.
- **Timezone:** Timestamps (`create_date`, `write_date`) are typically stored in UTC in Odoo; verify against system configuration.
- **Data Lifecycle:** As a "wizard" table, this data is transient in the source system; rows may be purged or become orphaned after the wizard session completes.
- **Soft Deletes:** This table does not appear to implement soft deletes; it reflects the state of the wizard at the time of ingestion.