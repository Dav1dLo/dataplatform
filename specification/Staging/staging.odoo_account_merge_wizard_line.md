# odoo_account_merge_wizard_line

## Source system
This table originates from Odoo ERP. The naming convention `account_merge_wizard_line` and the presence of audit columns like `create_uid`, `write_uid`, and `display_type` are characteristic of Odoo's internal ORM-generated tables used for managing data cleanup wizards.

## Functional process 
This table supports the "Chart of Accounts" maintenance process, specifically the merging of duplicate or redundant account records. It acts as a temporary staging area for the lines processed by an account merge wizard, tracking which accounts are selected for consolidation and how they are grouped.

## Description
One row in this table represents a single line item within an account merge wizard session, identifying a specific account record being evaluated for a merge operation. As a staging table, it provides a raw, landed copy of the wizard's transient state, capturing the selection status and grouping logic applied during the merge process.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_merge_wizard_line_id_seq`. |
| wizard_id | INTEGER | false | Foreign key to the parent wizard | Links to the specific merge wizard session. |
| sequence | INTEGER | true | Display order | Used to sort lines within the wizard UI. |
| account_id | INTEGER | true | Target account reference | The ID of the account record being processed. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who initiated the wizard line. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the line. |
| grouping_key | VARCHAR | true | Merge grouping identifier | Logic key used to identify accounts that should be merged together. |
| display_type | VARCHAR | false | UI rendering type | Determines how the line is rendered (e.g., section, note, or record). |
| is_selected | BOOLEAN | true | Selection status | Flag indicating if this account is marked for merging. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `wizard_id` → `staging.odoo_account_merge_wizard.id` (Inferred from standard Odoo naming patterns for wizard lines).
    - `account_id` → `staging.odoo_account_account.id` (Inferred from the column name and business context of merging accounts).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the Odoo application server time (typically UTC), but verify against the source system configuration.
- **Data volatility:** As a "wizard line" table, this data is transient and may be truncated or cleared by the Odoo application once the merge operation is completed.
- **Sensitive data:** No direct PII is present, but `create_uid` and `write_uid` link to internal user IDs which may be considered sensitive in some compliance contexts.
- **Soft deletes:** This table does not appear to implement soft deletes; rows are likely managed by the application lifecycle.