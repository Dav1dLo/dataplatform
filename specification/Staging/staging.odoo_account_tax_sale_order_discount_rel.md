# odoo_account_tax_sale_order_discount_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's ORM, which automatically generates join tables for many-to-many relationships between business objects, in this case linking sales order discounts to tax definitions.

## Functional process 
This table supports the tax calculation process within the sales order management module. It acts as a bridge to associate specific tax rules (VAT, sales tax, etc.) with discount line items applied to sales orders, ensuring that tax liabilities are correctly calculated based on the net value of discounted line items.

## Description
One row in this table represents a single association between a sales order discount record and an account tax record. It is a raw landed copy of an Odoo many-to-many join table, serving as the primary link for downstream models to resolve tax applications on discounted sales transactions.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_discount_id | INTEGER | false | Foreign key to the sale order discount entity | Maps to the primary key of the discount record. |
| account_tax_id | INTEGER | false | Foreign key to the account tax entity | Maps to the primary key of the tax definition. |

## Keys

- **Primary key (inferred):** The combination of `(sale_order_discount_id, account_tax_id)` forms the composite primary key.
- **Foreign keys (inferred):** 
    - `sale_order_discount_id` → `sale_order_discount.id` (Inferred from Odoo naming convention for many-to-many relations).
    - `account_tax_id` → `account_tax.id` (Inferred from Odoo naming convention for many-to-many relations).
- **Natural keys (inferred):** Not confidently inferable.

## Caveats for downstream consumers

- This table is a pure join table; it contains no business data other than the relationship identifiers.
- Ensure inner joins are used when traversing this table, as orphaned records are unlikely given Odoo's internal referential integrity constraints.
- There are no timestamps or audit columns present; this table reflects the current state of relationships as captured during the last ingestion.