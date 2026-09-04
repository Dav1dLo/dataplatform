# odoo_account_account_tag_account_move_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific entity names `account_move_line` and `account_account_tag` is characteristic of Odoo's internal many-to-many relationship tables, which are automatically generated to link accounting journal entries to specific analytical or reporting tags.

## Functional process 
This table supports the financial reporting and analytical accounting process. It facilitates the many-to-many relationship between individual journal items (`account_move_line`) and accounting tags (`account_account_tag`), allowing a single transaction line to be categorized under multiple reporting or tax-related tags for downstream financial analysis.

## Description
One row in this table represents a single association between a specific journal entry line and an accounting tag. It serves as a raw landing copy of the Odoo join table, maintaining the link between transactional data and its associated metadata tags at the grain of one row per unique relationship instance.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_move_line_id | INTEGER | false | Foreign key to the journal entry line | Links to the primary key of the `account_move_line` table. |
| account_account_tag_id | INTEGER | false | Foreign key to the accounting tag | Links to the primary key of the `account_account_tag` table. |

## Keys

- **Primary key (inferred):** The composite key of (`account_move_line_id`, `account_account_tag_id`).
- **Foreign keys (inferred):** 
    - `account_move_line_id` → `account_move_line.id`: This column references the specific journal item being tagged.
    - `account_account_tag_id` → `account_account_tag.id`: This column references the specific tag applied to the journal item.
- **Natural keys (inferred):** Not confidently inferable; this is a pure join table representing a relationship rather than a business entity with a natural key.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table reflects the current state of relationships as captured during the ingestion process.
- Ensure that joins to `account_move_line` and `account_account_tag` are handled as inner joins if you only require records with valid, existing associations.
- As a staging table, this data is raw; verify the existence of referenced IDs in the parent tables before performing complex analytical joins.