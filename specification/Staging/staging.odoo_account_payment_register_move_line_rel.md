# odoo_account_payment_register_move_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_payment_register_move_line_rel` is characteristic of Odoo's internal ORM-generated join tables, which manage many-to-many relationships between payment registration wizards and specific accounting move lines.

## Functional process 
This table supports the "Accounts Payable/Receivable" payment reconciliation process. It acts as a link between a payment registration wizard session and the specific journal items (move lines) that are being selected for settlement or reconciliation within the Odoo accounting module.

## Description
One row in this table represents a single association between a payment registration wizard instance and a specific accounting move line. It serves as a raw, landed join table used to maintain the many-to-many relationship required for batch payment processing in the staging layer.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| wizard_id | INTEGER | false | Foreign key to the payment registration wizard session. | Links to the specific wizard instance managing the payment. |
| line_id | INTEGER | false | Foreign key to the accounting move line being paid. | References the specific ledger entry or invoice line item. |

## Keys

- **Primary key (inferred):** The combination of (`wizard_id`, `line_id`) is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `wizard_id` → `account_payment_register.id` (Guess: links to the parent wizard session).
    - `line_id` → `account_move_line.id` (Guess: links to the specific accounting transaction line).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; expect high cardinality and frequent inserts/deletes during the lifecycle of a payment registration process.
- No audit timestamps (e.g., `created_at`) are present; rely on the parent `account_payment_register` table for temporal context.
- This table contains no PII, but it is critical for reconstructing financial reconciliation logic.
- Ensure joins to `account_move_line` are handled carefully, as this table only maps the relationship and does not contain the financial amounts themselves.