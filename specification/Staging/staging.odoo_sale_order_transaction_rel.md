# odoo_sale_order_transaction_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal ORM mechanism for managing many-to-many relationship tables between core business entities, in this case, linking sales orders to payment transactions.

## Functional process 
This table supports the order-to-cash process by maintaining the association between sales orders and their corresponding payment transactions. It allows the system to track which financial transactions have been applied to specific sales orders, facilitating reconciliation and payment status tracking.

## Description
One row in this table represents a single link between a specific sales order and a payment transaction. It serves as a raw junction table in the staging layer, capturing the many-to-many relationship as it exists in the Odoo database schema.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| transaction_id | INTEGER | false | Foreign key to the payment transaction record | Maps to the primary key of the transaction entity. |
| sale_order_id | INTEGER | false | Foreign key to the sales order record | Maps to the primary key of the sale_order entity. |

## Keys

- **Primary key (inferred):** The combination of `(transaction_id, sale_order_id)` is the inferred composite primary key.
- **Foreign keys (inferred):** 
    - `transaction_id → payment_transaction.id`: Links to the transaction record.
    - `sale_order_id → sale_order.id`: Links to the sales order record.
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This is a junction table; expect many-to-many relationships where one order may have multiple transactions and vice versa.
- There are no audit timestamps (e.g., `created_at`) in this table; rely on the parent entities for temporal context.
- Ensure inner joins are used when filtering for active relationships, as this table contains only the mapping identifiers.