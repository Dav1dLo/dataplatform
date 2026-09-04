# odoo_account_tax_filiation_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_tax_filiation_rel` is characteristic of Odoo's internal relational mapping tables, specifically used to manage hierarchical relationships between tax objects (e.g., tax groups or compound taxes).

## Functional process 
This table supports the tax configuration and calculation process. It defines the parent-child relationships between tax records, allowing Odoo to aggregate multiple sub-taxes under a single parent tax for reporting or calculation purposes.

## Description
One row in this table represents a single link between a parent tax and a child tax. It is a raw landing copy of the Odoo relational join table, used to maintain the hierarchical structure of tax definitions within the accounting module.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| parent_tax | INTEGER | false | Foreign key to the parent tax record | References the primary tax ID. |
| child_tax | INTEGER | false | Foreign key to the child tax record | References the sub-tax ID. |

## Keys

- **Primary key (inferred):** The combination of `(parent_tax, child_tax)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `parent_tax` → `account_tax.id`: This column links to the parent tax definition in the Odoo tax master table.
    - `child_tax` → `account_tax.id`: This column links to the child tax definition in the Odoo tax master table.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a join table; it contains no descriptive attributes, only relational links.
- There are no timestamps or audit columns present; incremental loading logic must rely on full table refreshes or Odoo's internal `write_date` if available in a different table.
- Ensure that queries joining this table to `account_tax` handle potential circular references if the Odoo configuration allows for recursive tax definitions.