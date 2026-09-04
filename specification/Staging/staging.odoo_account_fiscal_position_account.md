# odoo_account_fiscal_position_account

## Source system
This table originates from Odoo ERP. The naming convention `account_fiscal_position_account` and the presence of `position_id`, `account_src_id`, and `account_dest_id` are characteristic of Odoo's accounting module, which manages tax mapping and fiscal position rules.

## Functional process 
This table supports the accounting configuration process, specifically the mapping of tax accounts based on fiscal positions. It defines how specific general ledger accounts should be substituted when a particular fiscal position (e.g., tax-exempt, intra-community trade) is applied to a transaction.

## Description
One row in this table represents a single account mapping rule within a specific fiscal position. It acts as a raw landed copy of the Odoo configuration table, capturing the relationship between a source account and its destination account under defined fiscal conditions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Auto-incrementing sequence. |
| position_id | INTEGER | false | Foreign key to fiscal position | Links to the parent fiscal position definition. |
| company_id | INTEGER | true | Company identifier | Multi-company context for the mapping rule. |
| account_src_id | INTEGER | false | Source account ID | The original account to be replaced. |
| account_dest_id | INTEGER | false | Destination account ID | The account to use instead of the source. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by Odoo. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `position_id` → `account_fiscal_position.id` (Likely target based on Odoo schema naming).
    - `account_src_id` → `account_account.id` (Likely target for general ledger accounts).
    - `account_dest_id` → `account_account.id` (Likely target for general ledger accounts).
    - `company_id` → `res_company.id` (Standard Odoo multi-company link).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in UTC as per standard Odoo behavior.
- **Soft Deletes:** This table does not appear to implement soft deletes; it reflects the current state of the configuration as landed from the source.
- **Data Integrity:** `company_id` is nullable, which may imply global configuration rules that apply across all companies if left blank.
- **PII:** No PII is present in this table; it contains only configuration and system IDs.