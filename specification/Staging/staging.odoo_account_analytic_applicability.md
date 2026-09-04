# odoo_account_analytic_applicability

## Source system
This table originates from Odoo ERP, specifically the accounting module. The naming convention `account_analytic_applicability` and the presence of columns like `analytic_plan_id` and `product_categ_id` are characteristic of Odoo's analytic accounting configuration, which dictates how analytic accounts are applied to financial transactions.

## Functional process 
This table supports the configuration of analytic accounting rules. It defines the business logic for when and how analytic accounts should be applied to financial records based on business domains, product categories, or account prefixes, facilitating automated cost center allocation.

## Description
One row in this table represents a single configuration rule that determines the applicability of analytic accounting for a specific business context. As a staging table, it serves as a raw, landed copy of the Odoo `account.analytic.applicability` model, capturing the criteria used to trigger analytic distributions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_analytic_applicability_id_seq`. |
| analytic_plan_id | INTEGER | true | Foreign key to the analytic plan | Links to the specific analytic plan being configured. |
| company_id | INTEGER | true | Foreign key to the company | Identifies the organization scope for this rule. |
| create_uid | INTEGER | true | User ID who created the record | References the system user who defined this rule. |
| write_uid | INTEGER | true | User ID who last updated the record | References the system user who last modified this rule. |
| business_domain | VARCHAR | false | Business domain identifier | Defines the module or area (e.g., 'invoice', 'purchase') the rule applies to. |
| applicability | VARCHAR | false | Applicability mode | Defines the strictness or mode of the rule (e.g., 'optional', 'mandatory'). |
| create_date | TIMESTAMP | true | Creation timestamp | Recorded by the Odoo ORM upon record insertion. |
| write_date | TIMESTAMP | true | Last update timestamp | Recorded by the Odoo ORM upon record modification. |
| product_categ_id | INTEGER | true | Foreign key to product category | Optional filter to apply the rule only to specific product categories. |
| account_prefix | VARCHAR | true | Account code prefix | Optional filter to apply the rule based on the start of the general account code. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `analytic_plan_id` → `staging.account_analytic_plan.id` (Guess: links to the analytic plan definition).
    - `company_id` → `staging.res_company.id` (Guess: standard Odoo multi-company link).
    - `product_categ_id` → `staging.product_category.id` (Guess: links to product classification).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- **Timestamps:** Timestamps are stored in the Odoo application server time (typically UTC), but verify against the source system configuration.
- **Soft Deletes:** This table does not appear to implement a soft-delete flag; assume it contains the current state of the Odoo configuration.
- **Data Sensitivity:** Contains internal system IDs and configuration logic; no direct PII, but sensitive in terms of financial reporting configuration.
- **Precision:** `VARCHAR` lengths are not explicitly defined in the source metadata; assume standard Odoo field lengths (often 255 or 1024) and validate if truncations occur during downstream ingestion.