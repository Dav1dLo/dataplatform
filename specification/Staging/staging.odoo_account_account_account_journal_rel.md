# odoo_account_account_account_journal_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_account_account_journal_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link the `account.account` model to the `account.journal` model.

## Functional process 
This table supports the financial accounting configuration process, specifically defining which general ledger accounts are permitted or restricted for use within specific accounting journals. It enforces the mapping between journals (e.g., Bank, Cash, Sales) and the chart of accounts.

## Description
One row in this table represents a single association between a specific general ledger account and an accounting journal. It serves as a raw landing copy of the join table used by the Odoo ORM to manage many-to-many relationships between accounts and journals.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_account_id | INTEGER | false | Foreign key to the account definition | References the primary key of the account table. |
| account_journal_id | INTEGER | false | Foreign key to the journal definition | References the primary key of the journal table. |

## Keys

- **Primary key (inferred):** The composite key `(account_account_id, account_journal_id)` is the inferred primary key as this is a standard Odoo join table.
- **Foreign keys (inferred):** 
    - `account_account_id` → `account_account.id`: Links to the specific ledger account definition.
    - `account_journal_id` → `account_journal.id`: Links to the specific accounting journal definition.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; downstream models should use the composite key `(account_account_id, account_journal_id)` for joins.
- There are no timestamps or audit columns present; it is impossible to determine the history of these relationships or when they were created.
- This is a pure mapping table; it contains no business data (amounts, dates, or descriptions) and is intended solely for relational filtering.