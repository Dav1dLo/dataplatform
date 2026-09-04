# odoo_refunded_invoices

## Source system
This table originates from Odoo ERP. The naming convention `account_move` is specific to Odoo's accounting module, where every invoice, credit note, or journal entry is stored as an `account.move` object.

## Functional process 
This table supports the accounts receivable and credit management process. It maps credit notes (refunds) back to the original invoices they are intended to offset, facilitating the reconciliation of customer balances and the tracking of revenue reversals.

## Description
Each row represents a single relationship between a refund document and the original invoice it references. As a staging table, it provides a raw, one-to-one mapping of these document IDs as they exist in the Odoo database, serving as the foundation for downstream financial reporting and audit trails.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| refund_account_move | INTEGER | false | The unique identifier of the credit note (refund) document. | References the `id` column in the Odoo `account_move` table. |
| original_account_move | INTEGER | false | The unique identifier of the original invoice being refunded. | References the `id` column in the Odoo `account_move` table. |

## Keys

- **Primary key (inferred):** `refund_account_move`. Since a single refund document typically targets one specific original invoice in Odoo's standard workflow, this column acts as the unique identifier for the relationship.
- **Foreign keys (inferred):** 
    - `refund_account_move` → `account_move.id`: This column links to the primary record of the credit note.
    - `original_account_move` → `account_move.id`: This column links to the primary record of the original invoice.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains only internal surrogate keys; join with the `account_move` table to retrieve business-meaningful data like invoice numbers, dates, or amounts.
- The table assumes a 1:1 relationship between a refund and an original invoice; if partial refunds are handled via multiple records in the source, ensure your join logic accounts for potential duplicates.
- No sensitive PII is present in this table, as it only contains integer identifiers.