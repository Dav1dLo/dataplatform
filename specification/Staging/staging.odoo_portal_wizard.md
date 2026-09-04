# odoo_portal_wizard

## Source system
This table originates from Odoo, an open-source ERP system. The naming convention (`portal_wizard`, `create_uid`, `write_uid`) and the use of Odoo-specific sequence generators (`nextval('staging.portal_wizard_id_seq'::regclass)`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the "Portal Access" or "Customer Invitation" business process. It tracks the configuration of wizards used to grant external users (customers or partners) access to the Odoo portal, specifically storing the welcome message displayed to the user during the invitation flow.

## Description
One row in this table represents a single instance of a portal invitation wizard session. It serves as a raw landed copy of the Odoo `portal.wizard` model, capturing the metadata and configuration for portal access invitations. The grain is one row per wizard session initiated in the system.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by Odoo sequence `portal_wizard_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the `res_users` table. |
| write_uid | INTEGER | true | User ID who last modified the record | References the `res_users` table. |
| welcome_message | TEXT | true | Custom message for the invitee | The text content displayed in the portal invitation email. |
| create_date | TIMESTAMP | true | Record creation timestamp | Odoo internal audit field. |
| write_date | TIMESTAMP | true | Last modification timestamp | Odoo internal audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for tracking record creators).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for tracking record modifiers).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Odoo stores timestamps in UTC; ensure downstream transformations account for this if local time reporting is required.
- **Sensitive Data:** The `welcome_message` field may contain PII or sensitive communication content; consider masking if exposing to non-authorized users.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag (e.g., `active` column), which is common in other Odoo models. Assume rows are either hard-deleted or represent the full history of wizard invocations.
- **Data Integrity:** As a staging table, this data is a direct reflection of the source; expect potential nulls in `create_uid` or `write_uid` if the record was created via automated system processes.