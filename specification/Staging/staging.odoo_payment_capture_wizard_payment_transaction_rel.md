# odoo_payment_capture_wizard_payment_transaction_rel

## Source system
This table originates from Odoo ERP. The naming convention `_rel` is characteristic of Odoo's internal ORM mechanism for managing many-to-many relationship tables between two entities, in this case, a payment capture wizard and a payment transaction.

## Functional process 
This table supports the payment processing and reconciliation pipeline. It acts as a join table that links specific payment capture wizard sessions to the corresponding payment transactions being processed, ensuring that the wizard interface maintains a record of which transactions are associated with a specific capture operation.

## Description
Each row represents a single association between a payment capture wizard instance and a payment transaction. As a staging table, it provides a raw, direct mapping of the many-to-many relationship as it exists in the Odoo database, serving as the foundation for reconstructing transaction-to-wizard links in downstream models.

## Columns

| Column | Type | Nullable | Meaning | Notes |
| :--- | :--- | :--- | :--- | :--- |
| payment_capture_wizard_id | INTEGER | false | Foreign key to the payment capture wizard instance | Links to the wizard session record. |
| payment_transaction_id | INTEGER | false | Foreign key to the payment transaction record | Links to the specific transaction being captured. |

## Keys

- **Primary key (inferred):** The combination of `payment_capture_wizard_id` and `payment_transaction_id` acts as the composite primary key.
- **Foreign keys (inferred):** 
    - `payment_capture_wizard_id` → `staging.payment_capture_wizard.id` (inferred from Odoo naming conventions).
    - `payment_transaction_id` → `staging.payment_transaction.id` (inferred from Odoo naming conventions).
- **Natural keys (inferred):** Not confidently inferable from the provided metadata.

## Caveats for downstream consumers

- This table is a pure join table; it contains no descriptive attributes, only identifiers.
- There are no timestamps or audit columns present in this table; temporal analysis must be performed by joining to the parent `payment_transaction` or `payment_capture_wizard` tables.
- Ensure that joins to this table are performed on both columns to maintain the integrity of the many-to-many relationship.