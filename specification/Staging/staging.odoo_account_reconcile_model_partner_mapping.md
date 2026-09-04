# odoo_account_reconcile_model_partner_mapping

## Source system
This table originates from Odoo ERP. The naming convention `account_reconcile_model_partner_mapping` and the presence of `create_uid`, `write_uid`, and `_regex` columns are characteristic of Odoo's internal accounting reconciliation engine, which maps specific partners to reconciliation models based on payment references or narration patterns.

## Functional process 
This table supports the automated bank reconciliation process. It defines rules that allow the system to automatically suggest or apply specific reconciliation models (which dictate how payments are matched to invoices or accounts) based on the partner associated with a transaction and specific regex patterns found in the payment reference or narration fields.

## Description
One row in this table represents a specific mapping rule between a business partner and a reconciliation model. It acts as a configuration entity within the staging layer, providing the raw, landed state of reconciliation logic used to automate accounting entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_reconcile_model_partner_mapping_id_seq`. |
| model_id | INTEGER | false | Foreign key to reconciliation model | Links to the specific reconciliation model configuration. |
| partner_id | INTEGER | false | Foreign key to partner | Identifies the business partner subject to this mapping rule. |
| create_uid | INTEGER | true | User ID who created the record | References the internal Odoo user ID. |
| write_uid | INTEGER | true | User ID who last updated the record | References the internal Odoo user ID. |
| payment_ref_regex | VARCHAR | true | Regex pattern for payment reference | Used to match incoming bank statement line references. |
| narration_regex | VARCHAR | true | Regex pattern for narration | Used to match incoming bank statement line narration/labels. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Record last update timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `staging.odoo_account_reconcile_model.id` (Inferred from Odoo naming conventions).
    - `partner_id` → `staging.odoo_res_partner.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Regex usage:** The `payment_ref_regex` and `narration_regex` columns contain raw regex strings; ensure your downstream processing engine supports the specific regex flavor used by Odoo (typically Python's `re` module).
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with standard Odoo database configurations.
- **Soft Deletes:** This table does not contain an explicit `active` or `deleted_at` flag; check if the source system uses a separate mechanism for logical deletion.
- **Sensitivity:** While this table contains configuration data, `partner_id` links to entities that may be considered PII in downstream reporting; ensure appropriate access controls are applied.