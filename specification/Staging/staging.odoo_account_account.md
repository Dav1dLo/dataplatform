# odoo_account_account

## Source system

Odoo ERP (specifically the core accounting module, `account.account`). This inference is strongly supported by the table naming pattern `odoo_account_account`, the standard Odoo framework audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and modern Odoo (v16+) JSONB structures used for localized/translatable fields (`name`, `code_store`).

## Functional process

Record-to-Report (General Ledger Management). This table defines the Master Chart of Accounts used across the organization to categorize, aggregate, and report financial transactions. It supports downstream ledger entries, reconciliation workflows (via `reconcile`), and financial statement preparation (balance sheets and income statements via `account_type`).

## Description

Each row represents a single general ledger (GL) account within the Chart of Accounts. The table is defined at the grain of one row per account record. In the Staging layer, this table serves as a raw-to-silver mirror of Odoo's operational account definitions, acting as the primary dimension source for financial accounting models and journal entry lookups.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Technical surrogate primary key | Generated via sequence `staging.account_account_id_seq`. |
| currency_id | INTEGER | true | Foreign key to currency master | References source currency; if null, the account uses the default legal entity currency. |
| create_uid | INTEGER | true | User ID of the record creator | Audit column referencing source Odoo user (`res_users`). |
| write_uid | INTEGER | true | User ID of the last updater | Audit column referencing source Odoo user (`res_users`). |
| account_type | VARCHAR | false | Classification/hierarchy category for the account | Bare VARCHAR in source; typical values include categories like `asset_receivable`, `liability_payable`, `equity`. Confirm downstream length sizing (suggest `varchar(64)`). |
| name | JSONB | false | Translatable account title/name | JSON structure mapping locale codes (e.g., `{"en_US": "Accounts Receivable"}`) to names. |
| code_store | JSONB | true | Company-specific account code mapping | Multi-company mapping of account codes in modern Odoo (e.g., `{"1": "120000"}`). Requires JSON extraction. |
| note | TEXT | true | Internal accounting remarks or operational guidance | Freeform unconstrained text. |
| deprecated | BOOLEAN | true | Soft-deprecation or archive indicator | When `true`, the account is deactivated and blocked from manual journal posting. |
| reconcile | BOOLEAN | true | Reconciliation capability flag | Indicates whether open items in this account can be matched/reconciled (e.g., AR/AP/bank accounts). |
| non_trade | BOOLEAN | true | Indicator for non-trade accounting | Distinguishes non-trade receivables/payables from core trading operations. |
| create_date | TIMESTAMP | true | Audit timestamp of row creation | Bare timestamp without timezone; Odoo stores timestamps natively in UTC. |
| write_date | TIMESTAMP | true | Audit timestamp of last row update | Bare timestamp without timezone; Odoo stores timestamps natively in UTC. |

## Keys

- **Primary key (inferred):** `id` (source sequence-backed identifier).
- **Foreign keys (inferred):**
  - `currency_id → odoo_res_currency.id`: References the operational currency master record.
  - `create_uid → odoo_res_users.id`: References the system user who created the account.
  - `write_uid → odoo_res_users.id`: References the system user who last modified the account.
- **Natural keys (inferred):** Accounting code extracted from `code_store` (scoped per company context), representing the business account code.

## Caveats for downstream consumers

- `name` and `code_store` are stored as `JSONB` structures to accommodate localization and multi-company account codes; downstream models must unpack these using PostgreSQL JSON operators (e.g., `code_store->>'1'` or `name->>'en_US'`).
- The `account_type` column is an unconstrained `VARCHAR` in the landing layer; downstream dimensional tables should size this explicitly based on observed categorical domains.
- Timestamps (`create_date`, `write_date`) do not carry timezone offsets (`TIMESTAMP WITHOUT TIME ZONE`), but should be assumed UTC based on Odoo core architecture.
- Check the `deprecated` flag when filtering for active general ledger accounts (`deprecated IS NOT TRUE`).
- Contains no direct consumer PII, though the `note` field contains free-form text that may occasionally contain unmasked operational commentary.