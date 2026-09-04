# odoo_account_move_reversal_new_move

## Source system
This table originates from Odoo ERP, specifically tracking the relational mapping between accounting reversal entries and their corresponding new journal entries. The naming convention `account_move_reversal` is a standard pattern found in Odoo's accounting module database schema.

## Functional process 
This table supports the financial audit and reconciliation process by maintaining the link between an original accounting move that has been reversed and the new "reversal" move created to offset it. It ensures that the ledger remains balanced by explicitly mapping the relationship between the two distinct journal entries.

## Description
One row in this table represents a single link between a reversal request and the resulting accounting move generated in the system. It acts as a join table at the grain of one row per reversal-to-new-move relationship, serving as a raw landing copy of the Odoo relational mapping table.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| reversal_id | INTEGER | false | Foreign key to the original account move reversal record. | Represents the ID of the reversal event. |
| new_move_id | INTEGER | false | Foreign key to the newly created account move. | Represents the ID of the offsetting journal entry. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite key of (`reversal_id`, `new_move_id`).
- **Foreign keys (inferred):** 
    - `reversal_id` → `account_move_reversal.id`: Guessed based on Odoo naming conventions for relational mapping tables.
    - `new_move_id` → `account_move.id`: Guessed based on Odoo naming conventions for journal entry tables.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no timestamps or audit columns; it is a pure relational mapping.
- Ensure joins to `account_move` are handled carefully, as Odoo IDs are often scoped to specific company instances in multi-tenant environments.
- There is no soft-delete flag; assume this table represents the current state of the reversal relationships as captured during the last ingestion.