# odoo_crm_iap_lead_helpers

## Source system
This table originates from Odoo ERP, specifically the CRM module's In-App Purchase (IAP) lead enrichment functionality. The naming convention `crm_iap_lead_helpers` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM structure.

## Functional process 
This table supports the CRM lead enrichment process, where external data providers (IAP) are queried to augment lead information. It acts as a helper or configuration entity for the lead enrichment pipeline, tracking the audit trail of records created or modified during the automated lead qualification process.

## Description
One row in this table represents a specific helper record or configuration entry associated with the Odoo CRM IAP lead enrichment service. It serves as a raw landed copy of the Odoo internal table, capturing the audit metadata required to track record lifecycle and ownership within the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.crm_iap_lead_helpers_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References `res.users` in the source system. |
| write_uid | INTEGER | true | User ID who last modified the record | References `res.users` in the source system. |
| create_date | TIMESTAMP | true | Creation timestamp | Assumed UTC; Odoo standard audit field. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC; Odoo standard audit field. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Guess: standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` fields are assumed to be in UTC, consistent with Odoo's internal storage practices.
- **Audit Fields:** `create_uid` and `write_uid` are internal Odoo database IDs; they will not resolve to meaningful user names without joining against the `res_users` table in the source system.
- **Data Retention:** This is a raw staging table; it does not explicitly implement soft-delete flags, so assume all historical records are present unless filtered by `write_date`.
- **Sensitivity:** While this table contains audit IDs, it is part of the CRM infrastructure; ensure that any joined user data is handled according to internal PII policies.