# odoo_account_move_purchase_order_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` and the pairing of `purchase_order_id` with `account_move_id` are characteristic of Odoo's internal many-to-many relationship tables used to link procurement documents (Purchase Orders) to financial accounting entries (Account Moves/Invoices).

## Functional process 
This table supports the Procure-to-Pay (P2P) business process by maintaining the link between purchase orders and their corresponding accounting documents. It enables the reconciliation of financial liabilities against authorized procurement commitments.

## Description
One row in this table represents a single association between a specific purchase order and an accounting move. It serves as a raw, junction-table copy from the Odoo source system, facilitating the mapping of financial transactions to their originating procurement records.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| purchase_order_id | INTEGER | false | Foreign key to the purchase order record | References the primary key of the purchase order table. |
| account_move_id | INTEGER | false | Foreign key to the accounting move record | References the primary key of the account move table. |

## Keys

- **Primary key (inferred):** Not confidently inferable from the provided metadata; likely a composite primary key on `(purchase_order_id, account_move_id)`.
- **Foreign keys (inferred):** 
    - `purchase_order_id → purchase_order.id`: Links to the source purchase order entity.
    - `account_move_id → account_move.id`: Links to the source accounting move entity.
- **Natural keys (inferred):** The combination of `(purchase_order_id, account_move_id)` acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; expect many-to-many relationships between purchase orders and account moves.
- No audit timestamps (e.g., `created_at`) are present; incremental loading logic must rely on the source system's change-tracking or full-table replacement.
- There are no soft-delete flags; assume rows are removed from this table when the relationship is severed in the source system.