# odoo_crm_iap_lead_seniority

## Source system
This table originates from Odoo ERP, specifically the CRM module's "IAP" (In-App Purchase) lead enrichment service. The presence of `reveal_id` and the `iap_lead_seniority` naming convention strongly indicates this is a raw landing table for lead seniority data retrieved via Odoo's external lead enrichment API.

## Functional process 
This table supports the lead qualification and scoring process within the CRM. It stores seniority classifications (e.g., C-level, Manager, Entry) for leads enriched through Odoo's IAP services, allowing sales teams to filter or prioritize leads based on the professional hierarchy of the contact.

## Description
One row in this table represents a specific seniority classification record used to categorize leads enriched by the Odoo IAP service. It acts as a raw landing copy of the seniority metadata, capturing the internal Odoo identifier, the external reveal ID, and the localized name of the seniority level.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by sequence `staging.crm_iap_lead_seniority_id_seq`. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| reveal_id | VARCHAR | false | External IAP service identifier | Unique identifier provided by the IAP lead enrichment provider. |
| name | JSONB | false | Seniority label | Stores localized names; likely contains key-value pairs for different languages. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on standard Odoo behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on standard Odoo behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit column for creator).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit column for updater).
- **Natural keys (inferred):** 
    - `reveal_id`: This is the business key provided by the external IAP service to identify the seniority level.

## Caveats for downstream consumers

- **PII/Sensitive Data:** The `name` column contains labels that are generally not sensitive, but ensure no PII is inadvertently mapped into the JSONB structure by the source system.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal database storage.
- **Soft Deletes:** This table does not appear to have a `deleted` or `active` flag; assume all records present are current unless Odoo's standard `active` column (not present here) is added later.
- **JSONB Handling:** The `name` column requires `->>` or `->` operators to extract specific language strings (e.g., `name->>'en_US'`).