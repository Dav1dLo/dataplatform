# odoo_account_move_reversal_move

## Source system
This table originates from Odoo ERP. The naming convention `account_move_reversal_move` is characteristic of Odoo's accounting module, which manages journal entries and their associated reversal transactions.

## Functional process 
This table supports the accounting reversal process, specifically tracking the relationship between an original journal entry (`move_id`) and the corresponding reversal entry (`reversal_id`) created to offset it. This is critical for audit trails in financial reporting and general ledger integrity.

## Description
One row represents a single link between an accounting journal entry and its designated reversal entry. It acts as a raw mapping table in the staging layer, capturing the association created when a user triggers a "Reverse Entry" action in the Odoo accounting interface.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| reversal_id | INTEGER | false | The ID of the journal entry that performs the reversal. | References `account_move.id`. |
| move_id | INTEGER | false | The ID of the original journal entry being reversed. | References `account_move.id`. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata (likely a composite key of `reversal_id` and `move_id`).
- **Foreign keys (inferred):** 
    - `reversal_id` → `account_move.id`: This column points to the specific journal entry record acting as the reversal.
    - `move_id` → `account_move.id`: This column points to the original journal entry record being offset.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no timestamps or audit metadata; it is a pure join table.
- There are no sensitive PII columns in this specific mapping table.
- Ensure that joins to `account_move` handle potential missing records if the source system has undergone partial data purges.
- The table structure implies a 1:1 or N:1 relationship between reversals and moves; verify cardinality in the source system before performing joins.