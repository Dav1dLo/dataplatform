# odoo_base_partner_merge_line

## Source system
This table originates from Odoo ERP, specifically the base module responsible for partner (customer/vendor) data deduplication. The naming convention `base_partner_merge_line` and the presence of `wizard_id` are characteristic of Odoo's internal wizard-based data management workflows.

## Functional process 
This table supports the customer data cleansing and deduplication process. It tracks the individual lines within a merge operation, linking specific partner records to a deduplication wizard session, allowing the system to track which records are being consolidated into a single master record.

## Description
One row in this table represents a single line item within a partner merge operation, identifying a specific set of partner IDs being processed by a deduplication wizard. As a staging table, it serves as a raw landed copy of the Odoo `base.partner.merge.line` model, capturing the state of merge operations before any downstream transformation or reconciliation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.base_partner_merge_line_id_seq`. |
| wizard_id | INTEGER | true | Foreign key to the merge wizard | Links to the parent deduplication session. |
| min_id | INTEGER | true | Minimum partner ID in the set | Often used as the target or representative ID for the merge. |
| create_uid | INTEGER | true | Creator user ID | References the Odoo user who initiated the merge line. |
| write_uid | INTEGER | true | Last modifier user ID | References the Odoo user who last updated the merge line. |
| aggr_ids | VARCHAR | false | Aggregated partner IDs | A string representation of IDs being merged; likely a comma-separated list. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Last update timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `staging.base_partner_merge_wizard.id` (guess: standard Odoo naming convention for wizard relations).
    - `create_uid` → `staging.res_users.id` (guess: standard Odoo audit field).
    - `write_uid` → `staging.res_users.id` (guess: standard Odoo audit field).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Data format:** The `aggr_ids` column contains a string representation of multiple IDs; this will require parsing (e.g., `string_to_array`) for any relational joins or analysis.
- **Timestamps:** Timestamps are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Sensitivity:** Contains user audit IDs (`create_uid`, `write_uid`) and partner identifiers; ensure access is restricted according to internal data governance policies.
- **Soft deletes:** This table represents a transactional log of merge operations; it does not typically implement soft deletes, but records may be ephemeral depending on the Odoo cleanup cron jobs.