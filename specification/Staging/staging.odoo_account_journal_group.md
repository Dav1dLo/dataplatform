# odoo_account_journal_group

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention (`odoo_account_journal_group`), the use of Odoo-specific audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`), and the `JSONB` data type for the `name` field, which is characteristic of Odoo's multi-language field storage.

## Functional process 
This table supports the financial accounting module's configuration, specifically the grouping of journals for reporting or dashboard filtering purposes. It allows users to categorize multiple accounting journals (e.g., "Sales Journals" or "Bank Journals") into a single logical group to streamline financial statement generation and analytical reporting.

## Description
One row in this table represents a single journal group configuration within the Odoo accounting module. It acts as a raw landed copy of the Odoo `account.journal.group` model, capturing the metadata and organizational hierarchy for journal groupings.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID from Odoo. |
| company_id | INTEGER | true | Foreign key to the company | Links the group to a specific entity in a multi-company setup. |
| sequence | INTEGER | true | Display order | Used to determine the sort order of groups in the UI. |
| create_uid | INTEGER | true | Creator user ID | References the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | References the user who last updated this record. |
| name | JSONB | false | Group name | Multi-language string storage; requires extraction of the relevant locale. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by the Odoo application. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by the Odoo application. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Guess: standard Odoo pattern for multi-company isolation).
    - `create_uid` → `res_users.id` (Guess: standard Odoo audit trail for record creation).
    - `write_uid` → `res_users.id` (Guess: standard Odoo audit trail for record modification).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **JSONB Handling:** The `name` column contains localized strings. Downstream queries will need to use the `->>` operator (e.g., `name->>'en_US'`) to extract the desired language.
- **Timezone:** Timestamps are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume records are hard-deleted if removed from the source.
- **Audit Columns:** `create_uid` and `write_uid` refer to internal Odoo user IDs, which may not be present in this staging schema; join with caution.