# odoo_product_taxes_rel

## Source system
This table originates from Odoo ERP, a modular business management software. The naming convention `_rel` is characteristic of Odoo's internal ORM mechanism for managing many-to-many relationship tables between two entities.

## Functional process 
This table supports the product configuration and accounting process by mapping products to their applicable tax rates. It ensures that when a product is added to a sales order or invoice, the system can automatically calculate the correct tax liability based on the product's tax configuration.

## Description
One row in this table represents a single association between a product and a tax record. It acts as a join table at the grain of one row per product-tax pair, serving as a raw landing of the Odoo relational link table to facilitate downstream modeling of tax-inclusive or tax-exclusive pricing.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| prod_id | INTEGER | false | Foreign key to the product definition | References the primary product record. |
| tax_id | INTEGER | false | Foreign key to the tax definition | References the specific tax rate or rule. |

## Keys

- **Primary key (inferred):** The combination of `(prod_id, tax_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `prod_id` → `product_template.id` (or `product_product.id`): This column links to the product master data.
    - `tax_id` → `account_tax.id`: This column links to the tax configuration master data.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; ensure joins are performed on the composite key `(prod_id, tax_id)`.
- As a raw staging table, it does not contain descriptive names; join with the corresponding master tables to retrieve product names or tax percentages.
- This table represents a many-to-many relationship; a single `prod_id` may appear multiple times if multiple taxes apply to one product.