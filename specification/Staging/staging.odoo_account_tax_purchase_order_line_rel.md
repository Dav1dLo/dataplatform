# odoo_account_tax_purchase_order_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_tax_purchase_order_line_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link purchase order line items to their applicable tax records.

## Functional process 
This table supports the procurement and accounts payable process by mapping specific tax rules to individual purchase order line items. It ensures that financial reporting and tax calculations can be correctly attributed to the goods or services requested in a purchase order.

## Description
One row in this table represents a single association between a purchase order line and a tax record. It acts as a join table in the staging layer, preserving the raw many-to-many relationship between purchase order lines and tax definitions as extracted from the Odoo database.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_line_id | INTEGER | false | Foreign key to the purchase order line | Links to the primary key of the purchase order line table. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Links to the primary key of the account tax table. |

## Keys

- **Primary key (inferred):** The composite key `(purchase_order_line_id, account_tax_id)` is the inferred primary key, as this is a standard join table structure in Odoo.
- **Foreign keys (inferred):** 
    - `purchase_order_line_id` → `purchase_order_line.id`: This column references the specific line item within a purchase order.
    - `account_tax_id` → `account_tax.id`: This column references the tax configuration applied to the line item.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; queries should join on the composite pair of IDs.
- As a join table, this record is typically created when a tax is applied to a line and deleted if the tax is removed; it does not contain its own lifecycle timestamps.
- Ensure that downstream joins handle potential duplicates if the source system allows multiple identical tax applications (though Odoo typically enforces uniqueness on this relation).