# odoo_account_account_account_merge_wizard_rel

## Source system
This table originates from Odoo ERP. The naming convention `odoo_account_account_account_merge_wizard_rel` is characteristic of Odoo's internal ORM-generated many-to-many relationship tables, specifically linking the account merge wizard process to the specific account records involved in the operation.

## Functional process 
This table supports the "Chart of Accounts maintenance" process, specifically the functionality used to merge duplicate or redundant general ledger accounts. It tracks the association between a specific merge wizard session and the individual account records selected for consolidation.

## Description
One row in this table represents a single link between a merge wizard instance and an account record being processed. It is a raw landing copy of an Odoo join table, serving as the bridge to resolve the many-to-many relationship between merge operations and account entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_merge_wizard_id | INTEGER | false | Foreign key to the account merge wizard instance | Links to the primary wizard record. |
| account_account_id | INTEGER | false | Foreign key to the account record | Links to the specific account being merged. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite primary key on `(account_merge_wizard_id, account_account_id)`.
- **Foreign keys (inferred):** 
    - `account_merge_wizard_id` → `account_merge_wizard.id`: This column identifies the specific wizard session.
    - `account_account_id` → `account_account.id`: This column identifies the account record involved in the merge.
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a join table; it contains no business data other than the relationship between the two entities.
- There are no timestamps or audit columns present in this table; it represents the state of the relationship as captured during the ingestion process.
- Ensure joins to `account_account` are handled carefully, as this table only contains the IDs required to resolve the relationship.