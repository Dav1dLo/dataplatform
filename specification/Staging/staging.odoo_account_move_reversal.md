# odoo_account_move_reversal

## Source system
This table originates from Odoo ERP, specifically the accounting module. The naming convention `account_move_reversal` and the presence of `journal_id` and `company_id` are characteristic of Odoo's internal database schema for managing ledger entry reversals.

## Functional process 
This table supports the financial accounting process of reversing journal entries. It tracks the metadata associated with the creation of credit notes or reversal entries, linking them to specific journals and companies to ensure auditability of ledger adjustments.

## Description
One row in this table represents a single reversal request or record for an accounting journal entry. It acts as a raw landing copy of the Odoo `account_move_reversal` model, capturing the intent, timing, and user attribution for reversing financial transactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_move_reversal_id_seq`. |
| journal_id | INTEGER | false | Foreign key to the accounting journal | Identifies the journal where the reversal is recorded. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the legal entity associated with the reversal. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who initiated the reversal. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified the record. |
| reason | VARCHAR | true | Textual description of the reversal | Explains the business justification for the reversal. |
| date | DATE | true | Effective date of the reversal | The accounting date applied to the reversal entry. |
| create_date | TIMESTAMP | true | Record creation timestamp | Inferred UTC based on Odoo standard behavior. |
| write_date | TIMESTAMP | true | Last modification timestamp | Inferred UTC based on Odoo standard behavior. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `journal_id` → `staging.account_journal.id` (Inferred from Odoo standard schema naming).
    - `company_id` → `staging.res_company.id` (Inferred from Odoo standard schema naming).
    - `create_uid` → `staging.res_users.id` (Inferred from Odoo standard schema naming).
    - `write_uid` → `staging.res_users.id` (Inferred from Odoo standard schema naming).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo deployments.
- **Sensitive Data:** The `reason` field may contain free-text notes that could potentially include PII; review before exposing to non-privileged users.
- **Data Retention:** This is a staging table; it represents a raw snapshot. It does not explicitly implement soft-delete flags, but Odoo typically manages record lifecycle via `active` flags in other tables; check if an `active` column exists in the source if filtering is required.
- **Precision:** `VARCHAR` length is not explicitly defined in the metadata; downstream consumers should handle variable-length strings appropriately.