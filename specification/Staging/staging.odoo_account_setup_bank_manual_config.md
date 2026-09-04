# odoo_account_setup_bank_manual_config

## Source system
This table originates from Odoo ERP, specifically the accounting or banking module. The naming convention `res_partner_bank_id` and the presence of `create_uid`/`write_uid` audit fields are characteristic of Odoo's ORM-based database schema.

## Functional process 
This table supports the bank account configuration and journal setup process within the Odoo accounting module. It tracks the manual configuration of bank journals linked to specific partner bank accounts, likely used during the initial setup or onboarding of banking integrations to ensure that financial journals are correctly mapped to bank entities.

## Description
One row in this table represents a manual configuration record for a bank journal associated with a specific partner bank account. It serves as a raw landing copy of the Odoo configuration entity, capturing the state of journal setup and the audit trail of who created or modified the configuration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_setup_bank_manual_config_id_seq`. |
| res_partner_bank_id | INTEGER | false | Foreign key to bank account | Links to the `res_partner_bank` table. |
| num_journals_without_account | INTEGER | true | Count of journals | Number of journals currently lacking an associated account. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created this record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated this record. |
| new_journal_name | VARCHAR | false | Journal name | The name assigned to the new bank journal. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp when the record was created. |
| write_date | TIMESTAMP | true | Last update timestamp | Timestamp when the record was last modified. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `res_partner_bank_id` → `res_partner_bank.id` (Inferred from Odoo naming convention for partner bank relations).
    - `create_uid` → `res_users.id` (Standard Odoo pattern for user audit fields).
    - `write_uid` → `res_users.id` (Standard Odoo pattern for user audit fields).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- Timestamps (`create_date`, `write_date`) are assumed to be in UTC, consistent with standard Odoo server configurations.
- This table contains audit user IDs (`create_uid`, `write_uid`) which may need to be joined against a user dimension to resolve human-readable names.
- No explicit soft-delete flag is present; assume records are hard-deleted if removed from the source system.
- The `VARCHAR` column `new_journal_name` does not specify a length; downstream systems should account for potential truncation if mapping to fixed-width fields.