# odoo_account_tax_sale_order_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_tax_sale_order_line_rel` is characteristic of Odoo's automated many-to-many relationship tables, which are generated to link tax definitions to specific line items within sales orders.

## Functional process 
This table supports the order-to-cash process by mapping applicable tax rates to individual sales order line items. It ensures that financial calculations for sales orders correctly associate the relevant tax entities (e.g., VAT, sales tax) with the products or services being sold.

## Description
One row in this table represents a single association between a specific sales order line and a tax record. It acts as a join table in the staging layer, providing a raw, normalized link between the sales order line items and the tax configuration entities.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_order_line_id | INTEGER | false | Foreign key to the sales order line | Links to the primary key of the sales order line table. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Links to the primary key of the account tax table. |

## Keys

- **Primary key (inferred):** The combination of `(sale_order_line_id, account_tax_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `sale_order_line_id` → `sale_order_line.id`: This column references the specific line item within a sales order.
    - `account_tax_id` → `account_tax.id`: This column references the tax definition applied to the line.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes other than the two foreign keys.
- There is no surrogate primary key column; queries should join on the composite key or use the pair to identify unique relationships.
- As a staging table, this represents a raw snapshot of the Odoo database relationship; ensure that downstream models handle potential orphan records if referential integrity is not strictly enforced in the source.