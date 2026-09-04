# odoo_account_reconcile_model_line

## Source system
This table originates from Odoo ERP, specifically the accounting module. The naming convention `account_reconcile_model_line` and the presence of columns like `model_id`, `journal_id`, and `analytic_distribution` are characteristic of Odoo's internal data structure for bank statement and payment reconciliation rules.

## Functional process 
This table supports the automated reconciliation process within the financial accounting module. It defines the specific line-item rules (such as tax application, account mapping, or analytic distribution) that the system applies when matching bank statement lines or payments against open invoices or general ledger accounts.

## Description
One row represents a single rule line associated with a reconciliation model, defining how a specific portion of a transaction should be processed or balanced. This is a raw landed copy of the Odoo configuration table, capturing the logic used to automate accounting entries. It serves as a staging entity for downstream financial reporting and reconciliation audit trails.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| model_id | INTEGER | true | Foreign key to the parent reconciliation model | Links to the main rule header. |
| company_id | INTEGER | true | Multi-company identifier | Identifies the legal entity owning this rule. |
| sequence | INTEGER | false | Execution order | Determines the priority of rule application. |
| account_id | INTEGER | true | Target general ledger account | The account to be impacted by this line. |
| journal_id | INTEGER | true | Target journal | The journal associated with this reconciliation line. |
| create_uid | INTEGER | true | Creator user ID | Reference to the user who created the rule. |
| write_uid | INTEGER | true | Last modifier user ID | Reference to the user who last updated the rule. |
| amount_type | VARCHAR | false | Calculation method | Defines how the amount is derived (e.g., fixed, percentage). |
| amount_string | VARCHAR | false | Calculation expression | The raw string representation of the amount logic. |
| analytic_distribution | JSONB | true | Analytic accounting mapping | JSON structure defining cost center or project allocations. |
| label | JSONB | true | Label/Description | Localized or structured labels for the reconciliation line. |
| force_tax_included | BOOLEAN | true | Tax inclusion flag | Indicates if the amount includes tax. |
| create_date | TIMESTAMP | true | Record creation timestamp | In UTC. |
| write_date | TIMESTAMP | true | Last update timestamp | In UTC. |
| amount | DOUBLE PRECISION | true | Fixed amount value | The numeric value used if the rule is fixed-amount based. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `model_id` → `staging.odoo_account_reconcile_model.id` (Inferred from naming convention)
    - `company_id` → `staging.odoo_res_company.id` (Standard Odoo multi-company pattern)
    - `account_id` → `staging.odoo_account_account.id` (Standard Odoo chart of accounts pattern)
    - `journal_id` → `staging.odoo_account_journal.id` (Standard Odoo journal pattern)
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Sensitive Data:** Contains `analytic_distribution` and `label` which may contain internal project names or sensitive business descriptions.
- **Timestamps:** All `create_date` and `write_date` values are assumed to be in UTC, consistent with standard Odoo database storage.
- **Data Format:** `analytic_distribution` and `label` are stored as `JSONB`; ensure your downstream transformation logic handles JSON parsing and potential schema evolution within these fields.
- **Soft Deletes:** This table does not appear to have a `deleted_at` or `active` flag; assume it represents the current state of the configuration as captured during the last ingestion.