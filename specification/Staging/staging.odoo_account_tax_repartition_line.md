# odoo_account_tax_repartition_line

## Source system
This table originates from Odoo ERP, as evidenced by the naming convention `account_tax_repartition_line` and the presence of standard Odoo audit columns such as `create_uid`, `write_uid`, `create_date`, and `write_date`.

## Functional process 
This table supports the financial accounting and tax reporting process. It defines how tax amounts are distributed across different general ledger accounts (repartition) for specific tax configurations, which is critical for generating accurate tax returns and VAT reports within the Odoo accounting module.

## Description
One row in this table represents a single repartition line for a specific tax, defining the percentage factor and the target account for that portion of the tax. This is a raw landing table in the Staging layer, providing a direct, un-transformed copy of the Odoo `account.tax.repartition.line` model.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `account_tax_repartition_line_id_seq`. |
| account_id | INTEGER | true | Foreign key to the GL account | Links to the account where the tax amount is posted. |
| tax_id | INTEGER | true | Foreign key to the tax definition | Links to the parent tax record. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the organization owning this tax rule. |
| sequence | INTEGER | true | Sort order | Determines the processing order of repartition lines. |
| create_uid | INTEGER | true | Creator user ID | ID of the user who created the record. |
| write_uid | INTEGER | true | Last modifier user ID | ID of the user who last updated the record. |
| repartition_type | VARCHAR | false | Type of repartition | Usually 'base' or 'tax'. |
| document_type | VARCHAR | false | Document context | Defines if this applies to invoices, credit notes, etc. |
| factor_percent | NUMERIC | false | Distribution percentage | The percentage of the tax amount applied to this line. |
| use_in_tax_closing | BOOLEAN | true | Tax closing flag | Indicates if this line is included in tax closing reports. |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded in UTC by Odoo. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded in UTC by Odoo. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `account_id` → `staging.account_account.id` (Guess: standard Odoo relation to GL accounts).
    - `tax_id` → `staging.account_tax.id` (Guess: standard Odoo relation to tax definitions).
    - `company_id` → `staging.res_company.id` (Guess: standard Odoo multi-company architecture).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- **Timestamps:** All `create_date` and `write_date` values are stored in UTC.
- **Soft Deletes:** Odoo typically does not use soft-delete flags; records are usually physically deleted from the source.
- **Data Integrity:** As a staging table, this may contain orphaned records if the parent `tax_id` or `account_id` was deleted in the source system.
- **Precision:** `factor_percent` is `NUMERIC` without defined scale; check source DDL if high-precision rounding is required for financial reporting.