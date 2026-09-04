# odoo_account_move_account_resequence_wizard_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module-related entities `account_resequence_wizard` and `account_move` indicates this is a standard Odoo many-to-many join table used to manage the relationship between resequencing wizard sessions and the accounting journal entries being processed.

## Functional process 
This table supports the accounting journal entry resequencing process. It tracks which specific journal entries (`account_move`) are associated with a particular resequencing operation initiated via the `account_resequence_wizard`, allowing the system to batch-update sequence numbers for a set of moves.

## Description
One row in this table represents a single association between a resequencing wizard instance and a specific accounting journal entry. It serves as a raw landing copy of the Odoo relational link table, maintaining the many-to-many relationship required to process multiple moves within a single resequencing task.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_resequence_wizard_id | INTEGER | false | Foreign key to the resequencing wizard session. | Links to the wizard configuration record. |
| account_move_id | INTEGER | false | Foreign key to the accounting journal entry. | Identifies the specific move being resequenced. |

## Keys

- **Primary key (inferred):** The combination of `(account_resequence_wizard_id, account_move_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_resequence_wizard_id` → `account_resequence_wizard.id` (Inferred from Odoo naming conventions for relational tables).
    - `account_move_id` → `account_move.id` (Inferred from Odoo naming conventions for relational tables).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a join table; it contains no business data other than the relationship between the two entities.
- There are no timestamps or audit columns present in this table.
- Ensure that joins to `account_move` or `account_resequence_wizard` handle the potential for missing records if the source system has performed cascading deletes.
- This table is strictly for structural mapping; do not use it to derive financial totals or move statuses.