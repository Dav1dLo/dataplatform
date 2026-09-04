# odoo_crm_iap_lead_role

## Source system
This table originates from Odoo ERP, specifically the CRM module's "IAP" (In-App Purchase) lead enrichment functionality. The naming convention `crm_iap_lead_role` and the presence of `create_uid`, `write_uid`, and `JSONB` fields are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the lead enrichment and qualification process within the CRM. It stores the roles or job functions associated with leads identified through Odoo's IAP services, allowing the system to categorize leads based on their professional capacity or organizational function.

## Description
One row in this table represents a specific role definition used to classify leads during the IAP enrichment process. This is a raw landed copy of the Odoo system table, serving as a lookup or configuration entity within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| color | INTEGER | true | UI color index | Used for visual representation in the Odoo frontend. |
| create_uid | INTEGER | true | Creator user ID | Foreign key to the Odoo res_users table. |
| write_uid | INTEGER | true | Last modifier user ID | Foreign key to the Odoo res_users table. |
| reveal_id | VARCHAR | false | External IAP identifier | The unique identifier provided by the IAP service. |
| name | JSONB | false | Role name | Multilingual label stored as a JSON object. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in server local time (usually UTC). |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in server local time (usually UTC). |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo audit field for record creation).
    - `write_uid` → `res_users.id` (Standard Odoo audit field for record modification).
- **Natural keys (inferred):** 
    - `reveal_id` (The unique identifier assigned by the IAP service provider).

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII is present, but `create_uid` and `write_uid` link to internal user identities.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo server configurations.
- **JSONB Handling:** The `name` column contains localized strings; downstream consumers must parse the JSONB structure (e.g., `name->>'en_US'`) to extract human-readable values.
- **Soft Deletes:** Odoo typically uses `active` boolean flags for soft deletes; since no `active` column is present, this table likely represents active configuration roles only.