# odoo_account_move_line_account_tax_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates junction tables for many-to-many relationships between business entities.

## Functional process 
This table supports the financial accounting and tax reporting process. It maps individual journal items (`account_move_line`) to the specific tax records (`account_tax`) applied to them, enabling the calculation of tax liabilities and the generation of tax reports from ledger entries.

## Description
One row in this table represents a single association between a specific journal item and a tax record. It serves as a raw, junction-table copy from the Odoo database, facilitating the resolution of many-to-many relationships between accounting movements and tax definitions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_line_id | INTEGER | false | Foreign key to the journal item | Links to the `account_move_line` table. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Links to the `account_tax` table. |

## Keys

- **Primary key (inferred):** The composite key `(account_move_line_id, account_tax_id)`.
- **Foreign keys (inferred):** 
    - `account_move_line_id` → `staging.account_move_line.id`: This column references the primary key of the journal item table.
    - `account_tax_id` → `staging.account_tax.id`: This column references the primary key of the tax definition table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; expect multiple rows per `account_move_line_id` if a single journal item is subject to multiple taxes.
- There are no audit timestamps (e.g., `create_date` or `write_date`) present in this table; tracking changes to these associations requires joining against the parent tables or using CDC logs.
- This table contains no PII, but it is critical for financial reconciliation; ensure joins are handled as inner joins unless you are specifically looking for untaxed items.