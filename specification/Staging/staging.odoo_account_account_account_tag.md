# odoo_account_account_account_tag

## Source system
This table originates from Odoo ERP. The naming convention `odoo_account_account_account_tag` is characteristic of Odoo's ORM-generated join tables, which link the `account.account` model to the `account.account.tag` model.

## Functional process 
This table supports the financial reporting and accounting configuration process. It facilitates a many-to-many relationship between general ledger accounts and specific accounting tags, which are often used for tax reporting, analytical accounting, or grouping accounts for financial statement presentation.

## Description
One row in this table represents a single association between a general ledger account and an accounting tag. It serves as a raw landing copy of the join table from the Odoo database, maintaining the link between account definitions and their assigned classification tags.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_account_id | INTEGER | false | Foreign key to the account definition | Links to the primary key of the account table. |
| account_account_tag_id | INTEGER | false | Foreign key to the account tag definition | Links to the primary key of the account tag table. |

## Keys

- **Primary key (inferred):** The combination of `(account_account_id, account_account_tag_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `account_account_id` → `account_account.id`: This column references the specific general ledger account being tagged.
    - `account_account_tag_id` → `account_account_tag.id`: This column references the specific tag applied to the account.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or soft-delete flags present; this table reflects the current state of associations as captured during the last ingestion.
- Ensure that joins to the parent tables (`account_account` and `account_account_tag`) are handled as inner joins if you only require records with valid, existing associations.