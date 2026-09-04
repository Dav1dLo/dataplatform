# odoo_journal_account_control_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables for many-to-many relationships between business objects.

## Functional process 
This table supports the financial accounting module, specifically the configuration of journals. It defines the "Allowed Accounts" control mechanism, which restricts which general ledger accounts can be used within a specific accounting journal.

## Description
One row represents a single association between a financial journal and a permitted general ledger account. This is a raw landing of a many-to-many join table, serving as the source for downstream configuration dimensions or validation logic in the data warehouse.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| journal_id | INTEGER | false | Foreign key to the accounting journal | Maps to the primary key of the journal definition table. |
| account_id | INTEGER | false | Foreign key to the chart of accounts | Maps to the primary key of the account definition table. |

## Keys

- **Primary key (inferred):** Composite key of (`journal_id`, `account_id`).
- **Foreign keys (inferred):** 
    - `journal_id` → `account_journal.id`: This column links to the journal configuration entity.
    - `account_id` → `account_account.id`: This column links to the specific general ledger account allowed for the journal.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure junction table; it contains no descriptive attributes, only identifiers.
- There are no audit timestamps (e.g., `create_date` or `write_date`) present in this staging table, so incremental loading based on modification time is not possible.
- Ensure inner joins are used when filtering by journal or account to avoid orphaned records if the source system has referential integrity gaps.