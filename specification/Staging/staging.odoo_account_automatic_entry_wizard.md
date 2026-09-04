# odoo_account_automatic_entry_wizard

## Source system
This table originates from Odoo ERP. The naming convention `account_automatic_entry_wizard` and the presence of standard Odoo audit columns (`create_uid`, `write_uid`, `create_date`, `write_date`) are characteristic of Odoo's internal transient models used for managing automated accounting entries.

## Functional process 
This table supports the automated accounting adjustment process, specifically the "Automatic Entry" wizard functionality. It tracks the configuration of automated journal entries, such as deferrals or accruals, by capturing the target account, the percentage or total amount to be reallocated, and the effective date of the entry.

## Description
One row represents a single configuration instance of an automatic accounting entry wizard session. It serves as a raw landing copy of the wizard's state, capturing the parameters defined by a user before the system generates the corresponding journal entries.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated. |
| company_id | INTEGER | false | Foreign key to the company | Identifies the legal entity for the entry. |
| destination_account_id | INTEGER | true | Foreign key to the target account | The account where the balance is being moved. |
| create_uid | INTEGER | true | User ID who created the record | Reference to the res.users table. |
| write_uid | INTEGER | true | User ID who last updated the record | Reference to the res.users table. |
| action | VARCHAR | false | Type of automatic action | Defines the logic (e.g., 'change', 'split'). |
| account_type | VARCHAR | true | Category of the account | Used for filtering or validation logic. |
| date | DATE | false | Effective date of the entry | The accounting date for the transaction. |
| total_amount | NUMERIC | true | Total value to be processed | Monetary value; precision depends on company currency. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last update timestamp | UTC assumed. |
| percentage | DOUBLE PRECISION | true | Percentage to allocate | Used when splitting amounts by ratio. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture).
    - `destination_account_id` → `account_account.id` (Links to the chart of accounts).
    - `create_uid` → `res_users.id` (Links to the user who initiated the wizard).
    - `write_uid` → `res_users.id` (Links to the user who last modified the wizard).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Sensitive Data:** Contains user IDs (`create_uid`, `write_uid`) which may be considered PII depending on your organization's data governance policy.
- **Timestamps:** All `create_date` and `write_date` fields are assumed to be in UTC, consistent with Odoo's internal storage.
- **Data Retention:** This table represents a "wizard" state; rows may be transient or ephemeral depending on Odoo's cleanup routines for wizard models.
- **Precision:** `total_amount` is a `NUMERIC` type without defined scale; verify if downstream systems require explicit rounding to 2 decimal places.