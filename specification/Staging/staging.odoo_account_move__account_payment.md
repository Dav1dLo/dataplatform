# odoo_account_move__account_payment

## Source system
This table originates from Odoo ERP. The naming convention `odoo_account_move__account_payment` indicates a junction table used to manage the many-to-many relationship between accounting journal entries (`account.move`) and payment records (`account.payment`) within the Odoo financial module.

## Functional process 
This table supports the accounts receivable and accounts payable reconciliation process. It maps specific financial invoices or journal entries to the payments that settle them, ensuring that the ledger reflects the correct payment status for each transaction.

## Description
One row in this table represents a single association between an invoice (or journal entry) and a payment record. It serves as a raw, landed link table in the staging layer, capturing the relational mapping required to reconstruct payment allocations from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_id | INTEGER | false | Foreign key to the account move/invoice record | Maps to the primary key of the Odoo `account_move` table. |
| payment_id | INTEGER | false | Foreign key to the payment record | Maps to the primary key of the Odoo `account_payment` table. |

## Keys

- **Primary key (inferred):** The combination of `invoice_id` and `payment_id` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `invoice_id` → `staging.odoo_account_move.id`: This column links the payment association to the specific invoice or journal entry.
    - `payment_id` → `staging.odoo_account_payment.id`: This column links the association to the specific payment transaction.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a junction table; it contains no financial amounts or dates itself and must be joined to the parent `account_move` and `account_payment` tables to provide context.
- There are no obvious PII columns in this junction table, though the linked parent tables likely contain sensitive financial data.
- As a staging table, this reflects the raw state of the Odoo database; ensure that downstream models handle potential orphaned records if referential integrity is not strictly enforced in the source system.