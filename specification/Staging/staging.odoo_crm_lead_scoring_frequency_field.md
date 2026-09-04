# odoo_crm_lead_scoring_frequency_field

## Source system
This table originates from Odoo ERP, specifically the CRM module's lead scoring functionality. The naming convention (`odoo_crm_lead_scoring_frequency_field`) and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal ORM-managed tables.

## Functional process 
This table supports the Lead Scoring process, specifically tracking the frequency configuration of fields used to calculate lead scores. It maps which specific fields are being monitored for frequency-based scoring logic within the CRM pipeline.

## Description
One row in this table represents a configuration record linking a specific field to a lead scoring frequency rule. It serves as a raw landing copy of the Odoo configuration table, capturing the audit trail and field references required to reconstruct scoring logic in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Managed by Odoo sequence `crm_lead_scoring_frequency_field_id_seq`. |
| field_id | INTEGER | false | Reference to the field definition | Likely links to an Odoo `ir.model.fields` table. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| create_date | TIMESTAMP | true | Record creation timestamp | Odoo default is UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Odoo default is UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `field_id → ir_model_fields.id` (Guess: standard Odoo pattern for field references).
    - `create_uid → res_users.id` (Guess: standard Odoo audit pattern).
    - `write_uid → res_users.id` (Guess: standard Odoo audit pattern).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All timestamps (`create_date`, `write_date`) are stored in UTC by Odoo.
- **Soft Deletes:** Odoo typically uses hard deletes for configuration tables; however, verify if records disappear from the source to confirm.
- **PII:** This table contains configuration metadata and audit IDs; it does not contain direct PII, though `create_uid` and `write_uid` link to user identities.
- **Data Integrity:** `field_id` is mandatory; ensure downstream joins handle potential orphans if the source `ir_model_fields` table is not fully synced.