# odoo_account_journal_account_reconcile_model_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefixes `account_journal` and `account_reconcile_model` is characteristic of Odoo's many-to-many relationship tables, which link journals to reconciliation models.

## Functional process 
This table supports the financial accounting configuration process. It defines the many-to-many relationship between accounting journals (e.g., Bank, Cash, Sales) and reconciliation models, which are used to automate the matching of bank statement lines to invoices or payments.

## Description
One row in this table represents a single association between a specific accounting journal and a reconciliation model. It acts as a join table in the Odoo schema, enabling a reconciliation model to be applied to multiple journals, or a journal to utilize multiple reconciliation models. It serves as a raw landed copy of the Odoo relational link.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_reconcile_model_id | INTEGER | false | Foreign key to the reconciliation model definition. | Links to `account_reconcile_model.id`. |
| account_journal_id | INTEGER | false | Foreign key to the accounting journal. | Links to `account_journal.id`. |

## Keys

- **Primary key (inferred):** The composite key `(account_reconcile_model_id, account_journal_id)`.
- **Foreign keys (inferred):** 
    - `account_reconcile_model_id` → `staging.account_reconcile_model.id`: This column references the definition of the reconciliation model.
    - `account_journal_id` → `staging.account_journal.id`: This column references the specific journal entity.
- **Natural keys (inferred):** Not confidently inferable; this is a pure join table.

## Caveats for downstream consumers

- This table contains no descriptive attributes, only relational links.
- There are no timestamps or audit columns present in this table; it represents the current state of the relationship as captured during the last ingestion.
- Ensure that joins to the parent tables (`account_journal` and `account_reconcile_model`) handle the many-to-many cardinality correctly to avoid row duplication in downstream reporting.