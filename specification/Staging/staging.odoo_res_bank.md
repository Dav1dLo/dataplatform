# odoo_res_bank

## Source system
This table originates from Odoo ERP, specifically the `res.bank` model. The naming convention (e.g., `res_bank`, `create_uid`, `write_uid`, `bic`) is characteristic of the Odoo framework's base module, which manages bank master data for financial transactions and partner contact information.

## Functional process 
This table supports the master data management process for banking institutions. It serves as a central repository for bank details used across the platform, particularly in the accounting and invoicing modules to facilitate bank transfers, validate BIC/SWIFT codes, and maintain contact information for financial partners.

## Description
One row in this table represents a single bank entity registered within the Odoo system. It captures the bank's name, physical address, contact details, and unique identification codes (BIC). As a staging table, it provides a raw, landed copy of the Odoo `res.bank` model, intended for use in downstream dimensional modeling or integration pipelines.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.res_bank_id_seq`. |
| state | INTEGER | true | Foreign key to state/province | Links to `res.country.state` table. |
| country | INTEGER | true | Foreign key to country | Links to `res.country` table. |
| create_uid | INTEGER | true | Creator user ID | Links to `res.users` table. |
| write_uid | INTEGER | true | Last modifier user ID | Links to `res.users` table. |
| name | VARCHAR | false | Bank name | The display name of the financial institution. |
| street | VARCHAR | true | Street address line 1 | Primary address line. |
| street2 | VARCHAR | true | Street address line 2 | Secondary address line. |
| zip | VARCHAR | true | Postal code | |
| city | VARCHAR | true | City name | |
| email | VARCHAR | true | Contact email address | |
| phone | VARCHAR | true | Contact phone number | |
| bic | VARCHAR | true | Bank Identifier Code | Also known as SWIFT code. |
| active | BOOLEAN | true | Soft-delete flag | If false, the bank is archived in Odoo. |
| create_date | TIMESTAMP | true | Record creation timestamp | Assumed UTC. |
| write_date | TIMESTAMP | true | Last modification timestamp | Assumed UTC. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `state` → `staging.res_country_state.id` (Inferred from Odoo standard schema).
    - `country` → `staging.res_country.id` (Inferred from Odoo standard schema).
    - `create_uid` → `staging.res_users.id` (Inferred from Odoo standard schema).
    - `write_uid` → `staging.res_users.id` (Inferred from Odoo standard schema).
- **Natural keys (inferred):** 
    - `bic` (While not always mandatory, the BIC is the unique business identifier for banks globally).

## Caveats for downstream consumers

- **Sensitive Data:** Contains contact information (`email`, `phone`) which may be considered PII depending on local regulations.
- **Timestamps:** `create_date` and `write_date` are assumed to be in UTC, consistent with Odoo's internal storage format.
- **Soft Deletes:** The `active` column indicates a soft-delete pattern; ensure queries filter by `active = true` if only current, valid banks are required.
- **Data Quality:** `street`, `zip`, and `city` fields are often free-text in Odoo and may contain inconsistent formatting.