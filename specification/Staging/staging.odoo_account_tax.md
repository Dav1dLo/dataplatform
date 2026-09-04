# odoo_account_tax

## Source system
This table originates from Odoo ERP, specifically the accounting module. The naming convention (e.g., `company_id`, `tax_group_id`, `type_tax_use`) and the use of `JSONB` for multi-language labels are characteristic of Odoo's PostgreSQL schema structure.

## Functional process 
This table supports the tax configuration and calculation process within the financial accounting module. It defines the tax rates, application scope (sales/purchases), and accounting behavior (cash basis vs. accrual) required for generating compliant invoices and financial reports.

## Description
One row in this table represents a single tax definition or rate configured within the Odoo accounting system. It serves as a raw landed copy of the `account.tax` model, capturing the configuration parameters, calculation logic, and metadata for each tax entity.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| id | INTEGER | false | Surrogate primary key | Uses sequence `staging.account_tax_id_seq`. |
| company_id | INTEGER | false | Foreign key to the owning company | Links to the Odoo `res.company` table. |
| sequence | INTEGER | false | Display/calculation order | Used to determine the priority of tax application. |
| tax_group_id | INTEGER | false | Foreign key to tax group | Links to the Odoo `account.tax.group` table. |
| cash_basis_transition_account_id | INTEGER | true | Account for cash basis accounting | Links to `account.account` for deferred tax handling. |
| country_id | INTEGER | false | Foreign key to country | Links to `res.country` for regional tax compliance. |
| create_uid | INTEGER | true | User ID who created the record | Links to `res.users`. |
| write_uid | INTEGER | true | User ID who last modified the record | Links to `res.users`. |
| type_tax_use | VARCHAR | false | Tax application scope | Typically 'sale', 'purchase', or 'none'. |
| tax_scope | VARCHAR | true | Scope of the tax | Defines if the tax applies to services or goods. |
| amount_type | VARCHAR | false | Calculation method | e.g., 'percent', 'fixed', 'group'. |
| price_include_override | VARCHAR | true | Price inclusion behavior | Overrides default tax-included-in-price settings. |
| tax_exigibility | VARCHAR | true | Tax exigibility rule | 'on_invoice' or 'on_payment' (cash basis). |
| name | JSONB | false | Tax name | Multi-language label stored as JSON. |
| description | JSONB | true | Tax description | Multi-language label for invoice lines. |
| invoice_label | JSONB | true | Label for invoice documents | Multi-language label for printed documents. |
| invoice_legal_notes | TEXT | true | Legal notes for invoices | Free-text field for regulatory disclosures. |
| amount | NUMERIC | false | Tax rate or fixed amount | Interpretation depends on `amount_type`. |
| active | BOOLEAN | true | Soft-delete flag | If false, the tax is archived/disabled. |
| include_base_amount | BOOLEAN | true | Include in base amount | Whether this tax affects the base for other taxes. |
| is_base_affected | BOOLEAN | true | Affected by base | Whether this tax is calculated on a base amount. |
| analytic | BOOLEAN | true | Analytic accounting flag | Whether this tax triggers analytic entries. |
| create_date | TIMESTAMP | true | Record creation timestamp | UTC assumed. |
| write_date | TIMESTAMP | true | Last modification timestamp | UTC assumed. |

## Keys

- **Primary key (inferred):** `id`
- **Foreign keys (inferred):** 
    - `company_id` → `res_company.id` (Standard Odoo multi-company architecture)
    - `tax_group_id` → `account_tax_group.id` (Categorizes taxes for reporting)
    - `country_id` → `res_country.id` (Determines regional tax applicability)
    - `cash_basis_transition_account_id` → `account_account.id` (Links to the chart of accounts)
- **Natural keys (inferred):** 
    - None confidently inferable; Odoo relies on the surrogate `id` for internal linking.

## Caveats for downstream consumers

- **Sensitive Data:** No direct PII, but contains financial configuration data that should be restricted to finance/accounting users.
- **Timestamps:** Assumed to be in UTC, consistent with standard Odoo deployments.
- **Soft Deletes:** The `active` column acts as a soft-delete flag; ensure queries filter by `active = true` to retrieve only currently valid taxes.
- **JSONB Fields:** `name`, `description`, and `invoice_label` are `JSONB` types; use `->>` operator in PostgreSQL to extract the string value (e.g., `name->>'en_US'`).
- **Data Grain:** This is a configuration table; it does not contain transaction history, only the definitions used to calculate taxes on transactions.