# odoo_account_account_res_company_rel

## Source system
This table originates from Odoo ERP. The naming convention `res_company_id` and `account_account_id` with a `_rel` suffix is characteristic of Odoo's internal ORM-generated many-to-many relationship tables, which link accounting charts to specific company entities.

## Functional process 
This table supports the multi-company accounting configuration process. It defines the mapping between financial accounts (`account_account`) and the companies (`res_company`) that are authorized to use or share those accounts within the Odoo environment.

## Description
Each row represents a single association between a specific financial account and a company entity. It acts as a join table to enforce multi-company data scoping, ensuring that only relevant accounts are available for selection within a company's specific accounting workspace.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| account_account_id | INTEGER | false | Foreign key to the account definition | References the primary key of the account table. |
| res_company_id | INTEGER | false | Foreign key to the company definition | References the primary key of the company table. |

## Keys

- **Primary key (inferred):** The combination of `account_account_id` and `res_company_id`.
- **Foreign keys (inferred):** 
    - `account_account_id` → `account_account.id`: Links to the master list of financial accounts.
    - `res_company_id` → `res_company.id`: Links to the master list of company entities.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a link table; it contains no descriptive attributes, only identifiers.
- Expect high cardinality if the Odoo instance manages a large number of companies and shared chart of accounts.
- There are no timestamps or soft-delete flags; this table represents the current state of the relationship configuration.