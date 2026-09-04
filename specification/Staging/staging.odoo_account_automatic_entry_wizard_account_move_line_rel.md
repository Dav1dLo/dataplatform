# odoo_account_automatic_entry_wizard_account_move_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefix `account_automatic_entry_wizard` indicates this is a standard Odoo many-to-many join table used to link wizard session instances to specific accounting journal entries.

## Functional process 
This table supports the "Automatic Entry" accounting process in Odoo, which allows users to automate the creation of adjusting journal entries (e.g., for accruals or deferrals). It tracks the relationship between a specific wizard execution session and the individual journal line items that are being processed or adjusted by that wizard.

## Description
One row in this table represents a single association between an automatic entry wizard instance and a specific account move line. It serves as a raw, junction-table copy from the Odoo database, maintaining the link between the configuration wizard and the underlying accounting ledger entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_automatic_entry_wizard_id | INTEGER | false | Foreign key to the wizard session | Links to the Odoo `account_automatic_entry_wizard` table. |
| account_move_line_id | INTEGER | false | Foreign key to the journal line | Links to the Odoo `account_move_line` table. |

## Keys

- **Primary key (inferred):** The composite of (`account_automatic_entry_wizard_id`, `account_move_line_id`).
- **Foreign keys (inferred):** 
    - `account_automatic_entry_wizard_id` → `account_automatic_entry_wizard.id`: This column identifies the specific wizard session that triggered the entry.
    - `account_move_line_id` → `account_move_line.id`: This column identifies the specific ledger line item being processed.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; it contains no business data other than the relationship between two entities.
- There are no timestamps or audit columns present in this table; rely on the parent tables for creation or modification context.
- Ensure joins to parent tables handle potential missing records if the source system performs hard deletes on wizard sessions.