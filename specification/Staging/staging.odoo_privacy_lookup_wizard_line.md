# odoo_privacy_lookup_wizard_line

## Source system
This table originates from Odoo ERP. The naming convention (e.g., `res_model`, `create_uid`, `write_uid`, `wizard_line`) is characteristic of Odoo's internal ORM structure, specifically related to the GDPR/privacy compliance modules used for tracking and anonymizing personal data.

## Functional process 
This table supports the GDPR privacy lookup process within Odoo. It tracks individual records (identified by `res_id` and `res_model`) that are being processed or audited by a specific privacy wizard, allowing administrators to identify and manage personal data across various system models.

## Description
One row in this table represents a single line item within a privacy lookup wizard session, linking a specific record to a wizard execution. It acts as a raw landed staging entity, capturing the state of a privacy lookup request at the time of ingestion.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.privacy_lookup_wizard_line_id_seq`. |
| wizard_id | INTEGER | true | Foreign key to the parent wizard | Links to the main privacy lookup session. |
| res_id | INTEGER | false | ID of the target record | The specific record ID in the source model. |
| res_model_id | INTEGER | true | Foreign key to the model definition | Links to the Odoo `ir.model` table. |
| create_uid | INTEGER | true | User ID who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | User ID who last updated the record | References the Odoo `res.users` table. |
| res_name | VARCHAR | true | Display name of the target record | Human-readable identifier for the record. |
| res_model | VARCHAR | true | Technical name of the model | e.g., 'res.partner' or 'sale.order'. |
| execution_details | VARCHAR | true | Audit or processing logs | Contains details regarding the lookup result. |
| has_active | BOOLEAN | true | Flag for active status existence | Indicates if the record supports an active state. |
| is_active | BOOLEAN | true | Current active status of the record | Reflects the record's state at lookup time. |
| is_unlinked | BOOLEAN | true | Flag for unlinked status | Indicates if the record has been anonymized/unlinked. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `staging.odoo_privacy_lookup_wizard.id` (Guess: links to the parent wizard session).
    - `create_uid` / `write_uid` → `staging.odoo_res_users.id` (Guess: standard Odoo user tracking).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** This table contains `res_name` and `execution_details`, which may contain PII or sensitive audit information; ensure appropriate masking for non-privileged users.
- **Timezones:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Integrity:** As a staging table, this may contain multiple versions of the same `id` if the ingestion process performs full refreshes; check for duplicates if performing historical analysis.
- **Soft Deletes:** Odoo typically uses `active` flags rather than physical row deletion; `is_active` should be used to filter for current records.