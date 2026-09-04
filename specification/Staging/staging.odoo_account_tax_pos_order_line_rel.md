# odoo_account_tax_pos_order_line_rel

## Source system
This table originates from Odoo ERP. The naming convention `account_tax_pos_order_line_rel` is characteristic of Odoo's automated many-to-many relationship tables, which link tax definitions to specific point-of-sale order line items.

## Functional process 
This table supports the tax calculation and reporting process within the Point of Sale (POS) module. It acts as a join table to associate multiple tax rates (e.g., VAT, sales tax) with individual line items on a POS order, ensuring that financial reporting can correctly attribute tax liabilities to specific sales transactions.

## Description
One row represents a single association between a specific POS order line and a tax record. It is a raw landing of a join table used to resolve many-to-many relationships between order lines and tax configurations.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| pos_order_line_id | INTEGER | false | Foreign key to the POS order line | Links to the specific line item in the POS order. |
| account_tax_id | INTEGER | false | Foreign key to the tax definition | Identifies the tax rate or rule applied to the line item. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of `(pos_order_line_id, account_tax_id)`.
- **Foreign keys (inferred):** 
    - `pos_order_line_id` → `pos_order_line.id`: This column references the primary key of the POS order line table.
    - `account_tax_id` → `account_tax.id`: This column references the primary key of the tax configuration table.
- **Natural keys (inferred):** The combination of `(pos_order_line_id, account_tax_id)` acts as the unique business key for this relationship.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; rely on the parent `pos_order` or `pos_order_line` tables for temporal context.
- Ensure inner joins are used when aggregating tax data to avoid orphaned records if the source system has inconsistent referential integrity.