# odoo_account_move_account_move_send_batch_wizard_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_move_account_move_send_batch_wizard_rel` is characteristic of Odoo's internal ORM-generated join tables for many-to-many relationships between account moves and batch processing wizards.

## Functional process 
This table supports the batch processing of accounting documents (invoices or journal entries). It links specific accounting entries (`account_move`) to a batch wizard session, allowing users to perform bulk actions such as sending, printing, or emailing multiple invoices simultaneously.

## Description
One row in this table represents a single association between an accounting move and a batch wizard instance. It is a raw landing copy of an Odoo many-to-many join table, used to maintain the relationship state during the execution of a batch operation.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_send_batch_wizard_id | INTEGER | false | Foreign key to the batch wizard session | Links to the wizard instance managing the batch. |
| account_move_id | INTEGER | false | Foreign key to the accounting entry | Links to the specific invoice or journal entry being processed. |

## Keys

- **Primary key (inferred):** The composite of (`account_move_send_batch_wizard_id`, `account_move_id`).
- **Foreign keys (inferred):** 
    - `account_move_send_batch_wizard_id` → `account_move_send_batch_wizard.id` (Inferred from Odoo naming conventions for join tables).
    - `account_move_id` → `account_move.id` (Inferred from Odoo naming conventions for join tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a technical join table; it does not contain business logic or timestamps itself.
- There are no sensitive PII columns in this specific table.
- As a join table, it is likely truncated or purged by the Odoo system once the batch wizard session is completed or closed.
- Ensure joins to `account_move` are handled carefully as this table only tracks the association, not the status of the move itself.