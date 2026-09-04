# odoo_account_invoice_transaction_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal ORM-generated join tables used to manage many-to-many relationships between business entities, specifically linking invoices to payment transactions.

## Functional process 
This table supports the financial reconciliation and payment tracking process. It maps individual customer invoices to the specific payment transactions that settle them, enabling the system to track which payments have been applied to which invoices in the accounting module.

## Description
One row in this table represents a single association between an invoice and a payment transaction. It serves as a raw, junction-table copy from the Odoo database, capturing the many-to-many relationship required to resolve invoice settlement status.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| invoice_id | INTEGER | false | Foreign key to the invoice record | References the primary key of the invoice table. |
| transaction_id | INTEGER | false | Foreign key to the transaction record | References the primary key of the payment transaction table. |

## Keys

- **Primary key (inferred):** Not confidently inferable; likely a composite key of (`invoice_id`, `transaction_id`).
- **Foreign keys (inferred):** 
    - `invoice_id` → `account_invoice.id`: This column links to the main invoice entity.
    - `transaction_id` → `account_payment.id`: This column links to the payment transaction entity.
- **Natural keys (inferred):** The combination of (`invoice_id`, `transaction_id`) acts as the natural business key for this relationship.

## Caveats for downstream consumers

- This table is a junction table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present; it is impossible to determine the order of operations or the time of creation from this table alone.
- Ensure joins to the parent tables handle potential orphans if the source system's referential integrity is not strictly enforced.