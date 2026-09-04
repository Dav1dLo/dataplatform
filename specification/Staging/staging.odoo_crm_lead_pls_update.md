# odoo_crm_lead_pls_update

## Source system
This table originates from an Odoo ERP instance, specifically the CRM module. The naming convention `crm_lead_pls_update` and the presence of `create_uid` and `write_uid` columns are characteristic of Odoo's internal audit and tracking system for lead scoring or "Probabilistic Lead Scoring" (PLS) updates.

## Functional process 
This table supports the lead management and sales forecasting process by tracking updates to probabilistic lead scoring parameters. It records the temporal bounds and administrative changes associated with lead scoring model adjustments, which are used to prioritize sales pipelines.

## Description
One row in this table represents a single update event or configuration record for a lead scoring model within the CRM. It serves as a raw landed copy of the Odoo `crm.lead.pls.update` model, capturing the audit trail and effective dates for scoring logic changes.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.crm_lead_pls_update_id_seq`. |
| create_uid | INTEGER | true | ID of the user who created the record | References the Odoo `res.users` table. |
| write_uid | INTEGER | true | ID of the user who last modified the record | References the Odoo `res.users` table. |
| pls_start_date | DATE | false | Start date for the lead scoring update | Defines the effective period for the scoring logic. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Record last modification timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `create_uid` → `res_users.id` (Standard Odoo pattern for record ownership).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `TIMESTAMP` columns are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Data Integrity:** The `create_uid` and `write_uid` columns may be null if the record was created via a system process rather than a specific user action.
- **Soft Deletes:** This table does not appear to contain a soft-delete flag (e.g., `active` column); assume all records are current unless otherwise specified by business logic.
- **Sensitivity:** While this table contains user IDs, it does not contain PII; however, ensure that `create_uid` and `write_uid` are joined against the appropriate user dimension to resolve names.