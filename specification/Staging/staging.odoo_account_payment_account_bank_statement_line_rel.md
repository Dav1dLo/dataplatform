# odoo_account_payment_account_bank_statement_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_payment_account_bank_statement_line_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link payment records to specific bank statement line entries within the accounting module.

## Functional process 
This table supports the bank reconciliation process within the Odoo accounting module. It maintains the link between payment records (representing money sent or received) and the specific bank statement lines (representing the transaction as recorded by the bank) to ensure financial records are balanced and reconciled.

## Description
One row in this table represents a single association between a payment record and a bank statement line. It acts as a join table at the grain of the relationship, facilitating the many-to-many mapping required when a single payment might be split across multiple statement lines or vice versa. This is a raw landed copy of the Odoo relational link table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_bank_statement_line_id | INTEGER | false | Foreign key to the bank statement line | Links to the specific transaction line on a bank statement. |
| account_payment_id | INTEGER | false | Foreign key to the payment record | Links to the internal payment document. |

## Keys

- **Primary key (inferred):** The composite of (`account_bank_statement_line_id`, `account_payment_id`).
- **Foreign keys (inferred):** 
    - `account_bank_statement_line_id` → `account_bank_statement_line.id`: This column references the primary key of the bank statement line table.
    - `account_payment_id` → `account_payment.id`: This column references the primary key of the payment table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it is a pure relational mapping table.
- There are no sensitive PII columns in this specific join table, though the linked parent tables likely contain financial data.
- As a join table, it does not contain soft-delete flags; if a relationship is removed in Odoo, the row is typically deleted from this table.
- Ensure inner joins are used when querying to avoid orphaned references if the source system has not enforced referential integrity.