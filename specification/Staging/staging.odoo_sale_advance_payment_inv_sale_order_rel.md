# odoo_sale_advance_payment_inv_sale_order_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` combined with the specific module prefix `sale_advance_payment_inv` indicates this is a standard Odoo many-to-many join table used to link advance payment wizard records to specific sales orders.

## Functional process 
This table supports the "Order-to-Cash" process, specifically handling the creation of down payments or advance invoices. It tracks the relationship between an advance payment request (often generated via a wizard) and the sales orders that the payment is being applied against.

## Description
One row represents a single association between an advance payment invoice record and a sales order. This is a junction table used to resolve a many-to-many relationship, ensuring that advance payments can be linked to one or more sales orders during the invoicing workflow. It serves as a raw landing copy of the Odoo relational mapping.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| sale_advance_payment_inv_id | INTEGER | false | Foreign key to the advance payment wizard/invoice record | Maps to the primary key of the Odoo `sale.advance.payment.inv` model. |
| sale_order_id | INTEGER | false | Foreign key to the sales order record | Maps to the primary key of the Odoo `sale.order` model. |

## Keys

- **Primary key (inferred):** The combination of `(sale_advance_payment_inv_id, sale_order_id)` is the composite primary key.
- **Foreign keys (inferred):** 
    - `sale_advance_payment_inv_id` → `staging.sale_advance_payment_inv.id` (Inferred from Odoo naming conventions).
    - `sale_order_id` → `staging.sale_order.id` (Inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table contains no surrogate primary key; always join or filter using the composite key `(sale_advance_payment_inv_id, sale_order_id)`.
- As a raw staging table, it may contain orphaned records if the upstream Odoo system performed a hard delete on the parent `sale_order` or `sale_advance_payment_inv` records.
- There is no audit timestamp (e.g., `create_date` or `write_date`) present in this table; incremental loading logic must rely on the parent tables or full-table replacement.