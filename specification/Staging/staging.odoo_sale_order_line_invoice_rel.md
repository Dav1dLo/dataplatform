# odoo_sale_order_line_invoice_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the presence of `invoice_line_id` and `order_line_id` are characteristic of Odoo's many-to-many join tables used to link sales order lines to their corresponding invoice lines.

## Functional process 
This table supports the Order-to-Cash process by maintaining the relationship between sales order lines and invoice lines. It allows the system to track which specific items from a sales order have been billed on which invoices, facilitating revenue recognition and order fulfillment tracking.

## Description
One row in this table represents a single association between a sales order line and an invoice line. It serves as a raw landing copy of the Odoo relational bridge table, enabling the reconstruction of the link between sales and billing entities in downstream layers.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_line_id | INTEGER | false | Foreign key to the invoice line record | Links to the `account_move_line` table in Odoo. |
| order_line_id | INTEGER | false | Foreign key to the sales order line record | Links to the `sale_order_line` table in Odoo. |

## Keys

- **Primary key (inferred):** The combination of `(invoice_line_id, order_line_id)` is the inferred primary key.
- **Foreign keys (inferred):** 
    - `invoice_line_id → account_move_line.id`: This column references the specific line item on an invoice.
    - `order_line_id → sale_order_line.id`: This column references the specific line item on a sales order.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships if partial invoicing is supported by the source configuration.
- There are no timestamps or audit columns present; incremental loading logic cannot rely on this table for change detection.
- Ensure joins to `account_move_line` and `sale_order_line` handle potential orphans if the source system performs hard deletes.