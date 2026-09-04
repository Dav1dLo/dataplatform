# odoo_account_account_tax_default_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_account_tax_default_rel` is characteristic of Odoo's internal ORM-generated join tables, which manage many-to-many relationships between the chart of accounts and tax configurations.

## Functional process 
This table supports the financial accounting and tax configuration process. It defines the default tax associations for specific general ledger accounts, ensuring that when a transaction is recorded against a specific account, the system can automatically suggest or apply the correct tax rate.

## Description
One row in this table represents a single association between a general ledger account and a default tax rate. It serves as a raw landing copy of the Odoo relational link table, capturing the many-to-many mapping required for automated tax calculation logic.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_id | INTEGER | false | Foreign key to the account definition | Links to the primary account table. |
| tax_id | INTEGER | false | Foreign key to the tax definition | Links to the primary tax configuration table. |

## Keys

- **Primary key (inferred):** Not confidently inferable. While this is a join table, it lacks a surrogate ID; the PK is likely a composite of `(account_id, tax_id)`.
- **Foreign keys (inferred):** 
    - `account_id` → `account_account.id`: This column references the account master data.
    - `tax_id` → `account_tax.id`: This column references the tax master data.
- **Natural keys (inferred):** The combination of `(account_id, tax_id)` acts as the business key for this relationship.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only relational keys.
- There are no timestamps or audit columns present; it is impossible to determine the history or "as-of" state of these relationships from this table alone.
- Ensure joins to parent tables handle potential orphans if the source system's referential integrity is not strictly enforced at the database level.