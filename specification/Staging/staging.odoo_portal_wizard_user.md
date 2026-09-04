# odoo_portal_wizard_user

## Source system
This table originates from Odoo ERP, an open-source business management suite. The naming convention `portal_wizard_user` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables used to track user access and invitation states within the portal module.

## Functional process 
This table supports the "Portal Invitation" process, which manages the assignment of portal access rights to specific partners (customers or vendors). It tracks which users are associated with a specific portal wizard session, facilitating the bulk invitation of contacts to the Odoo customer portal.

## Description
One row in this table represents a single user association within a specific portal wizard invitation session. It acts as a staging record that links a portal wizard instance to a specific partner, capturing the email address used for the invitation and audit metadata. This is a raw landed copy of the Odoo internal table, intended for downstream integration into user access reporting or portal adoption analytics.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated; managed by Odoo ORM. |
| wizard_id | INTEGER | false | Foreign key to the portal wizard | Links to the parent wizard session record. |
| partner_id | INTEGER | false | Foreign key to the partner | The contact being invited to the portal. |
| create_uid | INTEGER | true | User ID who created the record | References the internal user who initiated the wizard. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal user who last modified the record. |
| email | VARCHAR | true | Contact email address | The email address used for the portal invitation. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC; audit timestamp. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC; audit timestamp. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `portal_wizard.id` (Guess: links to the parent wizard session).
    - `partner_id` → `res_partner.id` (Guess: standard Odoo pattern for linking to contact records).
    - `create_uid` / `write_uid` → `res_users.id` (Guess: standard Odoo pattern for audit user references).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** The `email` column contains PII and should be masked or handled according to data privacy policies.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; records are likely hard-deleted by the Odoo ORM when the wizard session is purged.
- **Data Integrity:** As a staging table, this may contain transient data from incomplete or abandoned portal invitation sessions.