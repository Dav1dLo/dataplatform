# odoo_res_partner_bank

## Source system
This table originates from Odoo ERP, specifically the `res.partner.bank` model. The naming convention (e.g., `res_partner_bank`, `create_uid`, `write_date`) is characteristic of the Odoo framework's internal database schema for managing partner bank accounts.

## Functional process 
This table supports the financial and accounting modules, specifically the "Order-to-Cash" and "Procure-to-Pay" processes. It stores bank account details for business partners (customers or vendors), enabling electronic fund transfers, payment processing, and bank reconciliation.

## Description
One row in this table represents a single bank account associated with a specific partner (customer or vendor) in the Odoo system. This is a raw landing table in the Staging layer, providing a direct, un-transformed copy of the Odoo source data for downstream integration.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Sequence-generated ID. |
| partner_id | INTEGER | false | Foreign key to partner | Links to the owner of the bank account. |
| bank_id | INTEGER | true | Foreign key to bank | Links to the bank institution record. |
| sequence | INTEGER | true | Display order | Used for sorting accounts in UI. |
| currency_id | INTEGER | true | Foreign key to currency | Currency associated with the account. |
| company_id | INTEGER | true | Foreign key to company | Multi-company context identifier. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last updater user ID | ID of the user who last modified the record. |
| acc_number | VARCHAR | false | Account number | The raw bank account number. |
| sanitized_acc_number | VARCHAR | true | Sanitized account number | Cleaned version of the account number. |
| acc_holder_name | VARCHAR | true | Account holder name | Name of the person/entity on the account. |
| active | BOOLEAN | true | Active status | Soft-delete flag; false indicates inactive. |
| allow_out_payment | BOOLEAN | true | Outbound payment flag | Indicates if account is used for payments. |
| create_date | TIMESTAMP | true | Creation timestamp | Timestamp of record creation. |
| write_date | TIMESTAMP | true | Modification timestamp | Timestamp of last modification. |
| aba_routing | VARCHAR | true | ABA routing number | US-specific bank routing identifier. |
| has_iban_warning | BOOLEAN | true | IBAN warning flag | Indicates potential IBAN validation issues. |
| has_money_transfer_warning | BOOLEAN | true | Transfer warning flag | Indicates potential transfer restrictions. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `partner_id` → `res_partner.id` (Standard Odoo relationship to the partner entity).
    - `bank_id` → `res_bank.id` (Standard Odoo relationship to the bank institution).
    - `currency_id` → `res_currency.id` (Standard Odoo relationship to currency).
    - `company_id` → `res_company.id` (Standard Odoo relationship to company).
- **Natural keys (inferred):** 
    - `acc_number` (Combined with `partner_id` and `company_id` usually forms the business-level uniqueness).

## Caveats for downstream consumers

- **Sensitive Data:** The `acc_number` and `acc_holder_name` columns contain PII/Financial data and should be masked or restricted based on data governance policies.
- **Timezone:** Timestamps (`create_date`, `write_date`) are stored in UTC by Odoo.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` unless historical data is required.
- **Data Quality:** `sanitized_acc_number` may be null if the Odoo sanitization process was not triggered or failed for specific account formats.